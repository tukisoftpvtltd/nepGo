import 'dart:convert';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/repositories/Payment/payment_repository.dart';
import '../../../../../Controller/repositories/controlSystem/getControlSystemPlayerId.dart';
import '../../../../../Controller/repositories/get_nearby_driver.dart';
import '../../../../../Model/nearbyControlSystemModel.dart';
import '../../../../../Model/nearby_driver_model.dart';
import '../successPage.dart';

const String KEsewaClientId ='JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';
const String KEsewaSecretKey ='BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';

class Esewa{
  pay({
    required String sid,
    required int discount,
    required int vat,
    required int amount,
    required String tCode,
    required String item1,
    required String quantity1,
    required String item2,
    required String quantity2,
    required String serviceProviderName,
    required String serviceProviderLocation,
    required String logoUrl,
    required String remarks,
    
    }){
     try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId:KEsewaClientId,
          secretId: KEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: "2",
          productName: "Payment",
          productPrice: "$amount",
           callbackUrl: '',
          
        ),
          onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
         verifyTransactionStatus(data,sid,discount,vat,amount,tCode,serviceProviderName,serviceProviderLocation,logoUrl,remarks);

        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
    
  }
  void verifyTransactionStatus(
    EsewaPaymentSuccessResult result,
    String sid,
    int discount,
    int vat, 
    int amount,
    String tcode,
    String serviceProviderName,
     String serviceProviderLocation,
      String logoUrl,
      String remarks

  ) async {
    Map data = result.toJson();
   await callVerificationApi(data['refId'],sid,discount,vat,amount,tcode,serviceProviderName,serviceProviderLocation,logoUrl,remarks);
}

callVerificationApi(
String result,
String sid,
int discount,
int vat,
int amount,
 String tcode,
  String serviceProviderName,
     String serviceProviderLocation,
      String logoUrl,
      String remarks
) async {
    print("TxnRefd Id: " + result);
    var client = http.Client();
    var uri = Uri.parse(
        'https://uat.esewa.com.np/mobile/transaction?txnRefId=$result');
    try {
      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'merchantId': 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
          'merchantSecret': 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        },
      );
      if (response.statusCode == 200) {
     
  AddSale payment = new AddSale();
  SharedPreferences prefs =await SharedPreferences.getInstance();
prefs.getString('isLoggedIn');
List<String> AllPlayerIds = [];
SharedPreferences _locationDetail = await SharedPreferences.getInstance();
String? latitude = _locationDetail.getString('latitude');
String? longitude = _locationDetail.getString('longitude');
String? locationName =  _locationDetail.getString('locationName');
String? placeName =  _locationDetail.getString('placeName');
SharedPreferences userData = await SharedPreferences.getInstance();
String? userId = userData .getString('user_id');

  payment.PostSale(
    userId: userId!,
    sid: sid,
    mode_of_payment: 'esewa',
    discount: "$discount",
    vat: "$vat",
    amount: "$amount",
    paymentNote: "online payment",
    remarks: remarks,
    taxable: "0",
    nonTaxable: "$amount",
    delivery_location: "$locationName,$placeName",
    lat: latitude!,
    long: longitude!,
    PaymentStatus: '1',
    payment_transaction_id: result,
    total: "$amount",
    distance: "1.5",
    delivery_charge: "0",
    payment_note: '',
    tCode: tcode);
    String playerId ='';
     await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('Token $value');
              playerId= value.toString();
            });
          });
    //  var status = await OneSignal.shared.getDeviceState();
    // String? playerId = status!.userId;
    // print("Your player id is");
    // print(playerId);
     NearByControlSytemRepository repo0 = NearByControlSytemRepository();
   NearByControlSytemModel model0 = await repo0.getNearByDriverData(latitude, longitude);
  AllPlayerIds.add(model0.nearestControlSystem!.playerId.toString());
  NearByDriverRepository repo = NearByDriverRepository();
  NearByDriverModel model = await repo.getNearByDriverData(latitude, longitude,'0','0');
  for(int i =0 ; i< model.nearByDriverPlayerIds!.length;i++){
    if(model.nearByDriverPlayerIds![i].playerId.toString() != "null"){
    AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
    }
   
  }
  print("All player Ids are");
  print(AllPlayerIds);
  print("the tcode sent is"+tcode);
  List notifications =[];
  for(int i=0;i<AllPlayerIds.length;i++){
     var data = {
      'to' : AllPlayerIds[i],
      'priority': 'high',
      'data':{
        'userId': userId,
        'sid': sid,
        'serviceProviderName': serviceProviderName,
        'serviceProviderLocation':serviceProviderLocation,
        'logoUrl': logoUrl,
        'basketItems' : '',
        'mode_of_payment': 'esewa',
        'discount': "40",
        'vat': "40",
        'amount': "$amount",
        'paymentNote': "online payment",
        'remarks': "deliver fast",
        'taxable': "0",
        'nonTaxable': "$amount",
        'delivery_location': "$locationName,$placeName",
        'lat': latitude,
        'long': longitude,
        'PaymentStatus': '1',
        'payment_transaction_id': "cash",
        'total':  "$amount",
        'distance': "1.5",
        'delivery_charge': "40",
         'payment_note': '',
         "customerPlayerId":playerId,
         "tCode":tcode,
         "item1":'',
         "quantity1":'',
         "item2":'',
         "quantity2":''
      }
      };
  print(data);
       print(data);
      print("posting Data to");
       print(AllPlayerIds[i]);
       print(AllPlayerIds);  
      var response = await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
   
    };
     Get.offAll(PaymentSucessPage());
   

    //   for(int i=0;i<AllPlayerIds.length;i++){
    //     try{
    // await OneSignal.shared.postNotification(notifications[i]);
    //   }
    //   catch(e){
    //     print("The error is "+e.toString());
    //   }
    //   }                               

  // Get.offAll(
  //    BlocProvider<SignInBloc>(
  //           create: (context) => SignInBloc(context),
  //           child: BlocProvider<HomePageBloc>(
  //             create: (context) => HomePageBloc(),
  //             child: BlocProvider(
  //               create: (context) => HomeNavigationBloc(),
  //               child: HomeScreensNavigation(
  //                 currentIndexNumber: 0,
  //                 loginStatus: "true",
  //                 homeData: [],
  //                 advertisementData:[],
  //               ),
  //             ),
  //           ),
  //         )
  // );
      }
      else{
     Fluttertoast.showToast(
  msg: 'Payment Failed',
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.black87,
  textColor: Colors.white,
  fontSize: 16.0,
);
}
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

