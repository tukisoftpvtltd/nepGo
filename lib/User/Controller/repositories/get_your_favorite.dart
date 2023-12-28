import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../Functions/UserStatus.dart';
class GetfavoriteResponse {
  final int statusCode;
  final String body;

  GetfavoriteResponse(this.statusCode, this.body);
}

class GetYourFavoriteRepository {
  Future<GetfavoriteResponse?> getFavoriteList(String userId) async {
    try {
      print("The user id is"+userId);

      var apiUrl =
          "$baseUrl/api/getFavourites?user_id=$userId";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      return GetfavoriteResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
