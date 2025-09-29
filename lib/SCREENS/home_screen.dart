// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:justifind_capstone_2_final/theme/theme.dart';
import 'package:justifind_capstone_2_final/screens/crimes/crime_detail_screen.dart';
import 'package:justifind_capstone_2_final/models/crime_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Add the crimes list here
  final List<Crime> crimes = const [
    Crime(
      title: "Theft",
      description: "Unauthorized taking of someone else's property",
      severity: "High",
      color: Colors.orange,
      category: "Property Crime",
      laws: {"RA 3815": "Theft and Robbery"},
      penalties: ["Imprisonment", "Fines"],
      preventionTips: ["Lock doors", "Keep valuables secure"],
    ),
    Crime(
      title: "Assault",
      description: "Physical attack or threat of attack",
      severity: "High",
      color: Colors.red,
      category: "Violent Crime",
      laws: {"RA 3815": "Assault and Battery"},
      penalties: ["Imprisonment", "Fines"],
      preventionTips: ["Avoid conflicts", "Seek help"],
    ),
    Crime(
      title: "Burglary",
      description: "Unlawful entry into a building to commit a crime",
      severity: "Medium",
      color: Colors.blue,
      category: "Property Crime",
      laws: {"RA 3815": "Burglary"},
      penalties: ["Imprisonment", "Fines"],
      preventionTips: ["Install alarms", "Use strong locks"],
    ),
    // Optional: Additional common crimes in the Philippines
    Crime(
      title: "Estafa (Swindling)",
      description: "Deception for unlawful gain through false pretenses",
      severity: "Medium",
      color: Colors.amber,
      category: "White-Collar Crime",
      laws: {"RA 3815": "Revised Penal Code - Estafa"},
      penalties: ["4-20 years imprisonment", "Restitution", "Fines"],
      preventionTips: [
        "Verify transactions",
        "Avoid too-good-to-be-true offers",
        "Use official channels",
      ],
    ),

    Crime(
      title: "Cybercrime",
      description: "Criminal activities conducted through digital means",
      severity: "Medium",
      color: Colors.cyan,
      category: "Digital Crime",
      laws: {"RA 10175": "Cybercrime Prevention Act of 2012"},
      penalties: [
        "6-12 years imprisonment",
        "Fines up to ₱500,000",
        "Asset forfeiture",
      ],
      preventionTips: [
        "Use strong passwords",
        "Enable 2FA",
        "Avoid suspicious links",
        "Update security software",
      ],
    ),
    // Add more crimes as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Justi-Find'),
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
                  'Crime Prevention & Legal Information',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Learn about major crimes and their legal consequences',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // Quick Stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  crimes.length.toString(),
                  'Crimes Covered',
                  context,
                ),
                _buildStatCard('50+', 'Legal Articles', context),
                _buildStatCard('24/7', 'Access', context),
              ],
            ),
          ),

          // Crimes Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: crimes.length,
              itemBuilder: (context, index) {
                return _buildCrimeCard(crimes[index], context);
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
            leading: const Icon(Icons.home, color: AppColors.softSilver),
            title: const Text(
              'Home',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search, color: AppColors.softSilver),
            title: const Text(
              'Search Crimes',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.admin_panel_settings,
              color: AppColors.softSilver,
            ),
            title: const Text(
              'Admin Access',
              style: TextStyle(color: AppColors.softSilver),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/admin-login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: AppColors.softSilver),
            title: const Text(
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
            leading: const Icon(Icons.logout, color: AppColors.softSilver),
            title: const Text(
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

  Widget _buildStatCard(String value, String label, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildCrimeCard(Crime crime, BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrimeDetailScreen(crime: crime),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: crime.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  crime.category,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                crime.title,
                style: Theme.of(context).textTheme.displayMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                crime.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Chip(
                    label: Text(
                      crime.severity,
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor:
                        crime.severity.contains('High')
                            ? Colors.red.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.2),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
