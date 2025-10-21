// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:justifind_capstone_2_final/models/crime_model.dart'; // Fixed import path
import 'package:justifind_capstone_2_final/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    backgroundColor:
                        crime.severity.contains('High')
                            ? Colors.red
                            : Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Laws Section
            _buildLawDetailsSection(context, crime.laws.keys.toList()),

            const SizedBox(height: 16),

            // Penalties Section
            _buildSection(
              context,
              '⚖️ Penalties & Consequences',
              crime.penalties,
            ),

            const SizedBox(height: 16),

            // Prevention Tips Section
            _buildSection(context, '🛡️ Prevention Tips', crime.preventionTips),

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
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 8),
        Card(
          color: AppColors.steelGray.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '• $item',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLawDetailsSection(BuildContext context, List<String> lawKeys) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📚 Legal Laws & Provisions',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 8),
        ...lawKeys.map((lawKey) {
          final law = lawDetails[lawKey];
          if (law == null) return SizedBox();
          return Card(
            color: AppColors.steelGray.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    law['title'] ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    law['summary'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Key Provisions:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    law['keyProvisions'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }),
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
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
            '• Philippine National Police: 117',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '• Emergency Hotline: 911',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '• Bureau of Fire Protection: 160',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '• Women and Children Protection Center: 8532-6690',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

const Map<String, Map<String, String>> lawDetails = {
  '9165': {
    'title': 'Comprehensive Dangerous Drugs Act of 2002 (RA 9165)',
    'summary':
        'A law that penalizes the illegal use, possession, manufacture, and trafficking of dangerous drugs. It established the Philippine Drug Enforcement Agency (PDEA) and provides for the rehabilitation of drug dependents.',
    'keyProvisions': '''
- Prohibits the sale, possession, use, manufacture, and trafficking of dangerous drugs and controlled precursors.
- Imposes strict penalties, including life imprisonment and heavy fines for major offenses.
- Mandates drug testing for students, employees, and certain professionals.
- Provides for voluntary and compulsory rehabilitation for drug dependents.
- Empowers PDEA as the lead agency in drug law enforcement.
''',
  },
  '10175': {
    'title': 'Cybercrime Prevention Act of 2012 (RA 10175)',
    'summary':
        'A law that defines and penalizes cybercrimes such as hacking, identity theft, cybersex, and online libel. It provides mechanisms for law enforcement to address crimes committed through information and communications technology.',
    'keyProvisions': '''
- Penalizes offenses like illegal access (hacking), data interference, cybersex, identity theft, and online libel.
- Allows for the collection and preservation of digital evidence.
- Empowers authorities to restrict or block access to harmful online content.
- Provides for international cooperation in cybercrime investigations.
''',
  },
  '8353': {
    'title': 'Anti-Rape Law of 1997 (RA 8353)',
    'summary':
        'A law that redefines and expands the definition of rape, recognizing it as a crime against persons and providing stiffer penalties and protection for victims.',
    'keyProvisions': '''
- Expands the definition of rape to include sexual assault by insertion of objects or instruments.
- Recognizes marital rape.
- Provides for confidentiality and protection of rape victims.
- Imposes reclusion perpetua (life imprisonment) for qualified cases.
''',
  },
  '10883': {
    'title': 'New Anti-Carnapping Act of 2016 (RA 10883)',
    'summary':
        'A law that penalizes the taking of motor vehicles without the owner’s consent, with higher penalties for cases involving violence or if the victim is killed or raped.',
    'keyProvisions': '''
- Covers all types of motor vehicles, including motorcycles.
- Imposes higher penalties if carnapping is committed with violence, intimidation, or force.
- Life imprisonment if carnapping results in homicide or rape.
- Provides for immediate confiscation and forfeiture of carnapped vehicles.
''',
  },
  'drugs': {
    'title': 'Comprehensive Dangerous Drugs Act (RA 9165)',
    'summary':
        'Covers all offenses related to illegal drugs, including use, possession, sale, manufacture, and trafficking.',
    'keyProvisions': '''
- Strict penalties for all drug-related offenses.
- Mandatory drug education and prevention programs.
- Rehabilitation for drug dependents.
- PDEA as the lead enforcement agency.
''',
  },
  'Rape': {
    'title': 'Anti-Rape Law (RA 8353)',
    'summary':
        'Protects individuals from all forms of rape and sexual assault, providing legal remedies and support for victims.',
    'keyProvisions': '''
- Expands the definition of rape.
- Recognizes marital and sexual assault.
- Ensures victim confidentiality and support.
- Severe penalties for offenders.
''',
  },
  'Anti-Carnaping': {
    'title': 'New Anti-Carnapping Act (RA 10883)',
    'summary':
        'Addresses the crime of carnapping, or the taking of motor vehicles without consent.',
    'keyProvisions': '''
- Covers all motor vehicles.
- Higher penalties for violence or if the victim is harmed.
- Immediate recovery and forfeiture of stolen vehicles.
''',
  },
  'CyberCrime': {
    'title': 'Cybercrime Prevention Act (RA 10175)',
    'summary':
        'Addresses crimes committed through computers and the internet, including hacking, cybersex, and online fraud.',
    'keyProvisions': '''
- Penalizes various forms of cybercrime.
- Allows digital evidence collection.
- Empowers authorities to block harmful content.
''',
  },
  '10591': {
    'title': 'Comprehensive Firearms and Ammunition Regulation Act (RA 10591)',
    'summary':
        'A law that regulates the ownership, possession, carrying, manufacture, and importation of firearms and ammunition.',
    'keyProvisions': '''
- Requires licensing and registration of firearms and ammunition.
- Sets rules for dealers, manufacturers, and importers.
- Imposes penalties for illegal possession, manufacture, or sale.
- Provides for the surrender and confiscation of unlicensed firearms.
''',
  },
  '9287': {
    'title': 'Anti-Illegal Numbers Game Act (RA 9287)',
    'summary':
        'A law that increases penalties for illegal gambling activities, especially illegal numbers games such as jueteng, masiao, and last two.',
    'keyProvisions': '''
- Penalizes operators, financiers, and protectors of illegal numbers games.
- Imposes higher penalties for public officials involved.
- Encourages public reporting and provides rewards for informants.
''',
  },
};
