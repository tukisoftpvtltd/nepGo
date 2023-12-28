import 'dart:convert';
import 'package:food_app/User/Model/basket_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../User/View/constants/Constants.dart';
class BasketListRepository {
  Future<BasketListModel> fetchBasketList() async {
    try {
       SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
    print("the user id");
    print(userId);
      var apiUrl =
          "$baseUrl/api/getServiceProviderWithTotalItemCountFromBasket?user_id=$userId";
      print(apiUrl);
      var response = await http.get(Uri.parse(apiUrl));
      var data =jsonDecode(response.body);
      BasketListModel basketListModel= BasketListModel.fromJson(data);
      return basketListModel;
    } catch (ex) {
      throw ex;
    }
  }
}
