import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/theme.dart'; // Make sure this import is correct for your AppColors

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String location = '';

  Future<void> _updateLocation(String newLocation) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'location': newLocation},
      );
      setState(() {
        location = newLocation;
      });
    }
  }

  void _showEditLocationDialog(String currentLocation) {
    final controller = TextEditingController(text: currentLocation);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Update Location'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter your location',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _updateLocation(controller.text.trim());
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.pnpGold,
        iconTheme: const IconThemeData(color: AppColors.pnpBlue),
        titleTextStyle: const TextStyle(
          color: AppColors.pnpBlue,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
          location = data['location'] ?? '';
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: AppColors.pnpWhite,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: AppColors.pnpGold,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.pnpBlue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              data['name'] ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ListTile(
                        leading: const Icon(
                          Icons.email,
                          color: AppColors.pnpBlue,
                        ),
                        title: const Text(
                          'Username/Email:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(data['email'] ?? ''),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.bar_chart,
                          color: AppColors.pnpBlue,
                        ),
                        title: const Text(
                          'Access Count:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${data['accessCount'] ?? 1}'),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          color: AppColors.pnpBlue,
                        ),
                        title: const Text(
                          'Location:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          location.isNotEmpty ? location : 'Not set',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: AppColors.pnpRed),
                          onPressed: () => _showEditLocationDialog(location),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
