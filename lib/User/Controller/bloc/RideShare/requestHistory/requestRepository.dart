import 'dart:convert';
import 'package:http/http.dart' as http;

import 'requestModel.dart';




class RequestRepository {
  Future<RequestModel> getrequestData(String uid) async {
    try {
      
      var apiUrl = "https://www.meroato.tukisoft.com.np/api/getSalesByUserId/$uid";
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
