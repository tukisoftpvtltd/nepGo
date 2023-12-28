import 'dart:convert';
import '../../../User/View/constants/Constants.dart';
import 'package:food_app/User/Model/home_page_model.dart';
import 'package:http/http.dart' as http;

import '../Functions/UserStatus.dart';


class HomeResponse {
  final int statusCode;
  final String body;
  HomeResponse(this.statusCode, this.body);
}

class HomePageRepository {
  Future<HomePageModel> getHomePageData(String lat, String long) async {
    try {
      var apiUrl =
         "$baseUrl/api/homepageData?latitude=$lat&longitude=$long";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json'
        },
      );
      var data = jsonDecode(response.body);
      print(data);
      HomePageModel homePageModel = HomePageModel.fromJson(data);

      return homePageModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
