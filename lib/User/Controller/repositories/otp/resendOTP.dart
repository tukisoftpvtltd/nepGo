import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../User/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';
class ResendOTPRepo{
  Future<bool> resendOTP(String userId, String phoneno) async {
    try {
      final Map<String, dynamic> data = {
        'user_id': userId,
        'mobile_number': phoneno
      };    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/resendOTPCode";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      
      print(data2);
      return true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}

