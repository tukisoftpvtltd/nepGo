import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Driver/Controller/repository/addDriver.dart';
import 'package:food_app/Driver/View/view/home_page.dart';
import 'package:get/get.dart';
import '../../../../Model/signup_model.dart';
import '../sign_in/bloc/sign_in_bloc.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
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
    on<ConfirmPasswordChangedEvent>((event, emit) {
      if (event.passwordValue == event.confirmPasswordValue) {
        emit(SignUpConfirmPasswordValidState());
      } else if (event.passwordValue != event.confirmPasswordValue) {
        emit(SignUpConfirmPasswordInValidState());
      }
    });
    on<AddressChangedEvent>((event, emit) {
      if (event.addressValue.length >= 3) {
        emit(SignUpAddressValidState());
      } else if (event.addressValue.length < 3) {
        emit(SignUpAddressInValidState());
      }
    });
    on<CityChangedEvent>((event, emit) {
      if (event.cityValue.length >= 3) {
        emit(SignUpCityValidState());
      } else if (event.cityValue.length < 3) {
        emit(SignUpCityInValidState());
      }
    });
    on<SignUpVisibiltyPressed>((event, emit) {
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
      print(event.firstName + " " + event.secondName);
      print(event.phoneNo);
      print(event.email);
      print(event.password);
      print(event.confirmPassword);
      print(event.address);
      print(event.city);
      print(event.diver_type);
      int driver_type =0;
      if(event.diver_type == "Delivery"){
        driver_type = 0;
      }
      if(event.diver_type == "Ride Share"){
        driver_type = 1;
      }
      emit(SignUpLoadingState());
      AddDriverRepository repo = AddDriverRepository();
      PostDriverModel model = await repo.AddDriver(
          event.firstName + " " + event.secondName,
          event.email,
          event.phoneNo,
          event.password,
          "2",
          event.address,
          event.city,
          driver_type
          );
      
      print("The model is"+model.data.toString()+model.message.toString()+model.status.toString());
      
      if (model.status == 'success') {
        Fluttertoast.showToast(
          msg: 'Sign Up successful!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        emit(SignUpSuccessState());
        Get.back();
        
      }
      else{
        String? message = model.message;
        Fluttertoast.showToast(
          msg: '$message Error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.back();
      }
      //  SignUpRepository SignUp = SignUpRepository();
      //  signupmodel? signUpResponse =await SignUp.SignUp(
      //                                 event.firstName,
      //                                 event.secondName,
      //                                 event.email,
      //                                 event.phoneNo,
      //                                 event.password,
      //                                 "");
      // if (signUpResponse?.success == "true") {
      //   Fluttertoast.showToast(
      //             msg: 'Sign Up successful!',
      //              toastLength: Toast.LENGTH_SHORT,
      //              gravity: ToastGravity.BOTTOM,
      //            backgroundColor: Colors.black54,
      //            textColor: Colors.white,
      //            fontSize: 16.0,
      //             );
      //   emit(SignUpSuccessState());
      //   Get.to(HomePage());

      //  } else {
      //   String? error =  signUpResponse!.message.toString();
      //    emit(SignUpErrorState(
      //    error,
      //    ));
      //  }
    });

    on<SignUpErrorEvent>((event, emit) async {
      emit(SignUpErrorState(event.message));
    });
  }
}
