import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../../Model/Advertisement.dart';
import '../Functions/UserStatus.dart';

class GetAdvertismentRepository {
  Future<Advertisement?> GetAdvertismentList(String latitude,String longitude,String position) async {
    try {
      var apiUrl =
          "$baseUrl/api/getAdBannerNearBy?latitude=$latitude&longitude=$longitude&adPosition=$position";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      var data = jsonDecode(response.body);
      print(data);
      print(response.body);
      Advertisement advertisement = Advertisement.fromJson(data);
      return advertisement;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
