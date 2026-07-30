class UserModel {
  final String name;
  final String email;
  final String id;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[''],
      email: json[''],
      id: json[''],
      createdAt: json[''],
      updatedAt: json[''],
    );
  }

  Map<String, dynamic> toJson(UserModel user) {
    return {};
  }
}
