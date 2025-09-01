import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("🎓 Student Dashboard"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.logout(); // 👈 Logs out & returns to login
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome Student!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
