import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/View/constants/Constants.dart';
import '../../Model/login_model.dart';
import '../../Model/update_profile_model.dart';
import '../Functions/UserStatus.dart';

class LoginResponse {
  final int statusCode;
  final String body;

  LoginResponse(this.statusCode, this.body);
}

class UpdateProfileRepository {
  Future<UpdateProfileModel> update(String userId,String fname,String lname, String phoneno, String profile) async {
    try {
      var apiUrl = "$baseUrl/api/public-user-account/$userId";
      final Map<String, dynamic> data = {
        'fname': fname,
        'lname': lname,
        'mobile_number': phoneno,
        
      };
      print(data);
      String? token = await getToken();
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      var responseData = jsonDecode(response.body);
      print(responseData);
      SharedPreferences userData = await SharedPreferences.getInstance();
      bool status =responseData['success']??false;
      if(status == true){
      userData.setString('fname', responseData['data']['fname']);
      userData.setString('lname', responseData['data']['lname']);
      userData.setString('phoneno', responseData['data']['mobile_number'].toString());
      Fluttertoast.showToast(
      msg: "Updated Successfully",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // positioning of the toast
      timeInSecForIosWeb: 1, // only for iOS
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
      }
      else{
    Fluttertoast.showToast(
      msg: "Update Failed",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // positioning of the toast
      timeInSecForIosWeb: 1, // only for iOS
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );

      }
      UpdateProfileModel updateModel = UpdateProfileModel.fromJson(responseData);
  
      return updateModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
