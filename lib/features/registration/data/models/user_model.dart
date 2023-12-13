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
  final String? phone;
  

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
    this.phone,
    
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
        phone: json['phone'] as String?,
        
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
        'phone': phone,
        
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
      phone,
      
    ];
  }
}
