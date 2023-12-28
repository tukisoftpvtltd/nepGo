import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../View/constants/Constants.dart';


class UpdatePlayerIdRepository {
  Future<bool> updatePlayerId
  (String driverId,String PlayerId) async {
    try {
      final Map<String, dynamic> data = {
    'd_id': driverId,
    'playerId': PlayerId,
      };    
      print(data);
      var apiUrl = "$baseUrl/api/updatePlayerId";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print(data2);
      if(data2['status'] == true){
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
