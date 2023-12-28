import 'dart:convert';
import '../../../../User/View/constants/Constants.dart';
import 'package:food_app/User/Model/my_order_model.dart';
import 'package:http/http.dart' as http;

import '../../Functions/UserStatus.dart';


class GetYourOrderRepository {
  Future<MyOrderModel> getOrderRequest(String userId) async {
    try {
      var apiUrl =
          "$baseUrl/api/getUserRequestHistory?user_id=$userId";
      print(apiUrl);
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: { "Authorization": "Bearer $token",
        'Content-Type': 'application/json'},
      );
      var data = jsonDecode( response.body);
      MyOrderModel model = MyOrderModel.fromJson(data);
      return model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
