import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../View/constants/Constants.dart';
import '../../Model/signup_model.dart';


class PostDeliveriesRepository {
  Future<bool> PostDeliveries
  (String tCode,String did) async {
    try {
      final Map<String, dynamic> data = {
    'tCode': tCode,
    'd_id': did,
      };    
      print(data);
      var apiUrl = "$baseUrl/api/salesDeliver?tCode=$tCode&d_id=$did";
      print(apiUrl);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print("The post response data is");
      print(data2);
      if(data2['status'] == true){
        Fluttertoast.showToast(
  msg: "Order Accepted",
  toastLength: Toast.LENGTH_SHORT, // Duration for how long the toast should be visible (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
  gravity: ToastGravity.BOTTOM,   // Location where the toast should appear (TOP, CENTER, BOTTOM)
  timeInSecForIosWeb: 1,         // Only for iOS or web
  backgroundColor: Colors.grey,  // Background color of the toast
  textColor: Colors.white,       // Text color of the toast message
  fontSize: 16.0,               // Font size of the toast message
);
      }
      else{
         Fluttertoast.showToast(
  msg: "Error Occured",
  toastLength: Toast.LENGTH_SHORT, // Duration for how long the toast should be visible (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
  gravity: ToastGravity.BOTTOM,   // Location where the toast should appear (TOP, CENTER, BOTTOM)
  timeInSecForIosWeb: 1,         // Only for iOS or web
  backgroundColor: Colors.grey,  // Background color of the toast
  textColor: Colors.white,       // Text color of the toast message
  fontSize: 16.0,               // Font size of the toast message
);
      }
      return  true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
