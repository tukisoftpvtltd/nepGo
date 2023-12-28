import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../View/constants/Constants.dart';
class UpdateDriverResponse{
  final int statusCode;
  final String body;
  UpdateDriverResponse(this.statusCode, this.body);
}

class UpdateDriver{
  Future<UpdateDriverResponse> UpdateDriverData (
  String fullname, String email,String mobile_number,
  String vehicle_type,String address,String city,
  String licensefilename,String license_date,
  String bill_book_date,
  String address_temporary,
  String citizenship,
  String vehicle_owner,
  String profile,
  String driver_type,
  String licenseNumber,
  String vehicle_brand,
  String vehicle_color,
  String vehicle_number,
  String vehicle_photos,
  String billbook 
  ) async {
    try {
      int vType = int.parse(vehicle_type);
      final Map<String, dynamic> data = {
     'fullname': fullname,
    'email': email,
    'mobile_number': mobile_number,
    'vehicle_type': vType,
    'address': address,
    'city': city,
    'license':licensefilename,
    'license_expiry_date':license_date,
    'bill_book_expiry_date':bill_book_date,
    'address_temporary':address_temporary,
    'citizenship':citizenship,
    'vehicle_owner':vehicle_owner,
    'profileImage':profile,
    'driver_type':driver_type,
    'driver_license_number':licenseNumber,
    'vehicle_brand':vehicle_brand,
    'vehicle_color':vehicle_color,
    'vechicle_number':vehicle_number,
    'vechicle_photos':vehicle_photos,
    'billbook':billbook
      };
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');  
      print('the driverid is'+driverId.toString());  
      print(data);
      var apiUrl = "$baseUrl/api/driverdetails/$driverId";
      print(apiUrl);
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      var data2 = jsonDecode(response.body);
      print(data2);
      if(data2['success']==true){
        SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fullname',fullname);
    prefs.setString('email',email);
    prefs.setString('phoneno',mobile_number);
              Fluttertoast.showToast(
    msg: "Data Updated",
    toastLength: Toast.LENGTH_SHORT, // Duration of the toast message (SHORT or LONG)
    gravity: ToastGravity.BOTTOM, // Location of the toast message on the screen
    timeInSecForIosWeb: 1, // Time duration for iOS and web platforms
    backgroundColor: Colors.black54, // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
    fontSize: 16.0, // Font size of the toast message
  );
      }
      else{
           Fluttertoast.showToast(
    msg: "Error Occured",
    toastLength: Toast.LENGTH_SHORT, // Duration of the toast message (SHORT or LONG)
    gravity: ToastGravity.BOTTOM, // Location of the toast message on the screen
    timeInSecForIosWeb: 1, // Time duration for iOS and web platforms
    backgroundColor: Colors.black54, // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
    fontSize: 16.0, // Font size of the toast message
  );
      }
  
      return  UpdateDriverResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
   
  Future<UpdateDriverResponse> UpdatePersonalData (
  String fullname, String email,String mobile_number,
  String address,String city
  ) async {
    try {
      final Map<String, dynamic> data = {
    'fullname': fullname,
    'email': email,
    'mobile_number': mobile_number,
    'address': address,
    'city': city,
    'vehicle_type':0,
      };
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');    
      print(data);
      var apiUrl = "$baseUrl/api/driverdetails/$driverId";
      print(apiUrl);
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      var data2 = jsonDecode(response.body);
      if(data2['success']==true){
              Fluttertoast.showToast(
    msg: "Data Updated",
    toastLength: Toast.LENGTH_SHORT, // Duration of the toast message (SHORT or LONG)
    gravity: ToastGravity.BOTTOM, // Location of the toast message on the screen
    timeInSecForIosWeb: 1, // Time duration for iOS and web platforms
    backgroundColor: Colors.black54, // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
    fontSize: 16.0, // Font size of the toast message
  );
      }
  
      return  UpdateDriverResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
   
    
   
   Future<bool> UpdateCitizenship(String filename) async {
    try {
      final Map<String, dynamic> data = {
         'citizenship':filename};    
      print(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
      var apiUrl = "$baseUrl/api/driverdetails/$driverId";
      print(apiUrl);
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print(data2);
      if(data2['success'] == true){
        Fluttertoast.showToast(
    msg: "File Updated",
    toastLength: Toast.LENGTH_SHORT, // Duration of the toast message (SHORT or LONG)
    gravity: ToastGravity.BOTTOM, // Location of the toast message on the screen
    timeInSecForIosWeb: 1, // Time duration for iOS and web platforms
    backgroundColor: Colors.black54, // Background color of the toast
    textColor: Colors.white, // Text color of the toast message
    fontSize: 16.0, // Font size of the toast message
  );


      }
      return true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}

//<2MB