class UserEntity {
  const UserEntity({required this.name, required this.email, this.token});

  final String name;
  final String email;
  final String? token;
}
