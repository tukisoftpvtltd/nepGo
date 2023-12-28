import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../View/constants/Constants.dart';
class PostDriverLocationResponse{
  final int statusCode;
  final String body;

  PostDriverLocationResponse(this.statusCode, this.body);
}

class DriverLocation{

  Future<PostDriverLocationResponse> PostDriverLocation(String userId, String latitude,String longitude) async {
    try {
      final Map<String, dynamic> data = {
        'd_id': userId,
    'latitude': latitude,
    'longitude':longitude
      };    
      print(data);
      var apiUrl = "$baseUrl/api/updateDriverLocation";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return  PostDriverLocationResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
