import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../Home/HomeScreensNavigation.dart';

class Khalti {
  payWithKhalti(BuildContext context, int amount) {
    KhaltiScope.of(context)
        //amount is defined in 'paisa' so 1000 paisa means NRP.10
        .pay(
      config: PaymentConfig(
          // amount: int.parse('${100 * widget.amount}'),
          amount: int.parse('${100 * amount}'),
          productIdentity: 'productIdentity',
          productName: 'productName'),
      preferences: [PaymentPreference.khalti],
      onSuccess: (PaymentSuccessModel sucess) {
        debugPrint(":::SUCCESS::: => $sucess");
        onSuccess(sucess);
      },
      onFailure: (PaymentFailureModel failure) {
        debugPrint(":::FAILED::: => $failure");
      },
      onCancel: () {
        debugPrint(":::CANCELLED::: =>");
      },
    );
  }
}

void onSuccess(PaymentSuccessModel success) async {
  Map data = {
    'token': '${success.token}',
    // 'amount': "${100 * double.parse(widget.amount)}"
    'amount': '${success.amount}'
  };
  ;
  String body = json.encode(data);
  try {
    var response = await http.post(
      Uri.parse("https://khalti.com/api/v2/payment/verify/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Key test_secret_key_fba0fa1dc5df4411ae262beb77846252"
      },
      body: body,
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Payment Verified',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, // Toast position on the screen
        timeInSecForIosWeb: 1, // Time duration in seconds for iOS and web
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
      //   AddSale payment = new AddSale();
//   AddSaleResponse paymentResponse
//   =
//   payment.PostSale(
//     userId,
//    sid,
//     mode_of_payment,
//      discount,
//       vat,
//        amount,
//         payment_note,
//          remarks,
//           taxable,
//            nonTaxable,
//             delivery_location,
//              lat,
//               long,
//                PaymentStatus,
//                 payment_transaction_id,
//                  paymentNote,
//                   total,
//                    distance,
//                     delivery_charge);
//   if(paymentResponse.statusCode =201){

//         Fluttertoast.showToast(
//   msg: 'Transaction Completed',
//   toastLength: Toast.LENGTH_SHORT,
//   gravity: ToastGravity.BOTTOM,
//   timeInSecForIosWeb: 1,
//   backgroundColor: Colors.black87,
//   textColor: Colors.white,
//   fontSize: 16.0,
// );
//   }
//   else{

//         Fluttertoast.showToast(
//   msg: 'Transaction Failed',
//   toastLength: Toast.LENGTH_SHORT,
//   gravity: ToastGravity.BOTTOM,
//   timeInSecForIosWeb: 1,
//   backgroundColor: Colors.black87,
//   textColor: Colors.white,
//   fontSize: 16.0,
// );
//   }

      Get.offAll(BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(context),
        child: BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
          child: BlocProvider(
            create: (context) => HomeNavigationBloc(),
            child: BlocProvider(
              create: (context) => BasketBloc(),
              child: HomeScreensNavigation(
                currentIndexNumber: 0,
                loginStatus: "true",
                homeData: [],
                advertisementData: [],
              ),
            ),
          ),
        ),
      ));
    } else {
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
    debugPrint(e.toString());
  }
}

void onFailure(PaymentFailureModel failure) {
  debugPrint(failure.toString());
}

void onCancel() {
  debugPrint('Cancelled');
}
