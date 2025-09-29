import 'package:flutter/material.dart';
import '../../THEME/theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.darkIndigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/admin-login'),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Admin Dashboard - Coming Soon',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}