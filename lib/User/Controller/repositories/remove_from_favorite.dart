import 'package:http/http.dart' as http;
import '../../../User/View/constants/Constants.dart';
import '../Functions/UserStatus.dart';
class RemoveFromFavoriteResponse {
  final int statusCode;
  final String body;

  RemoveFromFavoriteResponse(this.statusCode, this.body);
}

class RemoveFromFavoriteRepository {
  Future<RemoveFromFavoriteResponse> RemoveFromFavorite(String userId, String sid) async {
    try {
      var apiUrl = "$baseUrl/api/removeFavourites?user_id=$userId&s_id=$sid";
      String? token = await getToken();
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
           "Authorization": "Bearer $token",
          'Content-Type': 'application/json'},
      );
      return RemoveFromFavoriteResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
