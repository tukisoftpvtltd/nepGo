part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

// class SignUpTextChangedEvent extends SignUpEvent {
//   final String firstNameValue;
//   final String secondNameValue;
//   final String phoneNumber;
//   final String emailValue;
//   final String passwordValue;
//   final String confirmPasswordValue;
//   SignUpTextChangedEvent(
//       this.firstNameValue,
//       this.secondNameValue,
//       this.phoneNumber,
//       this.emailValue,
//       this.passwordValue,
//       this.confirmPasswordValue);
// }
class SignUpInitialEvent extends SignUpEvent {
 
}

class FirstNameChangedEvent extends SignUpEvent {
  final String firstNameValue;
  FirstNameChangedEvent(
    this.firstNameValue,
  );
}

class SecondNameChangedEvent extends SignUpEvent {
  final String secondNameValue;
  SecondNameChangedEvent(
    this.secondNameValue,
  );
}

class PhoneNoChangedEvent extends SignUpEvent {
  final String phoneNumber;

  PhoneNoChangedEvent(
    this.phoneNumber,
  );
}

class SignUpEmailChangedEvent extends SignUpEvent {
  final String emailValue;
  SignUpEmailChangedEvent(
    this.emailValue,
  );
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  final String passwordValue;
  SignUpPasswordChangedEvent(
    this.passwordValue,
  );
}

class ConfirmPasswordChangedEvent extends SignUpEvent {
  final String passwordValue;
  final String confirmPasswordValue;
  ConfirmPasswordChangedEvent(
    this.passwordValue,
    this.confirmPasswordValue,
  );
}

class SignUpSubmittedEvent extends SignUpEvent {
  final String firstName;
  final String secondName;
  final String email;
  final String phoneNo;
  final String password;
  final String confirmPassword;
  final String address;
  final String city;
  final String diver_type;
  SignUpSubmittedEvent(this.firstName, this.secondName, this.email,
    this.phoneNo,this.password, this.confirmPassword,
    this.address,this.city,this.diver_type);
}

class SignUpErrorEvent extends SignUpEvent {
  final String message;
  SignUpErrorEvent(this.message);
}

class SignUpVisibiltyPressed extends SignUpEvent {
  late final bool pressed;
  SignUpVisibiltyPressed(this.pressed);
}

class SignUpConfirmVisibiltyPressed extends SignUpEvent {
  late final bool pressed;
  SignUpConfirmVisibiltyPressed(this.pressed);
}

class SignUpIsSubmitted extends SignUpEvent {
  SignUpIsSubmitted();
}
class AddressChangedEvent extends SignUpEvent {
  final String addressValue;
  AddressChangedEvent(
    this.addressValue,
  );
}
class CityChangedEvent extends SignUpEvent {
  final String cityValue;
  CityChangedEvent(
    this.cityValue,
  );
}