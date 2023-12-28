import 'dart:convert';
import 'package:food_app/Driver/Model/login_model.dart';
import 'package:http/http.dart' as http;
import '../../View/constants/Constants.dart';
import '../../Model/signup_model.dart';


class DriverLoginRepository {
  Future<LoginModel> Login
  (String email, String password) async {
    try {
      final Map<String, dynamic> data = {
    'email': email,
    'password': password,
      };    
      print(data);
      var apiUrl = "$baseUrl/api/driverLogin";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print(data2);
      LoginModel model = LoginModel.fromJson(data2);
      return  model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}