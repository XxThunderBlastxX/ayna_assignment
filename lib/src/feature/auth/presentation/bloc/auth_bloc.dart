import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app/error/error.dart';
import '../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;

  AuthBloc({
    required AuthRepository authRepo,
  })  : _authRepo = authRepo,
        super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await _authRepo.signIn(
        email: event.email,
        password: event.password,
      );

      response.fold(
        (authResponse) => emit(AuthSuccess(user: authResponse.user!)),
        (failure) => emit(AuthFailure(failure: failure)),
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await _authRepo.signUp(
        username: event.username,
        email: event.email,
        password: event.password,
      );
      response.fold(
        (authResponse) => emit(AuthSuccess(user: authResponse.user!)),
        (failure) => emit(AuthFailure(failure: failure)),
      );
    });
  }
}
