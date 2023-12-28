import 'package:shared_preferences/shared_preferences.dart';

Future<String?> isUserLoggedIn() async {
  String? userLoginStatus;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLoginStatus = prefs.getString('isLoggedIn');
    return userLoginStatus;
  }
Future<String?> getToken()async{
  String? token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  return token;
}