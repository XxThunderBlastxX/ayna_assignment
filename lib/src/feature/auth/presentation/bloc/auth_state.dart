part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

final class AuthFailure extends AuthState {
  final Failure failure;

  const AuthFailure({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
