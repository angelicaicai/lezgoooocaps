// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/admin_model.dart';

class AdminService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if current user is admin
  Future<bool> isAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    try {
      final doc = await _firestore.collection('admins').doc(user.uid).get();
      return doc.exists;
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }

  // Admin login method
  Future<Admin?> adminLogin(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final adminDoc = await _firestore
          .collection('admins')
          .doc(userCredential.user!.uid)
          .get();

      if (adminDoc.exists) {
        return Admin.fromMap(adminDoc.data()!);
      }
      return null;
    } catch (e) {
      print('Admin login error: $e');
      return null;
    }
  }

  // Admin logout
  Future<void> adminLogout() async {
    await _auth.signOut();
  }

  // Get current admin
  Future<Admin?> getCurrentAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final adminDoc = await _firestore.collection('admins').doc(user.uid).get();
      if (adminDoc.exists) {
        return Admin.fromMap(adminDoc.data()!);
      }
      return null;
    } catch (e) {
      print('Error getting current admin: $e');
      return null;
    }
  }
}