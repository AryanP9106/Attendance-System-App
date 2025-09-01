class User {
  final int id;
  final String name;
  final String email;
  final String role; // 'teacher' or 'student'

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  // Factory constructor to create a User from a map (useful for database operations)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
    );
  }

  // Method to convert a User to a map (useful for database operations)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
