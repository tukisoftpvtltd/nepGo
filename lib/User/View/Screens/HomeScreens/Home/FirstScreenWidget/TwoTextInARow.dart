import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/FirstScreenWidget/ViewAll.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/screens/all_restaurant_page.dart';
import 'package:get/get.dart';

import '../../../../../Controller/bloc/Search/bloc/search_bloc.dart';

class TwoTextInARow extends StatelessWidget {
  String name;
  TwoTextInARow({
    super.key,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,5,10,5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () {
                name.contains('Restaurant')
                    ? Get.to(BlocProvider(
                        create: (context) => SearchBloc(),
                        child: AllRestaurantPage(tabValue: 0,callback: (){},),
                      ))
                    : Get.to(BlocProvider(
                        create: (context) => SearchBloc(),
                        child: AllRestaurantPage(tabValue: 1,callback: (){},),
                      ))
                    ;
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xff323030)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
