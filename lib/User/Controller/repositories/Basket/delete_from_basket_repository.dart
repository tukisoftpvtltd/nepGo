import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../User/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';
class DeleteFromBasketResponse {
  final int statusCode;
  final String body;

  DeleteFromBasketResponse(this.statusCode, this.body);
}

class DeleteFromBasketRepository {
  Future<DeleteFromBasketResponse> DeleteFromBasket(
    String uid,
      String s_id, int item_id) async {
        
    try {
       SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
      var apiUrl = "$baseUrl/api/deleteBasketItems";
      final Map<String, dynamic> data = {
        'user_id': userId,
        's_id': s_id,
        'item_id':item_id
      };
      String? token = await getToken();
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return DeleteFromBasketResponse(response.statusCode,response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
