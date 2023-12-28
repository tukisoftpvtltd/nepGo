
import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../Functions/UserStatus.dart';
class SearchResponse {
  final int statusCode;
  final String body;

  SearchResponse(this.statusCode, this.body);
}

class SearchRepository {
  Future<SearchResponse?> getSearchData(String serchKey,String lat,String long) async {
    try {
      var apiUrl =
          "$baseUrl/api/searchDataForItemsOrServiceProviders?"
          "searchKey=s"
          "&service_status=2"
          "&latitude=$lat"
          "&longitude=$long";
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