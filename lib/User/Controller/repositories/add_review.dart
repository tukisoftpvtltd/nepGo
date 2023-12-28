import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../Functions/UserStatus.dart';
class AddReviewResponse {
  final int statusCode;
  final String body;

  AddReviewResponse(this.statusCode, this.body);
}

class AddReviewRepository {
  Future<AddReviewResponse> AddReview(String userId, String sid,String title,String reviews, int stars) async {
    try {
      final Map<String, dynamic> data = {
        'user_id': userId,
        's_id': sid,
        'title':title,
        'reviews':reviews,
        "star":stars,
      };    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/addReview";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return AddReviewResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
