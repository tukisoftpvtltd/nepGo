import 'dart:convert';
import 'package:food_app/User/Model/signup_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/View/constants/Constants.dart';
import '../../View/Screens/HomeScreens/Account/SignUp/OTPPage.dart';

class SignUpResponse {
  final int statusCode;
  final String body;

  SignUpResponse(this.statusCode, this.body);
}

class SignUpRepository {
  Future<String?> SignUp(String fname, String lname, String email,
      String mobile_numnber, String password, String gender) async {
    try {
      var apiUrl =
          "$baseUrl/api/public-user-account";
      final Map<String, dynamic> data = {
        'fname': fname,
        'lname': lname,
        'email': email,
        'mobile_number': mobile_numnber,
        'password': password
      };
      print(data);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var responseData = jsonDecode(response.body.toString());
      print(responseData);
      // print(responseData['success']);
      // print(responseData['otp']);
      // print(responseData['data']['user_id']);
      // print(responseData['access_token']);
      print("your status is");
      print(responseData['status']);
      bool success = responseData['success'] ?? false;
      
      
      // print(success);
      // print(userId);
      // print(otp);
      // print(accessToken);
      
      if(success == true){
        int userId = responseData['data']['user_id'];
      int otp = responseData['otp'];  
      String accessToken = responseData['access_token'];
      String stringUserId = userId.toString();
      print(stringUserId);
      String stringOtp = otp.toString();
        print("Entered in success");
        SharedPreferences userData = await SharedPreferences.getInstance();
         userData.setString('user_id',stringUserId);
         userData.setString('access_token',accessToken);
        //  String? userId = userData.getString('user_id');
         String? otpCode = otp.toString();
         print(otpCode);
         print(stringUserId);
      Get.to(OTPPage(false, email, password, otpCode ,mobile_numnber,stringUserId));

      }
      else{
        String error = responseData['message'];
        return error;
      }
      // print("getting Sign Up Model");
      // signupmodel signUpModel = signupmodel.fromJson(responseData);
      // print("Sign Up Model Sucess");
      return "true";
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
