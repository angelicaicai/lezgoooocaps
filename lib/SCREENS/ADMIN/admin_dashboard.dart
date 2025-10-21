import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../theme/theme.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, int>> _getMostViewedLaws() async {
    final snapshot = await _firestore.collection('search_logs').get();
    final Map<String, int> counts = {};

    for (var doc in snapshot.docs) {
      final lawTitle = doc['lawTitle'];
      counts[lawTitle] = (counts[lawTitle] ?? 0) + 1;
    }

    return counts;
  }

  Future<Map<String, int>> _getUserActivity() async {
    final snapshot = await _firestore.collection('search_logs').get();
    final Map<String, int> userCounts = {};

    for (var doc in snapshot.docs) {
      final userEmail = doc['userEmail'];
      userCounts[userEmail] = (userCounts[userEmail] ?? 0) + 1;
    }

    return userCounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSectionTitle('📊 Most Viewed Special Laws'),
            FutureBuilder<Map<String, int>>(
              future: _getMostViewedLaws(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!;
                final sorted = data.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                return Card(
                  color: AppColors.cardBackground,
                  child: Column(
                    children: sorted.map((entry) {
                      return ListTile(
                        leading: Icon(Icons.book, color: AppColors.primaryColor),
                        title: Text(entry.key, style: TextStyle(color: AppColors.textPrimary)),
                        trailing: Text('${entry.value} views', style: TextStyle(color: AppColors.textSecondary)),
                      );
                    }).toList(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('👥 User Viewing Activity'),
            FutureBuilder<Map<String, int>>(
              future: _getUserActivity(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final userData = snapshot.data!;
                final sortedUsers = userData.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

                return Card(
                  color: AppColors.cardBackground,
                  child: Column(
                    children: sortedUsers.map((entry) {
                      return ListTile(
                        leading: Icon(Icons.person, color: AppColors.primaryColor),
                        title: Text(entry.key, style: TextStyle(color: AppColors.textPrimary)),
                        trailing: Text('${entry.value} views', style: TextStyle(color: AppColors.textSecondary)),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
