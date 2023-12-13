import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvv;
  final String? profileImg;
  final String? password;
  final String? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.profileImg,
    this.password,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        email: json['email'] as String?,
        cardNumber: json['CardNumber'] as String?,
        expiryDate: json['ExpiryDate'] as String?,
        cvv: json['CVV'] as String?,
        profileImg: json['profileImg'] as String?,
        password: json['password'] as String?,
        gender: json['gender'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'CardNumber': cardNumber,
        'ExpiryDate': expiryDate,
        'CVV': cvv,
        'profileImg': profileImg,
        'password': password,
        'gender': gender,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      firstname,
      lastname,
      email,
      cardNumber,
      expiryDate,
      cvv,
      profileImg,
      password,
      gender,
      createdAt,
      updatedAt,
    ];
  }
}
