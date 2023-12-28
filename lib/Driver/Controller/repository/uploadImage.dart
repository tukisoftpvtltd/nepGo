import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Model/signup_model.dart';
import '../../View/constants/Constants.dart';


class UploadImageRepo {
  Future<bool> UploadImage
  (String file,String imageName) async {
    try {
      print("the image name is"+imageName);
      final Map<String, dynamic> data = {
    'file':file,
    'imageName':imageName,
      };    
      print(data);
      var apiUrl = "$baseUrl/api/uploadImageForDriver";
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      var data2 = jsonDecode(response.body);
      print("The Upload Image response is");
      print(data2);
      return  true;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
