import 'package:equatable/equatable.dart';

class VerificationModel extends Equatable {
  final String? email;

  const VerificationModel({
    this.email,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      VerificationModel(
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson(Map<String, dynamic> map) => {
        'email': email,
      };

  @override
  List<Object?> get props {
    return [
      email,
    ];
  }
}
