import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/View/constants/Constants.dart';
import '../../Model/login_model.dart';

class LoginResponse {
  final int statusCode;
  final String body;

  LoginResponse(this.statusCode, this.body);
}

class LoginRepository {
  Future<LoginModel> Login(String email, String password) async {
    try {
      var apiUrl = "$baseUrl/api/userLogin";
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      var responseData = jsonDecode(response.body);
      print(responseData);
      SharedPreferences userData = await SharedPreferences.getInstance();
      if(response.statusCode ==201){
        print("Here");
      String? userId = responseData['data']['user_id'].toString();
      userData.setString('user_id', userId);
      userData.setString('fname', responseData['data']['fname']);
      userData.setString('token', '');
      userData.setString('lname', responseData['data']['lname']);
      userData.setString('email', responseData['data']['email']);
      userData.setString('phoneno', responseData['data']['mobile_number'].toString());
      }
      else{
    Fluttertoast.showToast(
      msg: "Login Error Occured",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // positioning of the toast
      timeInSecForIosWeb: 1, // only for iOS
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );

      }
      LoginModel loginModel = LoginModel.fromJson(responseData);
      print(loginModel);
      return loginModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
