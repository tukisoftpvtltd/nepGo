import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Driver/Controller/repository/updatePlayerId.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/login_model.dart';
import '../../../../../View/view/home_page.dart';
import '../../../../repository/driverLogin.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final BuildContext context;
  SignInBloc(this.context) : super(SignInInitialState()) {
    on<EmailChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(EmailInValidState());
      } else {
        emit(EmailValidState());
      }
    });

    on<PasswordChangedEvent>((event, emit) {
      if (event.passwordValue.length < 8) {
        emit(PasswordInValidState());
      } else {
        emit(PasswordValidState());
      }
    });

    on<SignInTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState("Please enter a valid email address"));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState("Please enter a valid password"));
      } else {
        emit(SignInValidState());
      }
    });
    on<VisibiltyPressed>((event, emit) {
      if (event.pressed == false) {
        emit(PasswordVisible());
        // event.pressed = true;
      } else if (event.pressed == true) {
        emit(PasswordInVisible());
        // event.pressed = false;
      } else {
        emit(SignInValidState());
      }
    });
     

    on<SignInSubmittedEvent>((event, emit) async {
      try {
        emit(SignInLoadingState());
        DriverLoginRepository repo = DriverLoginRepository();
        LoginModel model = await repo.Login(event.email, event.password);
        if(model.message =='Login successful'){
          String? did =model.driver?.dId.toString();
          String? fullname = model.driver?.fullname.toString();
          String? email = model.driver?.email.toString();
          String? phoneno = model.driver?.mobileNumber.toString();
          String? driver_type = model.driver?.driverType.toString();
          String? driver_address =model.driver?.address.toString();
         
          SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('isDriverLoggedIn', 'true');
        prefs.setString('fullname', fullname!);
        prefs.setString('email', email!);
        prefs.setString('phoneno', phoneno!);
        prefs.setString('driverId', did!);
        prefs.setString('driver_type', driver_type!);
        prefs.setString('driver_address', driver_address!);
        String? isDriverLoggedIn = prefs.getString('isDriverLoggedIn');
        print("the driver is now");
        print(isDriverLoggedIn);
        UpdatePlayerIdRepository repo2 = UpdatePlayerIdRepository();
        bool isUpdated;
        isUpdated = await repo2.updatePlayerId(did, event.playerId);
          // prefs.setString('DID',did!);
          if(isUpdated == true){
          Fluttertoast.showToast(
            msg: 'Sign in successful!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          emit(SignInInitialState());
          Get.offAll(HomePage(driver_type:driver_type.toString()));
          }
          else{
            Fluttertoast.showToast(
            msg: 'Played Id failed to be updated',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          emit(SignInInitialState());
          }
        
        }
        else{
          Fluttertoast.showToast(
            msg: 'User Credential didnt match',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          emit(SignInInitialState());
        }
        // String error;
        // emit(SignInLoadingState());
        // AddDriverRepository  loginRepository = LoginRepository();
        // LoginModel loginResponse =
        //     (await loginRepository.Login(event.email, event.password));
        // print(loginResponse.email);
        // print(loginResponse.password);
        // if (loginResponse.success == true) {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //   prefs.setString('isLoggedIn', 'true');
        //   emit(SignInSuccessState("Sign in Suceeded"));
        //   Fluttertoast.showToast(
        //     msg: 'Sign in successful!',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     backgroundColor: Colors.black54,
        //     textColor: Colors.white,
        //     fontSize: 16.0,
        //   );
        //   emit(SignInInitialState());
        //   Get.offAll(BlocProvider<SignInBloc>(
        //     create: (context) => SignInBloc(context),
        //     child: BlocProvider<HomePageBloc>(
        //       create: (context) => HomePageBloc(),
        //       child: BlocProvider(
        //         create: (context) => HomeNavigationBloc(),
        //         child: HomeScreensNavigation(
        //           currentIndexNumber: 0,
        //           loginStatus: "true",
        //         ),
        //       ),
        //     ),
        //   ));
        // } else {
        //   if (loginResponse.email != '') {
        //     error = loginResponse.email!;
        //   } else {
        //     error = loginResponse.password!;
        //   }
        //   emit(SignInFailedState(error));
        // }
      } catch (e) {
        print("The error is" + e.toString());
      }
    });

    on<SignInFailedEvent>((event, emit) async {
      emit(SignInFailedState(event.message));
    });
    on<SignInInitialEvent>((event, emit) async {
      emit(SignInInitialState());
    });
    on<SignInValidEvent>((event, emit) async {
      emit(SignInValidState());
    });
  }
}
