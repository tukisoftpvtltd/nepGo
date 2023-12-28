import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/constants/Constants.dart';

class ChangeDriverPasswordResponse {
  final int statusCode;
  final String body;

  ChangeDriverPasswordResponse(this.statusCode, this.body);
}

class ChangeDriverPasswordRepository {
  Future<ChangeDriverPasswordResponse> ChangeDriverPassword
  (String userId, String password,) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? did = prefs.getString('driverId'); 
      
      final Map<String, dynamic> data = {
        'd_id': did,
    'password': password,
      };    
      print(data);
      var apiUrl = "$baseUrl/api/changeDriverPassword";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = json.decode(response.body) ;
      print(data2);
      if(data2['status'].toString() =='true'){
        Fluttertoast.showToast(
  msg: "Password Updated",
  toastLength: Toast.LENGTH_SHORT, // Duration for which the toast is displayed (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
  gravity: ToastGravity.BOTTOM, // Position of the toast (TOP, CENTER, or BOTTOM)
  timeInSecForIosWeb: 1, // Only used for iOS and web (duration)
  backgroundColor: Colors.black, // Background color of the toast
  textColor: Colors.white, // Text color of the toast message
  fontSize: 16.0, // Font size of the toast message
);


      }
      return  ChangeDriverPasswordResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
