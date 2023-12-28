import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/add_to_cart_model.dart';
import '../../../View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';



class DeleteBasketRepository {
  Future<bool> DeleteRestroBasket(
      String s_id,) async {
    try {
      SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
      var apiUrl = "$baseUrl/api/deleteServiceProviderBasketItems";
      final Map<String, dynamic> data = {
        'user_id': userId,
        's_id': s_id,
      };
      print(apiUrl);
      print(data);
      String? token = await getToken();
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var responseData = jsonDecode(response.body);
      print(response.body);
      bool success = responseData['success']??false;
      if(success == true){
        return true;
      }
      else{
        return false;
      }
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
