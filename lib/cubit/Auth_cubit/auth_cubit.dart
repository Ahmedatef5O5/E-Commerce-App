import 'package:ecommerce_app/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServices _authServices = AuthServicesImpl();
  AuthCubit() : super(AuthInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthSuccess(successMsg: 'Login Successfully!'));
      } else {
        emit(AuthError(errMsg: 'Login Failed!'));
      }
    } catch (e) {
      emit(AuthError(errMsg: e.toString()));
    }
  }

  Future<void> registerWithEmailAndPassword(
    String username,
    String email,
    String password,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.registerWithEmailAndPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthSuccess(successMsg: 'Register Successfully!'));
      } else {
        emit(AuthError(errMsg: 'Register Failed!'));
      }
    } catch (e) {
      emit(AuthError(errMsg: e.toString()));
    }
  }

  void checkAuthStatus() async {
    await Future.delayed(Duration(seconds: 3));
    final user = _authServices.getCurrentUser();
    if (user != null) {
      emit(Authenticated());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    emit(const AuthLoggingout());
    try {
      await _authServices.logout();
      await Future.delayed(Duration(seconds: 1)); // optional delaying
      emit(const AuthLoggedout());
    } on Exception catch (e) {
      emit(AuthLoggoutError(errMsg: e.toString()));
    }
  }
}
