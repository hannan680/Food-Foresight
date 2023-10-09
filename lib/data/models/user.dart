class User {
  final String? uid;
  final String email;
  final String
      password; // Note: This is typically not stored locally for security reasons.
  final String phone;
  final String name;

  User({
    this.uid,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });
}
