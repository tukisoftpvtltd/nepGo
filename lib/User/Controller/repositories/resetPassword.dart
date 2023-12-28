import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/View/constants/Constants.dart';
import '../../Model/login_model.dart';


class ResetPasswordRepository {
  Future<bool> resetPassword(String userId,String newPassword) async {
    try {
      var apiUrl = "$baseUrl/api/resetPassword";
      final Map<String, dynamic> data ={
      "user_id": userId,
      "new_password": newPassword
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      var responseData = jsonDecode(response.body);
      print(responseData);
      String message = responseData['message']??''; 
      print("The message is ");
      print(data);
      if(responseData['message'] == "Password changed successfully"){
        message = "Password Changed";
      }
    
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // positioning of the toast
      timeInSecForIosWeb: 1, // only for iOS
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
      return true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
