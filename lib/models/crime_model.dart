// lib/models/crime_model.dart
import 'package:flutter/material.dart';

class Crime {
  final String title;
  final String description;
  final String severity;
  final Color color;
  final String category; // Add this property
  final Map<String, String> laws;
  final List<String> penalties;
  final List<String> preventionTips;

  const Crime({
    required this.title,
    required this.description,
    required this.severity,
    required this.color,
    required this.category, // Add this
    required this.laws,
    required this.penalties,
    required this.preventionTips,
  });
}

class Admin {
  final String uid;
  final String email;
  final String name;
  final DateTime createdAt;
  final bool isSuperAdmin;

  Admin({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    this.isSuperAdmin = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isSuperAdmin': isSuperAdmin,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      isSuperAdmin: map['isSuperAdmin'] ?? false,
    );
  }
}