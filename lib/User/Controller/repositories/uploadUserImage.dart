import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/signup_model.dart';
import '../../View/constants/Constants.dart';


class UploadUserImageRepo {
  Future<bool> UploadUserImage
  (String file,String imageName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId  = await prefs.getString('user_id')!;
      print("the user id is"+userId);
      final Map<String, dynamic> data = {
    'file':file,
    'imageName':imageName,
    'user_id':userId
      };    
      print(data);
      var apiUrl = "$baseUrl/api/uploadUserProfile";
      //?file=$file&imageName=$imageName&user_id=1
      print("The url is"+apiUrl);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data)
      );
      var data2 = jsonDecode(response.body);
      print("The Upload Image response is");
      print(data2);
      if(data2['status'] ==true){
        print('Images saved');
        prefs.setString('user_thumbnail', '$baseUrl/userprofile/${data2['imageFile']}');
      }
      return  true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
