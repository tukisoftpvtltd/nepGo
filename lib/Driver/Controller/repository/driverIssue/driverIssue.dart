import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Driver/View/constants/Constants.dart';
import '../../../../User/Controller/Functions/UserStatus.dart';

class DriverIssueResponse {
  final int statusCode;
  final String body;

  DriverIssueResponse(this.statusCode, this.body);
}

class DriverIssueRepository {
  Future<DriverIssueResponse> updateDriverIssue
  (String tCode, String driverIssueReport) async {
    try {
      
      final Map<String, dynamic> data = {
  "tCode": tCode,
  "driverIssueReport": driverIssueReport,
};    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/updateRideShareIssueByDriver";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      print(response.statusCode);
      return DriverIssueResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
