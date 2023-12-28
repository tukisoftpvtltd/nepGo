import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/bloc/Baskets/Basket_detail.dart/bloc/basket_detail_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Baskets/Basket/view_basket.dart';
import 'package:get/get.dart';
import '../../../../Driver/View/components/colors.dart';

// ignore: non_constant_identifier_names
void ShowCustomSnackBar(BuildContext context, String text, String sid) {
  int time = 3;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colours.primarygreen,
      //          shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      duration: Duration(seconds: time),
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              time = 0;
              Get.to(
                  // SplashScreen()
                  BlocProvider(
                create: (context) => BasketDetailBloc(),
                child: ViewBasket(sid: sid),
              ));
            },
            child: const Row(
              children: [
                Text(
                  "View Cart   ",
                  style: TextStyle(fontSize: 14),
                ),
                Icon(
                  Icons.arrow_circle_right,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ), // Container
      behavior: SnackBarBehavior.fixed,
    ), // SnackBar
  );
}
