import 'dart:convert';
import 'package:food_app/Driver/Model/MyDeliveriesModel.dart';
import 'package:http/http.dart' as http;
import '../../View/constants/Constants.dart';
class MyDeliveries{
  Future<MyDeliveriesModel> GetMyDeliveries(String tCode) async {
    try {
        
      var apiUrl = "$baseUrl/api/getSalesByTCode/$tCode";
      print(apiUrl);
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      var data2 = jsonDecode(response.body);
      MyDeliveriesModel model = MyDeliveriesModel.fromJson(data2);
      return  model;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
