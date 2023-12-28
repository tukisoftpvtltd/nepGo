import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Driver/View/constants/Constants.dart';
import '../../../../User/Controller/Functions/UserStatus.dart';

class CompleteRideByDriverResponse {
  final int statusCode;
  final String body;

  CompleteRideByDriverResponse(this.statusCode, this.body);
}

class CompleteRideByDriverRepository {
  Future<CompleteRideByDriverResponse> CompleteRideByDriver
  (String tCode) async {
    try {
      
      final Map<String, dynamic> data = {
  "tCode": tCode,
};    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/makeRideCompleted/$tCode";
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      print(response.body);
      print(response.statusCode);
      return CompleteRideByDriverResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
