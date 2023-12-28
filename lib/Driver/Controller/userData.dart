import 'package:shared_preferences/shared_preferences.dart';

getData()async{
SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('isDriverLoggedIn', 'true');
    //  prefs.setString('fullname', fullname!);
    //     prefs.setString('email', email!);
    //     prefs.setString('phoneno', phoneno!);
  }