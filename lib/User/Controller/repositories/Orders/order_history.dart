import 'dart:convert';
import '../../../../User/View/constants/Constants.dart';
import 'package:food_app/User/Model/my_order_model.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Account/OrderHistory/order_history.dart';
import 'package:http/http.dart' as http;

import '../../../Model/order_history_model.dart';
import '../../Functions/UserStatus.dart';


class OrderResponse {
  final int statusCode;
  final String body;

  OrderResponse(this.statusCode, this.body);
}

class GetOrderHistoryRepository {
  Future<OrderHistoryModel> getOrderhistory(String userId) async {
    try {
      var apiUrl =
          "$baseUrl/api/getUserPurchaseHistory?user_id=$userId";
      print(apiUrl);
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      var data = jsonDecode(response.body);
      OrderHistoryModel model = OrderHistoryModel.fromJson(data);
      return model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
