import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../User/Controller/Functions/UserStatus.dart';
import '../../../Model/DriverBankDetailModel.dart';
import '../../../View/constants/Constants.dart';

class DriverBankRepository {
  Future<bool> PutDriverBankDetails (String account_name,
  String account_number,String bank_name,String branch_name) async {
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
      Map<String, dynamic> data = {
  "account_name": account_name,
  "account_number": account_number,
  "bank_name": bank_name,
  "bank_branch": branch_name,
  "d_id": driverId
};
print(data);
String? token = await getToken();
      var apiUrl = "$baseUrl/api/driverbankdetails/$driverId";
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: { "Authorization": "Bearer $token",
        'Content-Type': 'application/json'},
        body:json.encode(data)
      );
      var data2 = jsonDecode(response.body);
      print(data2);
      if(data2['status']==true){
        Fluttertoast.showToast(
  msg: "Data Updated",
  toastLength: Toast.LENGTH_SHORT, // Duration for the toast (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
  gravity: ToastGravity.BOTTOM,   // Position of the toast (e.g., ToastGravity.TOP, ToastGravity.CENTER, ToastGravity.BOTTOM)
  timeInSecForIosWeb: 1,         // Duration for iOS (in seconds)
  backgroundColor: Colors.blue,  // Background color of the toast
  textColor: Colors.white,       // Text color of the toast message
  fontSize: 16.0,                // Font size of the toast message
);


      }
      return  true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
  Future<bool> PostDriverBankDetails (String account_name,
  String account_number,String bank_name,String branch_name) async {
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
      Map<String, dynamic> data = {
  "account_name": account_name,
  "account_number": account_number,
  "bank_name": bank_name,
  "bank_branch": branch_name,
  "d_id": driverId
};
print(data);
String? token = await getToken();
      var apiUrl = "$baseUrl/api/driverbankdetails";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body:json.encode(data)
      );
      var data2 = jsonDecode(response.body);
      print(data2);
      if(data2['status']==true){
        Fluttertoast.showToast(
  msg: "Data Updated",
  toastLength: Toast.LENGTH_SHORT, // Duration for the toast (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
  gravity: ToastGravity.BOTTOM,   // Position of the toast (e.g., ToastGravity.TOP, ToastGravity.CENTER, ToastGravity.BOTTOM)
  timeInSecForIosWeb: 1,         // Duration for iOS (in seconds)
  backgroundColor: Colors.blue,  // Background color of the toast
  textColor: Colors.white,       // Text color of the toast message
  fontSize: 16.0,                // Font size of the toast message
);


      }
      return  true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
    Future<DriverBankDetailModel> GetDriverBankDetails () async {
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
      var apiUrl = "$baseUrl/api/driverbankdetails/$driverId";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
          },
      );
      var data2 = jsonDecode(response.body);
      DriverBankDetailModel model = DriverBankDetailModel.fromJson(data2);
      return  model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
