import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../Functions/UserStatus.dart';
class AddToFavoriteResponse {
  final int statusCode;
  final String body;

  AddToFavoriteResponse(this.statusCode, this.body);
}

class AddToFavoriteRepository {
  Future<AddToFavoriteResponse> AddToFavorite(String userId, String sid) async {
    try {
  
      var apiUrl = "$baseUrl/api/addtotheFavoutites";
      final Map<String, dynamic> data = {
        'user_id': userId,
        's_id': sid,
      };
      String? token = await getToken();
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
        'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return AddToFavoriteResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
