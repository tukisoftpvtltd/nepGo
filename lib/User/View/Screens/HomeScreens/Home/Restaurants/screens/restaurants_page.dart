import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/components/restaurant_custome_sort.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Controller/Functions/capitalize.dart';
import '../../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../../Controller/repositories/search/search_repository.dart';
import '../../../../../constants/Constants.dart';
import '../../../../../constants/colors.dart';
import '../../HomeScreensNavigation.dart';
import '../components/restaurant_card.dart';
import 'view_restaurant.dart';

class RestaurantsPage extends StatefulWidget {
  final bool bestMatch;
  final bool TopSales;
  final bool isNew;
  final String openRestaurant;
  final String name;
  final String Distance;
  final String Sales;
  RestaurantsPage({
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
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  bool loading = false;
  List RestroList = [];
  List GroceryList = [];
  String key = '';
  int TabIndex = 0;
  String? latitude;
  String? longitude;
  searchRestaurant(String searchKey) async {
    setState(() {
      RestroList = [];
      loading = true;
      key = searchKey;
    });
    SharedPreferences _locationDetail = await SharedPreferences.getInstance();
    latitude = _locationDetail.getString('latitude');
    longitude = _locationDetail.getString('longitude');
    SearchPageRepository repo = SearchPageRepository();
    SearchResponse? response;
    if (widget.bestMatch == true) {
      response =
          await repo.getSearchData(searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("1");
    } else if (widget.isNew == true) {
      response = await repo.getSearchDataOrderByNewlyCreated(
          searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("2");
    } else if (widget.isNew == false &&
        widget.name == "null" &&
        widget.Distance == 'null' &&
        widget.Sales == "null") {
      response =
          await repo.getSearchData(searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("3");
    } else if (widget.name == "ASC" &&
        widget.Distance == "null" &&
        widget.Sales == "null") {
      response = await repo.getSearchDataOrderByNameASC(
          searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("4");
    } else if (widget.name == "DESC" &&
        widget.Distance == "null" &&
        widget.Sales == "null") {
      response = await repo.getSearchDataOrderByNameDESC(
          searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("5");
    } else if (widget.name == "null" &&
        widget.Distance == 'ASC' &&
        widget.Sales == "null") {
      response = await repo.getSearchDataOrderByDistance(
          searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("6");
    } else if (widget.name == "null" &&
        widget.Distance == 'null' &&
        widget.Sales == "ASC") {
      response =
          await repo.getSearchData(searchKey, "1", latitude!, longitude!,widget.openRestaurant);
      print("1");
    }
    var data = jsonDecode(response!.body);
    List restro = data['serviceProvider'];
    List itemList = data['itemsWithServieProviders'];
    int restroLength = restro.length;
    if (searchKey == '') {
      key = "null";
    } else {
      key = searchKey;
    }
    for (int k = 0; k < itemList.length; k++) {
      for (int i = 0; i < restroLength; i++) {
        if (restro[i]['fullname'].contains(key) &&
            itemList[k]['fullname'].contains(key)) {
          restro.removeAt(i);
        }
      }
    }
    RestroList.addAll(restro);
    RestroList.addAll(itemList);
    setState(() {
      //restaurantSearchKey.text = searchKey;
      loading = false;
    });
  }

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
    searchRestaurant('');
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
          'RESTAURANTS',
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
            RestaurantCustomSort(
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
                ? Container(
                    height: 700,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colours.primarygreen,
                    )))
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
                            location: capitalize(RestroList[index]['address']),
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
