// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:justifind_capstone_2_final/theme/theme.dart';
import 'package:justifind_capstone_2_final/screens/crimes/crime_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get all special laws from lawDetails
    final specialLawList = lawDetails.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Laws'),
        backgroundColor: AppColors.charcoal,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkIndigo, AppColors.steelGray],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Special Laws & Provisions',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Learn about special laws provided by PNP Aparri',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // Special Laws List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: specialLawList.length,
              itemBuilder: (context, index) {
                final law = specialLawList[index].value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.darkIndigo, AppColors.steelGray],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(
                        law['title'] ?? '',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        law['summary'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text(law['title'] ?? ''),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        law['summary'] ?? '',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          color:
                                              Colors
                                                  .black87, 
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Key Provisions:',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          color:
                                              Colors
                                                  .black87, 
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        law['keyProvisions'] ?? '',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          color:
                                              Colors
                                                  .black87, 
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.charcoal,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkIndigo, AppColors.steelGray],
              ),
            ),
            child: const Text(
              'Justi-Find',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: AppColors.softSilver),
            title: Text(
              'Home',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.admin_panel_settings,
              color: AppColors.softSilver,
            ),
            title: Text(
              'Admin Access',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/admin-login');
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: AppColors.softSilver),
            title: Text(
              'About',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          const Divider(color: AppColors.steelGray),
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.softSilver),
            title: Text(
              'Sign Out',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
    );
  }
}

Future<void> incrementAccessCount() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    await userDoc.update({'accessCount': FieldValue.increment(1)});
  }
}
