import 'package:http/http.dart' as http;
import '../../../../User/View/constants/Constants.dart';
class GetMenuFromBasketResponse {
  final int statusCode;
  final String body;

  GetMenuFromBasketResponse(this.statusCode, this.body);
}

class GetMenuFromBasketRepository {
  Future<GetMenuFromBasketResponse> fetchBasketDetail(String sid) async {
    try {
      var apiUrl =
          "$baseUrl/api/getItemCategoryWithItemsFromServiceProvider?"
          "s_id=$sid";

      var response = await http.get(Uri.parse(apiUrl));
      return GetMenuFromBasketResponse(response.statusCode, response.body);
    } catch (ex) {
      throw ex;
    }
  }
}
