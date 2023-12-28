import 'dart:convert';
import 'package:http/http.dart' as http;

import 'requestModel.dart';




class RequestRepository {
  Future<RequestModel> getrequestData(String driverid, int pageNumber) async {
    try {
      print("The driver id is "+driverid);
      var apiUrl = "https://www.meroato.tukisoft.com.np/api/getSalesByD_id/$driverid?page=$pageNumber";
      print(apiUrl);
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}
      );
      var data = jsonDecode(response.body);
      RequestModel bookingData = RequestModel.fromJson(data);
      return bookingData;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
