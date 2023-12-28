import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../View/constants/Constants.dart';
import '../../Model/DriverDetailModel.dart';
import '../../Model/signup_model.dart';


class DriverRepository {
  Future<DriverDetailModel> GetDriver
  () async {
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
      var apiUrl = "$baseUrl/api/driverdetails/$driverId";
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      var data2 = jsonDecode(response.body);
      DriverDetailModel model = DriverDetailModel.fromJson(data2);
      return  model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
