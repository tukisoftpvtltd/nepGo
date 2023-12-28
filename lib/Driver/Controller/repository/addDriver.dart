import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../User/View/constants/Constants.dart';
import '../../Model/signup_model.dart';


class AddDriverRepository {
  Future<PostDriverModel> AddDriver
  (String fullName,String email,
  String mobile_number, String password,
  String vehicle_type, String address,String city,int driver_type) async {
    try {
      final Map<String, dynamic> data = {
    'fullname': fullName,
    'email': email,
    'mobile_number': mobile_number,
    'password': password,
    'vehicle_type': vehicle_type,
    'address': address,
    'city': city,
    'driver_type':driver_type,
      };    
      print(data);
      var apiUrl = "$baseUrl/api/driverdetails";
      print("the data is"+data.toString());
      print("the url is"+apiUrl);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print("The response is"+data2.toString());
      PostDriverModel model = PostDriverModel.fromJson(data2);
      return  model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
