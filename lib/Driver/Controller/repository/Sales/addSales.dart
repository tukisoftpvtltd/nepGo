import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../User/Controller/Functions/UserStatus.dart';
import '../../../View/constants/Constants.dart';
class AddSalesResponse {
  final int statusCode;
  final String body;

  AddSalesResponse(this.statusCode, this.body);
}

class AddRideShareSalesRepository {
  Future<AddSalesResponse> AddSales
  (String userId, String tCode,String did,int amount,
   String remarks,String pickuplocation,String destinationLocation,double distance) async {
    try {
      final Map<String, dynamic> data = {
  "user_id": userId,
  "tCode": tCode,
  "d_id": did,
  "amount": amount,
  "remarks": remarks,
  "pickup_location": pickuplocation,
  "detination_location": destinationLocation,
  "distance": distance
};    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/addRideShareSale";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print(response.body);
      return AddSalesResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
