import 'dart:convert';
import 'package:food_app/User/Model/service_provider_detail_model.dart';
import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../Functions/UserStatus.dart';
class ServiceProviderDetailRepository {
  Future<ServiceProviderDetailModel?> getServiceProviderData(String userId ,String sid) async {
    try {
      var apiUrl =
          "$baseUrl/api/getServiceProviderSingleDetails?user_id=$userId&s_id=$sid";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: { "Authorization": "Bearer $token",
        'Content-Type': 'application/json'},
      );
      var data = jsonDecode(response.body);
      ServiceProviderDetailModel serviceProviderDetailModel = ServiceProviderDetailModel.fromJson(data);
      print(serviceProviderDetailModel);
      return serviceProviderDetailModel;
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
