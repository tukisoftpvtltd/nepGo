import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../User/View/constants/Constants.dart';
import '../../../Model/add_to_cart_model.dart';
import '../../Functions/UserStatus.dart';



class AddToBasketRepository {
  Future<AddToBasketModel> AddToBasket(
      String s_id, int quantity, int item_id, int price, String note,bool update) async {
    try {
      SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
      var apiUrl = "$baseUrl/api/addBasket";
      final Map<String, dynamic> adddata = {
        'user_id': userId,
        's_id': s_id,
        'quantity': quantity,
        'item_id': item_id,
        'price': price,
        'note': note,
      };
        final Map<String, dynamic> updatedata = {
        'user_id': userId,
        's_id': s_id,
        'quantity': quantity,
        'item_id': item_id,
        'price': price,
        'note': note,
        'updateTocart':'y',
      };
      var data;
      print(data);
      update == false? data =adddata : data = updatedata;
      print(data);
      String? token = await getToken();
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: { "Authorization": "Bearer $token",
        'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var responseData = jsonDecode(response.body);
      AddToBasketModel addToBasketModel =
          AddToBasketModel.fromJson(responseData);
      print(addToBasketModel.status);
      print(addToBasketModel.message);
      return addToBasketModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
