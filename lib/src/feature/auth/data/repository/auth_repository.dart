import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app/error/error.dart';
import '../../../../app/local_storage/user/user_hive.dart';
import '../../../../app/service_locator/service_locator.dart';
import '../interface/auth_interface.dart';

class AuthRepository extends IAuth {
  final SupabaseClient _client;

  AuthRepository({
    required SupabaseClient client,
  }) : _client = client;

  @override
  Either<Session, Failure> getCurrentSession() {
    try {
      Session? session = _client.auth.currentSession;
      if (session != null) {
        return Left(session);
      } else {
        return const Right(Failure(message: 'Session not found or Ended'));
      }
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
  }

  @override
  Either<User, Failure> getCurrentUser() {
    try {
      User? user = _client.auth.currentUser;
      if (user != null) {
        return Left(user);
      } else {
        return const Right(Failure(message: 'User not found'));
      }
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<AuthResponse, Failure>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        sl<UserHive>().saveLocalUser(
          username: response.user!.userMetadata!['username'],
          email: email,
        );
      }

      return Left(response);
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<AuthResponse, Failure>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      if (response.session != null) {
        sl<UserHive>().saveLocalUser(
          username: username,
          email: email,
        );
      }

      return Left(response);
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
  }
}
