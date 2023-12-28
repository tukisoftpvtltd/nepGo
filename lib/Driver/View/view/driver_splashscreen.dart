import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:food_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import 'home_page.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String finalEmail = '';

class _SplashScreenState extends State<SplashScreen> {

  
  @override
  void initState() {
   
    super.initState();
    _startNavigationTimer();
  
  }

  bool goToHome = false;
  bool goToNoInternetPage = false;

  void _startNavigationTimer() {  
    // Start the timer to navigate after 2000 milliseconds (2 seconds)
    Timer(Duration(milliseconds: 1000), _navigateFromSplashScreen);
  }
    String driver_type = '0';
  getDriverType()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    driver_type = prefs.getString('driver_type')??'0';
    print("The driver type is $driver_type");
  }
  String? userLoginStatus = 'false';
  _navigateFromSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLoginStatus = prefs.getString('isDriverLoggedIn');
    print("The user is currently:");
    print(userLoginStatus);
   LocationPermission permission = await Geolocator.checkPermission();
    try {
      print("The Permission is");
      print(permission);
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request');
      }
      userLoginStatus = prefs.getString('isDriverLoggedIn');
      print("The user is currently:");
      print(userLoginStatus);
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
    if (userLoginStatus.toString() == 'true') {
      await getDriverType();
      Get.offAll(BlocProvider(
        create: (context) => SignInBloc(context),
        child: HomePage(
          driver_type: driver_type,
        ),
      ));
    } else {
 Get.offAll(BlocProvider(
        create: (context) => SignInBloc(context),
        child: Loginpage(),
      ));
    }
  }
    }
    catch(e){
      print("Error "+e.toString());
    }
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colours.primarygreen,
                    ),
                  ),
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
    );
  }
}
