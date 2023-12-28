// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:food_app/User/Model/signup_model.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'Screens/HomeScreens/Account/SignUp/OTPPage.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   signupmodel? signUpResponse;
//   @override
//   void initState() {
//     super.initState();
//     getData();

//   }
//   getData()async{
//     var responseData = jsonDecode('''
//       {
//         "success": true,
//         "message": "User created successfully.",
//         "data": {
//           "fname": "Aashish",
//           "lname": "Wagle",
//           "email": "aashish@gmail.com",
//           "mobile_number": "9860500185",
//           "email_verified": 0,
//           "gender": null,
//           "user_country": null,
//           "user_profession": null,
//           "user_thumbnail": null,
//           "user_catagory": 0,
//           "otp_code": 3972,
//           "is_deleted": 0,
//           "blog": 0,
//           "password": "2y10Q9FRI1QsfOkigoPdbSbND3WiypBnJZsiojDhQqRbAK8bMh8q7yy",
//           "updated_at": "2023-08-30T07:26:29.000000Z",
//           "created_at": "2023-08-30T07:26:29.000000Z",
//           "user_id": 2
//         },
//         "access_token": "489|tSagprqttbvWEO0ZpTMv0cUOdB9LeAHwowgP3gK0",
//         "otp": 3972,
//         "OTPResponse": {
//           "count": 1,
//           "response_code": 200,
//           "response": "1 messages has been queued for delivery",
//           "message_id": 331981408,
//           "credit_consumed": 1,
//           "credit_available": 9986.0
//         },
//         "OTP Status Code": 200
//       }
//     ''');
//     signUpResponse = signupmodel.fromJson(responseData);
//     // print("Sign Up 1");
//     //   print(signUpResponse?.success.toString());                               
//     //   if (signUpResponse?.success.toString() == "true") {
//     //     print("Signed In");
//     //      SharedPreferences userData = await SharedPreferences.getInstance();
//     //      userData.setString('user_id',signUpResponse!.data!.userId.toString());
//     //      String? userId = userData.getString('user_id');
//     //      String? otpCode = signUpResponse.otp.toString();
         
//     //      print(otpCode);
//     //      print(userId);
//     //   Get.to(OTPPage('', '', otpCode ,'',userId!));
            
//     //    } 
//     //    else {
//     //     String? error =  signUpResponse!.message.toString();
      
//     //    }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: Column(
//           children: [
//             Text("Hello"),
//             Text(signUpResponse!.success.toString()),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
