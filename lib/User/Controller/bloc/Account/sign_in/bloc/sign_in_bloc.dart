import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Account/SignUp/OTPPage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/login_model.dart';
import '../../../../../View/Screens/HomeScreens/Home/HomeScreensNavigation.dart';
import '../../../../../View/constants/Constants.dart';
import '../../../../repositories/login_repository.dart';
import '../../../Baskets/basket_home/basket_bloc.dart';
import '../../../Home/home_page/bloc/home_page_bloc.dart';
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
        String error;
        emit(SignInLoadingState());
        LoginRepository loginRepository = LoginRepository();

        LoginModel loginResponse =
            (await loginRepository.Login(event.email, event.password));

        if (loginResponse.success == true) {
          if (loginResponse.data!.status.toString() == "1") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('isLoggedIn', 'true');
            prefs.setString('user_thumbnail', '$baseUrl/userprofile/${loginResponse.data!.userThumbnail.toString()}');
            
            emit(SignInSuccessState("Sign in Suceeded"));
            Fluttertoast.showToast(
              msg: 'Sign in successful!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            emit(SignInInitialState());
            Get.offAll(BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(context),
              child: BlocProvider<HomePageBloc>(
                create: (context) => HomePageBloc(),
                child: BlocProvider(
                  create: (context) => HomeNavigationBloc(),
                  child: BlocProvider(
                    create: (context) => BasketBloc(),
                    child: HomeScreensNavigation(
                      currentIndexNumber: 0,
                      loginStatus: "true",
                      homeData: [],
                      advertisementData: [],
                    ),
                  ),
                ),
              ),
            ));
          } else {
            emit(SignInInitialState());
            Get.to(OTPPage(
                true,
                loginResponse.data!.email!,
                loginResponse.data!.password!,
                loginResponse.data!.otpCode.toString(),
                loginResponse.data!.mobileNumber.toString(),
                loginResponse.data!.userId.toString()));
          }
        } else {
          print(loginResponse.email);
          if (loginResponse.email != '') {
            error = loginResponse.email!;
          } else if (loginResponse.password != '') {
            error = loginResponse.password!;
          } else if (loginResponse.data!.email != '') {
            error = loginResponse.data!.email!;
          } else {
            error = loginResponse.data!.password!;
          }
          emit(SignInFailedState(error));
        }
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
