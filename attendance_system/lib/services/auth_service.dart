import 'package:flutter/material.dart';

class UserModel {
  final String email;
  final String role; // "teacher" or "student"

  UserModel({required this.email, required this.role});
}

class AuthService extends ChangeNotifier {
  bool isAuthenticated = false;
  UserModel? currentUser;

  Future<void> login(String email, String password) async {
    // 👉 Fake logic for now (replace with Firebase/Auth API later)
    await Future.delayed(const Duration(seconds: 1));

    if (email.contains("teacher")) {
      currentUser = UserModel(email: email, role: "teacher");
    } else {
      currentUser = UserModel(email: email, role: "student");
    }

    isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    isAuthenticated = false;
    currentUser = null;
    notifyListeners();
  }
}
