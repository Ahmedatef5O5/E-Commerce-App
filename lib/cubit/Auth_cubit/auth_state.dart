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

final class Authenticated extends AuthState {}

final class AuthError extends AuthState {
  final String errMsg;

  AuthError({required this.errMsg});
}

final class AuthLoggingout extends AuthState {
  const AuthLoggingout();
}

final class AuthLoggedout extends AuthState {
  const AuthLoggedout();
}

final class AuthLoggoutError extends AuthState {
  final String errMsg;

  AuthLoggoutError({required this.errMsg});
}

final class GoogleAuthenticating extends AuthState {
  const GoogleAuthenticating();
}

final class GoogleAuthenticatedDone extends AuthState {
  const GoogleAuthenticatedDone();
}

final class GoogleAuthError extends AuthState {
  final String errMsg;

  GoogleAuthError({required this.errMsg});
}
