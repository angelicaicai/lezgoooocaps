// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Justi-Find'),
        backgroundColor: AppColors.charcoal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vision Section
            _buildSection(
              context,
              'Our Vision',
              'Bridging the gap between legal knowledge and everyday safety in the Philippines. We believe that an informed citizen is an empowered citizen.',
              Icons.lightbulb_outline,
            ),
            
            const SizedBox(height: 30),
            
            // Mission Section
            _buildSection(
              context,
              'Our Mission',
              'To democratize access to legal information by transforming complex criminal laws into understandable, actionable knowledge for every Filipino.',
              Icons.flag_outlined,
            ),
            
            const SizedBox(height: 30),
            
            // What Makes Us Different
            Card(
              elevation: 0,
              color: AppColors.darkIndigo.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.fingerprint, color: AppColors.darkIndigo),
                        const SizedBox(width: 10),
                        Text(
                          'What Makes Justi-Find Unique',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppColors.darkIndigo,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildUniqueFeature(
                      'Focused on 8 Key Crimes',
                      'We concentrate on the most prevalent crimes affecting Filipino communities',
                    ),
                    _buildUniqueFeature(
                      'From Legal Jargon to Plain Language',
                      'We translate complex legal terms into understandable information',
                    ),
                    _buildUniqueFeature(
                      'Prevention-First Approach',
                      'Empowering you with knowledge to protect yourself and your community',
                    ),
                    _buildUniqueFeature(
                      '🇵🇭 Built for Filipinos, by Filipinos',
                      'Contextualized specifically for Philippine laws and society',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // The Story Behind Justi-Find
            _buildSection(
              context,
              'Our Story',
              'Justi-Find was born from a simple observation: many Filipinos want to understand their legal rights and protections but find the legal system intimidating and inaccessible. We\'re here to change that.',
              Icons.history_edu_outlined,
            ),
            
            const SizedBox(height: 30),
            
            // Values
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Values',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildValueChip('Transparency', Icons.visibility_outlined),
                    _buildValueChip('Accessibility', Icons.accessibility_outlined),
                    
                    _buildValueChip('Community', Icons.people_outlined),
                    _buildValueChip('Integrity', Icons.shield_outlined),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Call to Action
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.darkIndigo, AppColors.steelGray],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Join Our Mission',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Together, we can build a safer, more legally-literate Philippines. Your awareness today prevents crime tomorrow.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.darkIndigo,
                    ),
                    child: const Text('Start Learning About Crimes'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Footer
            Center(
              child: Text(
                'Justi-Find © 2024 • Making Legal Knowledge Accessible',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.darkIndigo.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.darkIndigo, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUniqueFeature(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueChip(String value, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(value),
      backgroundColor: AppColors.steelGray.withOpacity(0.2),
    );
  }
}