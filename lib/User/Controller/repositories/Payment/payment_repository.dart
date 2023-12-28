import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../User/View/constants/Constants.dart';
import '../../../View/Screens/HomeScreens/Payment/successPage.dart';
import '../../../../User/View/constants/Constants.dart';
import '../../Functions/UserStatus.dart';
class PaymentResponse {
  int statusCode;
  String body;

  PaymentResponse(this.statusCode, this.body);
}

class AddSale {
  Future<PaymentResponse> PostSale(
    {
   required String userId,
   required String sid,
   required String mode_of_payment,
   required String discount,
   required String vat,
   required String amount, 
   required String payment_note,
  required  String remarks,
  required  String taxable,
  required  String nonTaxable,
  required  String delivery_location,
   required String lat,
   required String long,
  required  String PaymentStatus,
  required  String payment_transaction_id,
  required  String paymentNote,
  required  String total,
  required  String distance,
  required  String delivery_charge,
  required  String tCode
   }
) async {
    try {
      final Map<String, dynamic> data = {
        'user_id': userId,
        's_id': sid,
        'mode_of_payment':mode_of_payment,
        'discount':discount,
        "vat":vat,
        "amount":amount,
        "payment_note":payment_note,
        "remarks":remarks,
        "taxable":taxable,
        "non_taxable":nonTaxable,
        "delivery_location":delivery_location,
        "lat":lat,
        "long":long,
        "PaymentStatus":PaymentStatus,
        "payment_transaction_id":payment_transaction_id,
        "paymentNote":paymentNote,
        "total":total,
        "distance":distance,
      "delivery_charge":delivery_charge,
        "tCode":tCode
      };   
      print("The data is");
      print(data); 
      var apiUrl = "$baseUrl/api/addSales";
      print(apiUrl);
      String? token = await getToken();
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print("The response body is");
      print(response.body);
      print("The response status code is");
      print(response.statusCode);
      print("the Tcode is transferred");

  if(response.statusCode ==200){
  Fluttertoast.showToast(
  msg: 'Payment Completed',
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.black87,
  textColor: Colors.white,
  fontSize: 16.0,
);
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
     return PaymentResponse(response.statusCode, response.body);
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }
}
