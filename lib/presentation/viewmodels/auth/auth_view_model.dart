import 'package:flutter/material.dart';
import 'package:test_transisi/core/storage/storage.dart';
import 'package:test_transisi/services/api/auth_api.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthApi _api = AuthApi();

  bool isLoading = false;
  String? token;
  String? errorMessage;

  void init() {
    token = Storage.getToken();
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await _api.login(email, password);
      token = result;

      await Storage.saveToken(result);
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception: ", "");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    Storage.clearSession();
    token = null;
    notifyListeners();
  }

  bool get isLoggedIn => token != null;
}
