import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/add_card_view_body.dart';

class SignUpModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? verifPass;
  final String? cardNumberController;
  final String? expiryDateController;
  final String? cvvController;
  final String? pass;

  final String? phone;
  final String? dropdownValue;

  SignUpModel({
    this.firstName,
    this.lastName,
    this.email,
    this.verifPass,
    this.cardNumberController,
    this.expiryDateController,
    this.cvvController,
    this.pass,
    this.phone,
    this.dropdownValue,
  });

  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "password": pass,
        "passwordConfirm": verifPass,
        "CardNumber": cardNumberController,
        "ExpiryDate": expiryDateController,
        "CVV": cvvController,
        "gender": dropdownValue,
        "phone": phone
      };
}
