import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../Controller/bloc/internet/bloc/internet_bloc_bloc.dart';
import 'HomeScreens/Home/HomeScreensNavigation.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

String finalEmail = '';

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    final internetBloc = InternetBlocBloc(); 
  }

  String? userLoginStatus;
  String? userId;
  bool goToHome = false;
  bool goToNoInternetPage = false;

  void _startNavigationTimer() {
    print(internetState);
    Timer(Duration(milliseconds: 1000),
        internetState == "Internet Gained" ? _navigateFromSplashScreen : () {});
  }

  _navigateFromSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
    LocationPermission permission = await Geolocator.checkPermission();
    try {
      print("The Permission is");
      print(permission);
      if (permission == LocationPermission.denied) {
        print("delete");
        prefs.remove('isLoggedIn');
        prefs.remove('user_id');
        prefs.remove('latitude');
        prefs.remove('longitude');
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request');
      }
      userLoginStatus = prefs.getString('isLoggedIn');
      print("The user is currently:");
      print(userLoginStatus);
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        print("Hello");
        print(userLoginStatus);
        // print(userId);
        if (userLoginStatus.toString() == 'true') {
          print("true loading");

          BlocProvider.of<HomePageBloc>(context).add(onHomePageLoading());
        } else {
          print("again loading");

          Get.offAll(BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(context),
            child: BlocProvider(
                create: (context) => HomeNavigationBloc(),
                child: BlocProvider(
                    create: (context) => HomePageBloc(),
                    child: BlocProvider(
                      create: (context) => BasketBloc(),
                      child: HomeScreensNavigation(
                          currentIndexNumber: 0,
                          loginStatus: "false",
                          homeData: [],
                          advertisementData: []),
                    ))),
          ));
        }
      }
    } catch (e) {}
  }

  String internetState = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBlocBloc, InternetBlocState>(
      listener: (context, state) {},
      child: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is HomePageLoaded) {
            var data = state.data;
            var AdData = state.advertisement;
            Get.offAll(BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(context),
              child: BlocProvider(
                  create: (context) => HomeNavigationBloc(),
                  child: BlocProvider(
                      create: (context) => HomePageBloc(),
                      child: BlocProvider(
                        create: (context) => BasketBloc(),
                        child: HomeScreensNavigation(
                            currentIndexNumber: 0,
                            loginStatus: userLoginStatus!,
                            homeData: data,
                            advertisementData: AdData),
                      ))),
            ));
          } else {
            Get.offAll(BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(context),
              child: BlocProvider(
                  create: (context) => HomeNavigationBloc(),
                  child: BlocProvider(
                      create: (context) => HomePageBloc(),
                      child: BlocProvider(
                        create: (context) => BasketBloc(),
                        child: HomeScreensNavigation(
                            currentIndexNumber: 0,
                            loginStatus: userLoginStatus!,
                            homeData: [],
                            advertisementData: []),
                      ))),
            ));
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 350,
                          width: 350,
                          child: Image.asset('assets/images/foodlogo.png')),
                      BlocBuilder<InternetBlocBloc, InternetBlocState>(
                        builder: (context, state) {
                          print("The state is");
                          print(state);
                          if (state is InternetGainedState) {
                            internetState = "Internet Gained";
                            _startNavigationTimer();
                            return InternetGainedWidget();
                          } else if (state is InternetLostState) {
                            internetState = "Internet lost";

                            return NoInternetWidget();
                          } else if (state is SlowInternetState) {
                            internetState = "Slow Internet";
                            return SlowInternetWidget();
                          } else {
                           return InternetGainedWidget();
                          }
                        },
                      )
                      // : internetState == "Internet Lost"
                      //     ? NoInternetWidget()
                      //     : SlowInternetWidget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40.0),
                child: Text(
                  "Version 0.1",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InternetGainedWidget extends StatefulWidget {
  const InternetGainedWidget({super.key});

  @override
  State<InternetGainedWidget> createState() => _InternetGainedWidgetState();
}

class _InternetGainedWidgetState extends State<InternetGainedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        color: Colours.primarygreen,
      ),
    );
  }
}

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "No internet! please try again",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(onPressed: () {}, child: Text("REFRESH"))
      ],
    );
  }
}

class SlowInternetWidget extends StatefulWidget {
  const SlowInternetWidget({super.key});

  @override
  State<SlowInternetWidget> createState() => _SlowInternetWidgetState();
}

class _SlowInternetWidgetState extends State<SlowInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Slow internet! please try again",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(onPressed: () {}, child: Text("REFRESH"))
      ],
    );
  }
}
