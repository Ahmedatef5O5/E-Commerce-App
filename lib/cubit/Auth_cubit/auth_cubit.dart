import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) {
    emit(AuthLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(AuthSuccess(message: 'Login Successfully!'));
    });
  }

  void register(String username, String email, String password) {
    emit(AuthLoading());
    Future.delayed(Duration(seconds: 1), () {
      emit(AuthSuccess(message: 'Account Created Successfully!'));
    });
  }
}
