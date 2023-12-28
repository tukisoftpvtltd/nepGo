import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../View/constants/Constants.dart';
import '../../../Functions/UserStatus.dart';


class UserRideShareIssueResponse {
  final int statusCode;
  final String body;

  UserRideShareIssueResponse(this.statusCode, this.body);
}

class UserRideShareIssueRepository {
  Future<UserRideShareIssueResponse> updateUserRideShareIssue
  (String tCode, String driverIssueReport) async {
    try {
      
      final Map<String, dynamic> data = {
  "tCode": tCode,
  "userIssueReport": driverIssueReport,
};    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/updateRideShareIssueByUser";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      print(response.statusCode);
      return UserRideShareIssueResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
