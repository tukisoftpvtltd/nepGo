import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../User/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';
class VerifyOTPRepo{
  Future<bool> verifyOTP(String userId, String OTPCOde) async {
    try {
      final Map<String, dynamic> data = {
        'user_id': userId,
        'otpCode': OTPCOde
      };    
      print(data);
      String? token = await getToken();
      var apiUrl = "$baseUrl/api/checkOtpAndUpdateUserStatus";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print(data2);
      return data2['success'];
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
