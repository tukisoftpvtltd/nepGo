import 'dart:convert';
import '../../../User/View/constants/Constants.dart';
import 'package:food_app/User/Model/home_page_model.dart';
import 'package:http/http.dart' as http;

import '../../Model/nearby_driver_model.dart';
import '../Functions/UserStatus.dart';

class NearByDriverRepository {
  Future<NearByDriverModel> getNearByDriverData(String lat, String long,String type,String vehicle_type) async {
    try {
      var apiUrl =
          "$baseUrl/api/getNearByDriverPlayerIdList?latitude=$lat&longitude=$long&driver_type=$type&vehicle_type=$vehicle_type";
      print(apiUrl);
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      var data = jsonDecode(response.body);
      print(data);
      NearByDriverModel model = NearByDriverModel.fromJson(data);
      return model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
