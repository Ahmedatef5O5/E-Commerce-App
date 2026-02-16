part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String successMsg;

  AuthSuccess({required this.successMsg});
}

final class AuthError extends AuthState {
  final String errMsg;

  AuthError({required this.errMsg});
}
