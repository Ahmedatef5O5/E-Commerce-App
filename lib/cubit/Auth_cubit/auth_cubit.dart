import 'package:ecommerce_app/models/user_data_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utilities/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServices _authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;
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

  Future<void> _saveUserData(String email, String username) async {
    final currentUser = _authServices.getCurrentUser();
    final userData = UserDataModel(
      id: currentUser!.uid,
      username: username,
      email: email,
      createdAt: DateTime.now().toIso8601String(),
    );
    await firestoreServices.setData(
      path: ApiPaths.users(userData.id),
      data: userData.toMap(),
      // send data to fireStore Database as Map
      // data: {
      //   'id': currentUser.uid,
      //   'email': currentUser.email,
      //   'username': username,
      //   'createdAt': DateTime.now().toIso8601String(),
      // },
    );
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
        await _saveUserData(email, username);
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
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      await _authServices.logout();
      await Future.delayed(Duration(seconds: 1)); // optional delaying
      emit(const AuthLoggedout());
    } on Exception catch (e) {
      emit(AuthLoggoutError(errMsg: e.toString()));
    }
  }

  Future<void> authenticateWithGoogle() async {
    emit(const GoogleAuthenticating());
    try {
      final res = await _authServices.authenticateWithGoogle();
      if (res) {
        emit(const GoogleAuthenticatedDone());
      } else {
        emit(GoogleAuthError(errMsg: 'Google authentication failed'));
      }
    } catch (e) {
      emit(GoogleAuthError(errMsg: e.toString()));
    }
  }

  Future<void> authenticateWithFacebook() async {
    emit(const FacebookAuthenticating());
    try {
      final res = await _authServices.authenticateWithFacebook();
      if (res) {
        emit(const FacebookAuthenticatedDone());
      } else {
        emit(FacebookAuthError(errMsg: 'Facebook authentication failed'));
      }
    } catch (e) {
      emit(FacebookAuthError(errMsg: e.toString()));
    }
  }
}
