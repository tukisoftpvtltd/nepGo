import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../View/constants/Constants.dart';


class UpdateDeliveriesRepository {
  Future<bool> UpdateDeliveries
  (String tCode,String did,String status) async {
    try {
      final Map<String, dynamic> data = {
    'tCode': tCode,
    'd_id': did,
    'status' : status
      };    
      print(data);
      var apiUrl = "$baseUrl/api/sales-delivery/$tCode/$did/$status";
      print(apiUrl);
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      var data2 = jsonDecode(response.body);
      print("The put response data is");
      print(data2);
      if(data2['status'] == true && status.toString() == "1"){
        Fluttertoast.showToast(
  msg: "Scanned Successfully",
  toastLength: Toast.LENGTH_SHORT, // Duration for how long the toast should be visible (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
  gravity: ToastGravity.BOTTOM,   // Location where the toast should appear (TOP, CENTER, BOTTOM)
  timeInSecForIosWeb: 1,         // Only for iOS or web
  backgroundColor: Colors.grey,  // Background color of the toast
  textColor: Colors.white,       // Text color of the toast message
  fontSize: 16.0,               // Font size of the toast message
);
      }
        else if(data2['status'] == true && status.toString() == "4"){
        Fluttertoast.showToast(
  msg: "Picked Up Successfully",
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
  msg: "Scan Failed",
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
