import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../Driver/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';
class AddDriverReviewResponse {
  final int statusCode;
  final String body;

  AddDriverReviewResponse(this.statusCode, this.body);
}

class AddDriverReviewRepository {
  Future<AddDriverReviewResponse> AddDriverReview(String userId, String sid,String title,String reviews, int stars) async {
    try {
      final Map<String, dynamic> data = {
        'user_id': userId,
        'd_id': sid,
        'title':title,
        'reviews':reviews,
        "star":stars,
      };    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/adddriverReview";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return AddDriverReviewResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
