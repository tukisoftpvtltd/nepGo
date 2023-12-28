import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/signup_repository.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpInitialEvent>((event, emit) {
      emit(SignUpInitialState());
    });
    on<FirstNameChangedEvent>((event, emit) {
      if (event.firstNameValue.length >= 3) {
        emit(SignUpFirstNameValidState());
      } else if (event.firstNameValue.length < 3) {
        emit(SignUpFirstNameInValidState());
      }
    });
    on<SecondNameChangedEvent>((event, emit) {
      if (event.secondNameValue.length >= 3) {
        emit(SignUpSecondNameValidState());
      } else if (event.secondNameValue.length < 3) {
        emit(SignUpSecondNameInValidState());
      }
    });
    on<PhoneNoChangedEvent>((event, emit) {
      if (event.phoneNumber.length == 10) {
        emit(SignUpPhoneValidState());
      } else if (event.phoneNumber.length != 10) {
        emit(SignUpPhoneInValidState());
      }
    });
    on<SignUpEmailChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == true) {
        emit(SignUpEmailValidState());
      } else if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignUpEmailInValidState());
      }
    });
    on<SignUpPasswordChangedEvent>((event, emit) {
      if (event.passwordValue.length >= 8) {
        emit(SignUpPasswordValidState());
      } else if (event.passwordValue.length < 8) {
        emit(SignUpPasswordInValidState());
      }
    });
    on<SignUpNewPasswordChangedEvent>((event, emit) {
      if (event.newPasswordValue.length >= 8) {
        emit(SignUpNewPasswordValidState());
      } else if (event.newPasswordValue.length < 8) {
        emit(SignUpNewPasswordInValidState());
      }
    });
    on<ConfirmPasswordChangedEvent>((event, emit) {

      if (event.passwordValue == event.confirmPasswordValue) {
        emit(SignUpConfirmPasswordValidState());
      } else if (event.passwordValue != event.confirmPasswordValue) {
        emit(SignUpConfirmPasswordInValidState());
      }
    });
    on<SignUpVisibiltyPressed>((event, emit) {
       print(event.pressed);
      if (event.pressed == false) {
        emit(SignUpNewPasswordVisible());
      } else if (event.pressed == true) {
        emit(SignUpNewPasswordInVisible());
      }
     
    });
     on<SignUpNewVisibiltyPressed>((event, emit) {
      print(event.pressed);
      if (event.pressed == false) {
        emit(SignUpPasswordVisible());
      } else if (event.pressed == true) {
        emit(SignUpPasswordInVisible());
      }
    });
    on<SignUpConfirmVisibiltyPressed>((event, emit) {
      if (event.pressed == false) {
        emit(SignUpConfirmPasswordVisible());
      } else if (event.pressed == true) {
        emit(SignUpConfirmPasswordInVisible());
      }
    });
     
    on<SignUpIsSubmitted>((event, emit) {
      emit(SignUpLoadingState());
      
    });

    on<SignUpSubmittedEvent>((event, emit) async {
      emit(SignUpLoadingState());
       SignUpRepository SignUp = SignUpRepository();
       String? signedUp = await SignUp.SignUp(event.firstName,
                                      event.secondName,
                                      event.email,
                                      event.phoneNo,
                                      event.password,
                                      "");
      if (signedUp == "true") {
        // print("Signed In");
        //  SharedPreferences userData = await SharedPreferences.getInstance();
        //  userData.setString('user_id',signUpResponse!.data!.userId.toString());
        //  userData.setString('access_token',signUpResponse.accessToken.toString());
        //  String? userId = userData.getString('user_id');
        //  String? otpCode = signUpResponse.otp.toString();
         emit(SignUpSuccessState());
        //  print(event.email);
        //  print(event.password);
        //  print(otpCode);
        //  print(event.phoneNo);
        //  print(userId);
      // Get.to(OTPPage(event.email, event.password, otpCode ,event.phoneNo,userId!));
            
       } else {
        // String? error =  signUpResponse!.message.toString();
         emit(SignUpErrorState(
         signedUp!,
         ));
       }

    });

    on<SignUpErrorEvent>((event, emit) async {
      emit(SignUpErrorState(event.message));
    });
  }
}
