import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/screens/view_restaurant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Controller/repositories/remove_from_favorite.dart';
import '../../../../../Controller/repositories/get_your_favorite.dart';
import '../../Baskets/Basket/widget/size_config.dart';

class FavoriteListTile extends StatelessWidget {
  final String sid;
  final String logoUrl;
  final String restaurantName;
  final String location;
  final int price;
  final String itemQty;
  final String openTime;
  final String closeTime;
  final String ratings;
  Function? callback;

  FavoriteListTile(
      {super.key,
      required this.sid,
      required this.logoUrl,
      required this.restaurantName,
      required this.location,
      required this.price,
      required this.itemQty,
      required this.openTime,
      required this.closeTime,
      required this.ratings,
      this.callback});

  RemoveFromFavorite(String sid) async {
    RemoveFromFavoriteRepository removeFromFav =
        new RemoveFromFavoriteRepository();
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData.getString('user_id');
    RemoveFromFavoriteResponse res =
        await removeFromFav.RemoveFromFavorite(userId!, sid);
    print(res.statusCode);
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: () {
          Get.to(BlocProvider(
            create: (context) => ServiceProviderDetailBloc(),
            child: ViewRestautant(sid: sid,callback: callback,),
          ));
        },
        child: Container(
          width: screenWidth * 1,
          height: 120,
          color: Color(0xffF3F3F3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4), // Shadow color
                        offset: Offset(0, 3), // Offset from the container
                        blurRadius: 2, // Spread radius of the shadow
                        spreadRadius: 1, // Radius of the shadow blur
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            logoUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 5.5 * screenWidth / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              capitalize(restaurantName),
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: SizeConfig(context).textSize(),
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenWidth * 0.6,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey.shade600,
                                    size: SizeConfig(context).iconSize() - 6,
                                  ),
                                  Container(
                                    width: screenWidth * 0.4,
                                    child: Text(
                                      location,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize:
                                              SizeConfig(context).textSize() -
                                                  4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Delivery Hours: ${openTime.replaceAll('00:00','00')} PM - ${closeTime.replaceAll('00:00','00')} PM",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: SizeConfig(context).textSize() - 4),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   "Rs $price ($itemQty item)",
                            //   style: TextStyle(
                            //     color: Colors.green,
                            //     fontSize: SizeConfig(context).textSize() - 4,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.8 * screenWidth / 10,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: SizeConfig(context).iconSize() - 2,
                              ),
                              Text(
                                "$ratings/5",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize:
                                        SizeConfig(context).textSize() - 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
