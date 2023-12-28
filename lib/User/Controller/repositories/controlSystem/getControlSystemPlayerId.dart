import 'dart:convert';

import 'package:food_app/User/Model/home_page_model.dart';
import 'package:http/http.dart' as http;
import '../../../../User/View/constants/Constants.dart';
import '../../../Model/nearbyControlSystemModel.dart';
import '../../Functions/UserStatus.dart';



class NearByControlSytemRepository {
  Future<NearByControlSytemModel> getNearByDriverData(String lat, String long) async {
    try {
      var apiUrl =
          "$baseUrl/api/getNearByControlSystemPlayerId?latitude=$lat&longitude=$long";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      var data = jsonDecode(response.body);
      print(data);
      NearByControlSytemModel model = NearByControlSytemModel.fromJson(data);
      return model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}