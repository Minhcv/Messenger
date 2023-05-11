import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/services/db_service.dart';
import 'package:messenger/services/navigation_service.dart';
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
  late User? user;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _checkCurrentUserIsAuthenticated();
  }

  void _autoLogin() async {
    if (user != null) {
      await DbService.instance.updateUserLastSeenTime(user!.uid);
      return NavigationService.instance.navigateToReplacement("home");
    }
  }

  void _checkCurrentUserIsAuthenticated() async {
    user = await _auth.currentUser!;
    if (user != null) {
      notifyListeners();
      _autoLogin();
    }
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.authenticated;
      SnackbarService.instance.showSnackBarSuccess("Welcome, ${user!.email}");
      return NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      status = AuthStatus.error;
      user = null;
      SnackbarService.instance.showSnackBarError("Error Authenticating");
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.authenticated;
      await onSuccess(user!.uid);
      SnackbarService.instance.showSnackBarSuccess("Welcome, ${user!.email}");
      await DbService.instance.updateUserLastSeenTime(user!.uid);
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      status = AuthStatus.error;
      // user = null;
      SnackbarService.instance.showSnackBarError("Error Registering User");
    }
    notifyListeners();
  }

  void logoutUser(Future<void> onSuccess()) async {
    try {
      await _auth.signOut();
      status = AuthStatus.notAuthenticated;
      await onSuccess();
      await NavigationService.instance.navigateToReplacement("login");
      SnackbarService.instance.showSnackBarSuccess("Logged Out Successfully!");
    } catch (e) {
      SnackbarService.instance.showSnackBarError("Error Logging Out");
    }
    notifyListeners();
  }
}
