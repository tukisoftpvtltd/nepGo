import 'package:http/http.dart' as http;
import '../../../../User/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';
class SearchResponse {
  final int statusCode;
  final String body;

  SearchResponse(this.statusCode, this.body);
}

class SearchPageRepository {
  Future<SearchResponse?> getSearchData(String searchKey,String status,String lat, String long,String isOpen) async {
    try {
      var apiUrl =
          "$baseUrl/api/searchDataForItemsOrServiceProviders?searchKey=$searchKey&service_status=$status&latitude=$lat&longitude=$long&isServiceProviderOpen=$isOpen";
      print(apiUrl);
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      return SearchResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
  Future<SearchResponse?> getSearchDataOrderByNewlyCreated(String searchKey,String status,String lat, String long,String isOpen) async {
    try {
      var apiUrl =
          "$baseUrl/api/searchDataForItemsOrServiceProviders?searchKey=$searchKey&service_status=$status&latitude=$lat&longitude=$long&isServiceProviderOpen=$isOpen&orderByNewOnCreated_at=ASC";
      
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      return SearchResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
    Future<SearchResponse?> getSearchDataOrderByNameASC(String searchKey,String status,String lat, String long,String isOpen) async {
    try {
      var apiUrl =
          "$baseUrl/api/searchDataForItemsOrServiceProviders?searchKey=$searchKey&service_status=$status&latitude=$lat&longitude=$long&orderBYName=ASC&isServiceProviderOpen=$isOpen";
      String? token = await getToken();
      
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {"Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );
      return SearchResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
    Future<SearchResponse?> getSearchDataOrderByNameDESC(String searchKey,String status,String lat, String long,String isOpen) async {
    try {
      var apiUrl =
          "$baseUrl/api/searchDataForItemsOrServiceProviders?searchKey=$searchKey&service_status=$status&latitude=$lat&longitude=$long&orderBYName=DESC&isServiceProviderOpen=$isOpen";
      print(apiUrl);
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
            "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      return SearchResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
  Future<SearchResponse?> getSearchDataOrderByDistance(String searchKey,String status,String lat, String long,String isOpen) async {
    try {
      var apiUrl =
          "$baseUrl/api/searchDataForItemsOrServiceProviders?searchKey=$searchKey&service_status=$status&latitude=$lat&longitude=$long&orderByDistance=ASC&isServiceProviderOpen=$isOpen";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      return SearchResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }

}
