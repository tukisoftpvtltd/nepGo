part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpInvalidState extends SignUpState {}

class SignUpValidState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String errorMessage;
  SignUpErrorState(this.errorMessage);
}

class SignUpPasswordVisible extends SignUpState {}

class SignUpPasswordInVisible extends SignUpState {}

class SignUpConfirmPasswordVisible extends SignUpState {}

class SignUpConfirmPasswordInVisible extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpFirstNameValidState extends SignUpState {}

class SignUpFirstNameInValidState extends SignUpState {}

class SignUpSecondNameValidState extends SignUpState {}

class SignUpSecondNameInValidState extends SignUpState {}

class SignUpPhoneValidState extends SignUpState {}

class SignUpPhoneInValidState extends SignUpState {}

class SignUpEmailValidState extends SignUpState {}

class SignUpEmailInValidState extends SignUpState {}

class SignUpPasswordValidState extends SignUpState {}

class SignUpPasswordInValidState extends SignUpState {}

class SignUpConfirmPasswordValidState extends SignUpState {}

class SignUpConfirmPasswordInValidState extends SignUpState {}

class SignUpAddressValidState extends SignUpState {}

class SignUpAddressInValidState extends SignUpState {}

class SignUpCityValidState extends SignUpState {}

class SignUpCityInValidState extends SignUpState {}