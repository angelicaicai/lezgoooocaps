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
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      isSuperAdmin: map['isSuperAdmin'] ?? false,
    );
  }
}