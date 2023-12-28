import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import 'package:food_app/User/Controller/repositories/otp/resendOTP.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Account/OTP.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/HomeScreensNavigation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import '../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../Controller/repositories/otp/verifyOTP.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/BackButton2.dart';
import '../../../../widgets/button.dart';


class OTPPage extends StatefulWidget {
  bool? fromLogin;
  final String email;
  final String password;
  final String phoneno;
  final String OTPCode;
  final String userId;
  OTPPage(this.fromLogin, this.email,this.password, this.OTPCode,this.phoneno,this.userId, {Key? key}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String OTP = '';

  bool loading = false;
  int min = 1;
  int second = 59;
  // bool _passwordVisible = false;

  @override
  void dispose() {
 
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    OTP = widget.OTPCode;
    super.initState();
  }

  


  OtpChecker() async{
    setState(() {
      loading = true;
    });
    String inputOTP = _otpController1.text + _otpController2.text+ _otpController3.text+ _otpController4.text;
    VerifyOTPRepo verify = VerifyOTPRepo();
    bool isVerified = await verify.verifyOTP(widget.userId,inputOTP );
    if(isVerified ==true && widget.fromLogin ==true){
      Fluttertoast.showToast(
      msg: "Sign Up Successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
    Get.back();
    }
    else if(isVerified == true){
      Fluttertoast.showToast(
      msg: "Sign Up Successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
    
    Get.back();
    Get.back();
    }
    else{
      Fluttertoast.showToast(
      msg: "Invalid OTP",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
    }
    setState(() {
      loading = false;
    });
  }

resendOtp(){
  ResendOTPRepo repo = ResendOTPRepo();
  repo.resendOTP(widget.userId, widget.phoneno);
   Fluttertoast.showToast(
      msg: "OTP Resent",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
  

  _goToSignUpSetPassword(String userEmail) async {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  SignUpSetPassword(userEmail)));
    //
  }
  @override
  // ignore: must_call_super

  final _userPasswordController = TextEditingController();
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();

  bool boxColor1 = false;
  bool boxColor2 = false;
  bool boxColor3 = false;
  bool boxColor4 = false;
  bool boxColor5 = false;
  bool agreeTerms = false;
  void nothing() {}
  String maskEmail(String email) {
  if (email == null || !email.contains('@')) {
    return email; // Return unchanged if not a valid email
  }

  List<String> parts = email.split('@');
  String firstPart = parts[0];
  String domain = parts[1];

  if (firstPart.length <= 2) {
    return email; // Return unchanged if the first part is too short to mask
  }

  String maskedPart = firstPart[0] + '*' * (firstPart.length - 2) + firstPart[firstPart.length - 1];
  return '$maskedPart@$domain';
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton2(),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(100,0,0,0),
          child: Text("Sign Up",
          style: TextStyle(color: Colors.black,fontFamily: 'Poppins'),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
              const SizedBox(height: 10),
              const Logo(),
                    const SizedBox(height: 5),
                    Text(
                      'SIGN UP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colours.primarygreen,
                      ),
                    ),
                    const SizedBox(height: 5),
                     Text(
                      'Enter the Verification code sent to you at: \n+977 '+ widget.phoneno ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
           

            Form(
                child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: boxColor1 ? Colors.green : Colors.grey,
                                width: 1.4),
                            borderRadius: BorderRadius.circular(10)),
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          controller: _otpController1,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                boxColor1 = true;
                              });
                            }
                            if (value.length == 0) {
                              setState(() {
                                boxColor1 = false;
                              });
                            }
                          },
                          onSaved: (pin1) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: boxColor2 ? Colours.primarygreen : Colors.grey,
                                width: 1.4),
                            borderRadius: BorderRadius.circular(10)),
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          controller: _otpController2,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                boxColor2 = true;
                              });
                            }
                            if (value.length == 0) {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                boxColor2 = false;
                              });
                            }
                          },
                          onSaved: (pin1) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: boxColor3 ? Colors.green : Colors.grey,
                                width: 1.4),
                            borderRadius: BorderRadius.circular(10)),
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          controller: _otpController3,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                boxColor3 = true;
                              });
                            }
                            if (value.length == 0) {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                boxColor3 = false;
                              });
                            }
                          },
                          onSaved: (pin1) {
                            print(pin1);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: boxColor4 ? Colors.green : Colors.grey,
                                width: 1.4),
                            borderRadius: BorderRadius.circular(10)),
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          controller: _otpController4,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                boxColor4 = true;
                              });
                            }
                            if (value.length == 0) {
                              FocusScope.of(context).previousFocus();
      
                              setState(() {
                                boxColor4 = false;
                              });
                            }
                          },
                          onSaved: (pin1) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10, 25, 15, 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text('Expires in ', style: TextStyle()),
                //       Text("$min: $second",
                //           style: TextStyle(color: Colors.green)),
                //     ],
                //   ),
                // ),
                
                GestureDetector(
                  onTap: () {
                    setState(() {
                      
                      print("Hello");
                      print(widget.email);
                      min = 1;
                      second = 59;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn’t receive OTP?   ",
                          style: TextStyle(color: Colors.black,
                          fontFamily: 'Poppins'),
                        ),
                        GestureDetector(
                          onTap: (){
                           resendOtp();
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(color: Colours.primarygreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )),
             Padding(
      padding: const EdgeInsets.fromLTRB(20,40,20,10),
      child: Container(
        width: screenWidth,
        child: CustomButton(
                              label: loading == true?'loading':'Continue',
                              color: Colours.primarygreen,
                              onpressed: () async {
                             
            OtpChecker();
          
                              },
                            ),
      ),
    ),
          ],
        ),
      ),
   
    );
  }
}
