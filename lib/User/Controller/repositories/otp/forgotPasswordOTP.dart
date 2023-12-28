import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../View/Screens/HomeScreens/Account/ForgetPassword/otpCode.dart';
import '../../../View/constants/Constants.dart';

class SendForgotPasswordOTP{
  Future<bool> resendForgotPasswordOTP(String phoneno) async {
    try {
    
      var apiUrl = "$baseUrl/api/resendOTPCodeForForgetPassword";
        final Map<String, dynamic> data = {
        'mobile_number': phoneno
      };    
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print(response.body);
      print("the data is");
      print(data2);
      int status_code = data2['status_code']??0;
      if(status_code ==200){
        int userId = data2['user_id'];
        String UID = userId.toString();
        Get.to(VerifyOTPPage(
         false,true,'','','',phoneno,UID));
      }
      else{
        Fluttertoast.showToast(
  msg: "Phone number is not valid",
  toastLength: Toast.LENGTH_SHORT, // Duration of the toast message
  gravity: ToastGravity.BOTTOM, // Toast gravity (position)
  timeInSecForIosWeb: 1, // Time in seconds for iOS (web ignored)
  backgroundColor: Colors.black, // Background color of the toast
  textColor: Colors.white, // Text color of the toast
);
      }
      
      return true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}