import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'teacher_screen.dart';
import 'student_screen.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // Debug log
    if (kDebugMode) {
      logger.d(
          "AuthWrapper build - isAuthenticated: ${authService.isAuthenticated}, "
          "currentUser: ${authService.currentUser}");
    }

    if (!authService.isAuthenticated || authService.currentUser == null) {
      if (kDebugMode) logger.d("Showing LoginScreen");
      return const LoginScreen();
    }

    final role = authService.currentUser!.role;

    if (role == 'teacher') {
      if (kDebugMode) logger.d("Showing TeacherScreen");
      return const TeacherScreen();
    } else if (role == 'student') {
      if (kDebugMode) logger.d("Showing StudentScreen");
      return const StudentScreen();
    } else {
      // fallback (if role is unknown)
      return const LoginScreen();
    }
  }
}
