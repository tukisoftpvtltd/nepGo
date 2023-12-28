import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Driver/View/constants/Constants.dart';
import '../../../../User/Controller/Functions/UserStatus.dart';

class CancelRideShareByDriverResponse {
  final int statusCode;
  final String body;

  CancelRideShareByDriverResponse(this.statusCode, this.body);
}

class CancelRideShareByDriverRepository {
  Future<CancelRideShareByDriverResponse> CancelRideShareByDriver
  (String tCode, String cancelReason) async {
    try {
      
      final Map<String, dynamic> data = {
  "tCode": tCode,
  "cancelReason": cancelReason,
};    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/cancelSaleByDriverId";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      return CancelRideShareByDriverResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
