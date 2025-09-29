// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:justifind_capstone_2_final/models/crime_model.dart'; // Fixed import path
import 'package:justifind_capstone_2_final/theme/theme.dart';

class CrimeDetailScreen extends StatelessWidget {
  final Crime crime;

  const CrimeDetailScreen({super.key, required this.crime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crime.title),
        backgroundColor: crime.color,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crime Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: crime.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crime.title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    crime.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      'Severity: ${crime.severity}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: crime.severity.contains('High') 
                        ? Colors.red 
                        : Colors.blue,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Laws Section
            _buildSection(
              context,
              '📚 Legal Laws & Provisions',
              crime.laws.entries.map((e) => '• ${e.key}: ${e.value}').toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Penalties Section
            _buildSection(
              context,
              '⚖️ Penalties & Consequences',
              crime.penalties,
            ),
            
            const SizedBox(height: 16),
            
            // Prevention Tips Section
            _buildSection(
              context,
              '🛡️ Prevention Tips',
              crime.preventionTips,
            ),
            
            const SizedBox(height: 30),
            
            // Emergency Contacts
            _buildEmergencySection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        Card(
          color: AppColors.steelGray.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• $item', style: Theme.of(context).textTheme.bodyLarge),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencySection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🚨 Emergency Contacts',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text('• Philippine National Police: 117', 
              style: Theme.of(context).textTheme.bodyLarge),
          Text('• Emergency Hotline: 911', 
              style: Theme.of(context).textTheme.bodyLarge),
          Text('• Bureau of Fire Protection: 160', 
              style: Theme.of(context).textTheme.bodyLarge),
          Text('• Women and Children Protection Center: 8532-6690', 
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}