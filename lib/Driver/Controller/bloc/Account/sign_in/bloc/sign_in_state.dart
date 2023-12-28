part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class PasswordVisible extends SignInState {}

class PasswordInVisible extends SignInState {}

class SignInInvalidState extends SignInState {}

class SignInValidState extends SignInState {}

class EmailValidState extends SignInState {}

class EmailInValidState extends SignInState {}

class PasswordValidState extends SignInState {}

class PasswordInValidState extends SignInState {}

class SignInErrorState extends SignInState {
  final String errorMessage;
  SignInErrorState(this.errorMessage);
}

class SignInLoadingState extends SignInState {}

class SignInFailedState extends SignInState {
  final String failedMessage;
  SignInFailedState(this.failedMessage);
}

class SignInSuccessState extends SignInState {
  final String successMessage;
  SignInSuccessState(this.successMessage);
}
