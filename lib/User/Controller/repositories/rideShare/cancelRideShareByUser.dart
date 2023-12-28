import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Driver/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';

class CancelRideShareByUserResponse {
  final int statusCode;
  final String body;

  CancelRideShareByUserResponse(this.statusCode, this.body);
}

class CancelRideShareByUserRepository {
  Future<CancelRideShareByUserResponse> CancelRideShareByUser
  (String tCode, String cancelReason) async {
    try {
      
      final Map<String, dynamic> data = {
  "tCode": tCode,
  "cancelReason": cancelReason,
};    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/cancelSaleByUserId";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      return CancelRideShareByUserResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
