class UserProfile {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      password: json['password'],  // You may not need this for display purposes
      name: json['name'],
      role: json['role'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['creationAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}