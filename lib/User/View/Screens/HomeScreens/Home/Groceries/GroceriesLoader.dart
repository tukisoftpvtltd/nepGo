import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../Controller/repositories/search/search_repository.dart';
import '../../../../constants/Constants.dart';
import '../Restaurants/components/restaurant_card.dart';
import '../Restaurants/screens/view_restaurant.dart';
import '../HomeScreensNavigation.dart';
import 'GroceriesCustomSort.dart';

class GroceriesLoader extends StatefulWidget {
  final bool bestMatch;
  final bool TopSales;
  final bool isNew;
  final String openRestaurant;
  final String name;
  final String Distance;
  final String Sales;
  GroceriesLoader({
    super.key,
    required this.bestMatch,
    required this.TopSales,
    required this.isNew,
    required this.openRestaurant,
    required this.name,
    required this.Distance,
    required this.Sales,
  });

  @override
  State<GroceriesLoader> createState() => _GroceriesLoaderState();
}

class _GroceriesLoaderState extends State<GroceriesLoader> {
  bool loading = false;
  List RestroList = [];
  List GroceryList = [];
  String key = '';
  int TabIndex = 0;
  String CustomSortValue = "Best Match";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.bestMatch == true) {
        CustomSortValue = "Best Match";
      }
      if (widget.TopSales == true) {
        CustomSortValue = "Top Sales";
      }
      if (widget.isNew == true) {
        CustomSortValue = "New";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
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
                    )));
              },
            ),
          ),
        ),
        title: const Text(
          'STORES',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            GroceriesCustomSort(
                CustomSortValue: CustomSortValue,
                index: TabIndex,
                restaurantSearchKey: '',
                grocerySearchKey: '',
                openRestaurant: widget.openRestaurant,
                name: widget.name,
                Distance: widget.Distance,
                Sales: widget.Sales),
            const SizedBox(
              height: 10,
            ),
            loading == true
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 700,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          double convertMilesToKm(double miles) {
                            const kmConversionFactor = 1.60934;
                            return miles * kmConversionFactor;
                          }

                          double kilometer =
                              convertMilesToKm(RestroList[index]['distance']);
                          return Container(
                            height: 100,
                            color: Colors.yellow,
                          );
                        },
                      ),
                    ),
                  )
                : Container(
                    height: 700,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: RestroList.length,
                      itemBuilder: (context, index) {
                        double convertMilesToKm(double miles) {
                          const kmConversionFactor = 1.60934;
                          return miles * kmConversionFactor;
                        }

                        double kilometer =
                            convertMilesToKm(RestroList[index]['distance']);
                        return RestaurantCard(
                            logoUrl:
                                "$baseUrl/serviceproviderprofile/${RestroList[index]['logo']}",
                            handleClicked: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            ServiceProviderDetailBloc(),
                                        child: ViewRestautant(
                                          sid: RestroList[index]['s_id'],
                                        ),
                                      )));
                            },
                            imageUrl:
                                "$baseUrl/serviceproviderprofile/${RestroList[index]['logo']}",
                            distance: kilometer.toString(),
                            location: RestroList[index]['address'],
                            name: RestroList[index]['fullname'],
                            rating: RestroList[index]['average_rating'],
                            time: '12:00 PM to 9:00 PM');
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
