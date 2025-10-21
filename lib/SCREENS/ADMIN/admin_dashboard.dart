import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Admin Tools',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 3,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.search, color: Colors.white),
              ),
              title: const Text(
                'Search History & Trends',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'View global and per-user search history and most-searched keywords.',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminSearchStatsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AdminSearchStatsScreen extends StatefulWidget {
  const AdminSearchStatsScreen({super.key});

  @override
  State<AdminSearchStatsScreen> createState() => _AdminSearchStatsScreenState();
}

class _AdminSearchStatsScreenState extends State<AdminSearchStatsScreen> {
  bool _loading = false;
  List<MapEntry<String, int>> _sorted = [];
  String _mode = 'global'; // 'global' or 'per_user'
  final TextEditingController _emailController = TextEditingController();
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    _loadGlobal();
  }

  Future<void> _loadGlobal() async {
    setState(() {
      _loading = true;
      _statusMessage = null;
      _sorted = [];
    });
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collectionGroup('search_history')
              .get();
      final counts = <String, int>{};
      for (var doc in snapshot.docs) {
        final keyword = (doc['keyword'] ?? '').toString().toLowerCase().trim();
        if (keyword.isEmpty) continue;
        counts[keyword] = (counts[keyword] ?? 0) + 1;
      }
      setState(() {
        _sorted =
            counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error loading global searches: $e';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadPerUser(String email) async {
    setState(() {
      _loading = true;
      _statusMessage = null;
      _sorted = [];
    });
    try {
      final userQuery =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();
      if (userQuery.docs.isEmpty) {
        setState(() {
          _statusMessage = 'No user found with that email.';
        });
        return;
      }
      final uid = userQuery.docs.first.id;
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('search_history')
              .get();
      final counts = <String, int>{};
      for (var doc in snapshot.docs) {
        final keyword = (doc['keyword'] ?? '').toString().toLowerCase().trim();
        if (keyword.isEmpty) continue;
        counts[keyword] = (counts[keyword] ?? 0) + 1;
      }
      setState(() {
        _sorted =
            counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error loading user searches: $e';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToggleButtons(
          isSelected: [_mode == 'global', _mode == 'per_user'],
          onPressed: (i) {
            setState(() {
              _mode = i == 0 ? 'global' : 'per_user';
              _statusMessage = null;
            });
            if (_mode == 'global') _loadGlobal();
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('Global'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('Per User'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_mode == 'per_user')
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'User email',
                    hintText: 'user@example.com',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _loadPerUser(_emailController.text.trim()),
                child: const Text('Load'),
              ),
            ],
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search History & Trends')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildControls(),
            if (_loading) const LinearProgressIndicator(),
            if (_statusMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _statusMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child:
                  _sorted.isEmpty
                      ? Center(
                        child: Text(
                          _loading ? 'Loading...' : 'No search data yet.',
                        ),
                      )
                      : ListView.separated(
                        itemCount: _sorted.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final entry = _sorted[index];
                          return ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text('${entry.value}x'),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
