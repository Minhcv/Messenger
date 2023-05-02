import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/snackbar_service.dart';

enum AuthStatus {
  notAuthenticated,
  authenticating,
  authenticated,
  userNotFound,
  error,
}

class AuthProvider extends ChangeNotifier {
  late AuthStatus status = AuthStatus.notAuthenticated;
  late User user;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.authenticated;
      SnackbarService.instance.showSnackBarSuccess("Welcome, ${user.email}");
      // Navigate to homePage
    } catch (e) {
      status = AuthStatus.error;
      SnackbarService.instance.showSnackBarError("Error Authenticating");
    }
    notifyListeners();
  }
}
