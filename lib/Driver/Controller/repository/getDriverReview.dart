import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/reviewModel.dart';
import '../../View/constants/Constants.dart';
import '../../Model/DriverDetailModel.dart';
import '../../Model/signup_model.dart';


class DriverReviewRepository {
  Future<DriverReviewModel> GetDriverReview
  () async {
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
      var apiUrl = "$baseUrl/api/getDriverReview/$driverId";
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      var data2 = jsonDecode(response.body);
      DriverReviewModel model = DriverReviewModel.fromJson(data2);
      return  model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
