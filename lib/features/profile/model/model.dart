class UserModel {
  final String fullName;
  final String email;
  final String phone;
  final String gender;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
    );
  }
}
