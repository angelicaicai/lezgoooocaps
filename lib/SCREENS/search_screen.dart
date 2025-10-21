// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:justifind_capstone_2_final/theme/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<QueryDocumentSnapshot> _results = [];
  bool _loading = false;
  String _status = '';

  Future<void> _logSearch(String keyword) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final email = FirebaseAuth.instance.currentUser?.email;
      final data = {
        'keyword': keyword,
        'timestamp': FieldValue.serverTimestamp(),
        if (uid != null) 'uid': uid,
        if (email != null) 'email': email,
      };

      // Global log
      await FirebaseFirestore.instance.collection('search_logs').add(data);

      // Per-user log (if logged in)
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('search_history')
            .add(data);
      }
    } catch (e) {
      // silent fail, but update status so admin/dev can see
      setState(() => _status = 'Failed to log search: $e');
    }
  }

  Future<void> _performSearch(String query) async {
    final q = query.trim();
    if (q.isEmpty) {
      setState(() {
        _results = [];
        _status = '';
      });
      return;
    }

    setState(() {
      _loading = true;
      _status = '';
    });

    await _logSearch(q);

    try {
      // Fetch all crimes and filter client-side for flexible matching
      final snapshot =
          await FirebaseFirestore.instance.collection('crimes').get();
      final matches =
          snapshot.docs.where((doc) {
            final data = doc.data();
            final title = (data['title'] ?? '').toString().toLowerCase();
            final desc =
                (data['description'] ?? data['summary'] ?? '')
                    .toString()
                    .toLowerCase();
            final keywords =
                (data['keywords'] ?? [])
                    .cast<String?>()
                    .where((k) => k != null)
                    .map((k) => k!.toLowerCase())
                    .toList();
            final qLower = q.toLowerCase();
            return title.contains(qLower) ||
                desc.contains(qLower) ||
                keywords.any((k) => k.contains(qLower));
          }).toList();

      setState(() {
        _results = matches;
        if (_results.isEmpty) _status = 'No results';
      });
    } catch (e) {
      setState(() {
        _status = 'Search failed: $e';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildResultCard(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final title = data['title'] ?? data['name'] ?? 'Untitled';
    final desc = data['description'] ?? data['summary'] ?? '';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.darkIndigo,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.pnpWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(desc, style: const TextStyle(color: Colors.white70)),
        onTap: () {
          // navigate to detail screen if available
          // Navigator.pushNamed(context, '/crime-detail', arguments: doc.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Crimes & Laws'),
        backgroundColor: AppColors.pnpGold,
        foregroundColor: AppColors.pnpBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: AppColors.pnpWhite),
              decoration: InputDecoration(
                hintText: 'Type crime or law here...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: AppColors.pnpWhite),
                filled: true,
                fillColor: const Color(0xFF1F2023),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.pnpGold),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => _performSearch(value),
            ),
            const SizedBox(height: 12),
            if (_loading) const LinearProgressIndicator(),
            if (_status.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  _status,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            Expanded(
              child:
                  _results.isEmpty
                      ? Center(
                        child: Text(
                          _loading
                              ? ''
                              : (_status.isEmpty
                                  ? 'Type and press Search'
                                  : _status),
                          style: const TextStyle(color: Colors.white60),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder:
                            (context, index) =>
                                _buildResultCard(_results[index]),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
