import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/restaurant_loader.dart';
import 'package:food_app/User/View/Screens/NoInternet.dart';
import 'package:get/get.dart';
import '../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../Controller/bloc/internet/bloc/internet_bloc_bloc.dart';
import '../../../constants/colors.dart';
import '../../Loaders/ProductLoader.dart';
import '../../Loaders/ServiceProvideLoader.dart';
import 'FirstScreenWidget/Advertisement.dart';
import 'FirstScreenWidget/RestroGroceryLink.dart';
import 'FirstScreenWidget/TwoTextInARow.dart';
import 'FirstScreenWidget/middleAdvertisement.dart';
import 'HomeScreenWidget.dart/FoodItemCard.dart';
import 'HomeScreenWidget.dart/RestaurantCard.dart';
import 'NodataPage.dart';
import 'Restaurants/screens/view_restaurant.dart';

// ignore: must_be_immutable
class FirstScreen extends StatefulWidget {
  double latitude;
  double longitude;
  var data;
  var advertisement;
  bool? reload;
  Function callback;
  Function callback2;

  FirstScreen(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.data,
      required this.advertisement,
      this.reload,
      required this.callback,
      required this.callback2});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool firstTimeLoading = true;
  var stateData;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    print("init called");
    print(stateData);

    restroFoodData = stateData;
    restroData = stateData;
    if (firstTimeLoading == true) {
      print("No data is imported");
      BlocProvider.of<HomePageBloc>(context).add(onHomePageLoading());
    } else {
      print("Data is imported");
    }
  }

  bool noData = false;

  String capitalize(String input) {
    if (input.isEmpty) return '';

    List<String> words = input.split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalizedWord = word[0].toUpperCase() + word.substring(1);
        capitalizedWords.add(capitalizedWord);
      }
    }

    return capitalizedWords.join(' ');
  }

  List dataList = [];
  var restroFoodData;
  var restroData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBlocBloc, InternetBlocState>(
      builder: (context, state) {
        return BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is InternetLostState) {
              return NoInternetPage();
            } else if (state is NoDataState) {
              return const NoDataPage();
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  firstTimeLoading = true;
                  BlocProvider.of<HomePageBloc>(context)
                      .add(onHomePageLoading());
                  print("bye");
                  await Future.delayed(Duration(seconds: 2));
                },
                color: Colours.primarygreen,
                child: Container(
                  height: Get.height - 140,
                  // // width: double.maxFinite,
                  color: Colors.white,
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            RestroGroceryLink(
                                callback: widget.callback,
                                callback2: widget.callback2),
                            const SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //  color: Color(0xFFF3F3F3),
                            //   height: 5,
                            // ),
                //             GestureDetector(
                //               onTap: (){
                //                 Navigator.of(context).push(
                // MaterialPageRoute(
                // builder:
                // (context) =>
                //      BlocProvider(
                //         create: (context) =>
                //         ServiceProviderDetailBloc(),
                //         child:
                //         BlocProvider(
                //           create: (context) =>
                //           LocationBloc(),
                //           child:
                //           ViewRestautant(
                //           callback:(){},
                //           sid: 'Z8vXoiMIc36xqYkwjaZb202306188792',
                //           ),
                //           ),
                //           )));
                //               },
                //               child: Container(
                //                   height: 200,
                //                   child: Image.asset(
                //                     "assets/images/advertisment-min.png",
                //                     fit: BoxFit.cover,
                //                   )),
                //             ),
                             Advertisement(
                              advertdata: widget.advertisement,
                              index:1
                             ),
                            // Container(
                            //  color: Color(0xFFF3F3F3),
                            //   height: 5,
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            TwoTextInARow(name: "Restaurant Item - Top Pick !"),
                            BlocBuilder<HomePageBloc, HomePageState>(
                              builder: (context, state) {
                                restroFoodData = widget.data;
                                //dataList =widget.data as List;
                                if (widget.data.toString() == '[]') {
                                  print('1');
                                  if (firstTimeLoading == true) {
                                    print('2');
                                    if (state is HomePageLoading) {
                                      print('3');
                                      return ProductLoader();
                                    } else if (state is HomePageLoaded) {
                                      print('4');
                                      // stateData = state.data;
                                      // firstTimeLoading =false;
                                      return Container(
                                        height: 215,
                                        color: Colors.white,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.data
                                              .restaurantItemsTopPick!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  BlocProvider(
                                                                    create: (context) =>
                                                                        ServiceProviderDetailBloc(),
                                                                    child:
                                                                        BlocProvider(
                                                                      create: (context) =>
                                                                          BasketBloc(),
                                                                      child:
                                                                          BlocProvider(
                                                                        create: (context) =>
                                                                            LocationBloc(),
                                                                        child:
                                                                            ViewRestautant(
                                                                          callback:
                                                                              widget.callback,
                                                                          sid: state
                                                                              .data
                                                                              .restaurantItemsTopPick![index]
                                                                              .sId
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )));
                                                },
                                                child: FoodItemCard(
                                                  imageUrl: state
                                                      .data
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .coverImage
                                                      .toString(),
                                                  foodName: capitalize(state
                                                      .data
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .itemName
                                                      .toString()),
                                                  sellingRate: state
                                                      .data
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .sellrate
                                                      .toString(),
                                                  normalRate: state
                                                      .data
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .normalRate
                                                      .toString(),
                                                  restaurantName: capitalize(state
                                                      .data
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .fullname
                                                      .toString()),
                                                  distance: state
                                                      .data
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .distance
                                                      .toString(),
                                                ));
                                          },
                                        ),
                                      );
                                    } else {
                                      print('5');
                                      return ProductLoader();
                                    }
                                  } else {
                                    print('6');
                                    return Container(
                                      height: 215,
                                      color: Colors.white,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: stateData
                                            .restaurantItemsTopPick!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  ServiceProviderDetailBloc(),
                                                              child:
                                                                  BlocProvider(
                                                                create: (context) =>
                                                                    LocationBloc(),
                                                                child:
                                                                    ViewRestautant(
                                                                  callback: widget
                                                                      .callback,
                                                                  sid: stateData
                                                                      .restaurantItemsTopPick![
                                                                          index]
                                                                      .sId
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            )));
                                              },
                                              child: FoodItemCard(
                                                imageUrl: stateData
                                                    .restaurantItemsTopPick![
                                                        index]
                                                    .coverImage
                                                    .toString(),
                                                foodName: capitalize(stateData
                                                    .restaurantItemsTopPick![
                                                        index]
                                                    .itemName
                                                    .toString()),
                                                sellingRate: stateData
                                                    .restaurantItemsTopPick![
                                                        index]
                                                    .sellrate
                                                    .toString(),
                                                normalRate: stateData
                                                    .restaurantItemsTopPick![
                                                        index]
                                                    .normalRate
                                                    .toString(),
                                                restaurantName: capitalize(
                                                    stateData
                                                        .restaurantItemsTopPick![
                                                            index]
                                                        .fullname
                                                        .toString()),
                                                distance: stateData
                                                    .restaurantItemsTopPick![
                                                        index]
                                                    .distance
                                                    .toString(),
                                              ));
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  print('7');
                                  return Container(
                                    height: 215,
                                    color: Colors.white,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: restroFoodData
                                          .restaurantItemsTopPick!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                ServiceProviderDetailBloc(),
                                                            child: BlocProvider(
                                                              create: (context) =>
                                                                  LocationBloc(),
                                                              child:
                                                                  ViewRestautant(
                                                                callback: widget
                                                                    .callback,
                                                                sid: restroFoodData
                                                                    .restaurantItemsTopPick![
                                                                        index]
                                                                    .sId
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          )));
                                            },
                                            child: FoodItemCard(
                                              imageUrl: restroFoodData
                                                  .restaurantItemsTopPick![
                                                      index]
                                                  .coverImage
                                                  .toString(),
                                              foodName: capitalize(
                                                  restroFoodData
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .itemName
                                                      .toString()),
                                              sellingRate: restroFoodData
                                                  .restaurantItemsTopPick![
                                                      index]
                                                  .sellrate
                                                  .toString(),
                                              normalRate: restroFoodData
                                                  .restaurantItemsTopPick![
                                                      index]
                                                  .normalRate
                                                  .toString(),
                                              restaurantName: capitalize(
                                                  restroFoodData
                                                      .restaurantItemsTopPick![
                                                          index]
                                                      .fullname
                                                      .toString()),
                                              distance: restroFoodData
                                                  .restaurantItemsTopPick![
                                                      index]
                                                  .distance
                                                  .toString(),
                                            ));
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            //  Container(
                            //   color: Color(0xFFF3F3F3),
                            //   height: 5,
                            // ),
                            // Container(
                            //   color: Colors.white,
                            //   height: 5,
                            // ),
                            TwoTextInARow(name: "Featured Restaurants"),
                            Container(
                              color: Colors.white,
                              height: 5,
                            ),
                            BlocBuilder<HomePageBloc, HomePageState>(
                              builder: (context, state) {
                                if (widget.data.toString() == '[]') {
                                  if (firstTimeLoading == true) {
                                    if (state is HomePageLoading) {
                                      return ServiceProviderLoader();
                                    } else if (state is HomePageLoaded) {
                                      print("1");
                                      restroData = state.data;
                                      // firstTimeLoading =false;
                                      return SizedBox(
                                        height: 210,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state
                                              .data.featuredRestaurant!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  BlocProvider(
                                                                    create: (context) =>
                                                                        ServiceProviderDetailBloc(),
                                                                    child:
                                                                        BlocProvider(
                                                                      create: (context) =>
                                                                          LocationBloc(),
                                                                      child:
                                                                          ViewRestautant(
                                                                        callback:
                                                                            widget.callback,
                                                                        sid: restroData
                                                                            .featuredRestaurant![index]
                                                                            .sId
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                  )));
                                                },
                                                child: HomeRestaurantCard(
                                                  banner: restroData
                                                      .featuredRestaurant![
                                                          index]
                                                      .banner
                                                      .toString(),
                                                  logo: restroData
                                                      .featuredRestaurant![
                                                          index]
                                                      .logo
                                                      .toString(),
                                                  name: capitalize(restroData
                                                      .featuredRestaurant![
                                                          index]
                                                      .fullname
                                                      .toString()),
                                                  address: restroData
                                                      .featuredRestaurant![
                                                          index]
                                                      .address
                                                      .toString(),
                                                  distance: restroData
                                                      .featuredRestaurant![
                                                          index]
                                                      .distance
                                                      .toString(),
                                                  averageRating: restroData
                                                      .featuredRestaurant[index]
                                                      .averageRating
                                                      .toString(),
                                                  openingTime: restroData
                                                      .featuredRestaurant[index]
                                                      .openingTime
                                                      .toString(),
                                                  closingTime: restroData
                                                      .featuredRestaurant[index]
                                                      .closingTime
                                                      .toString(),
                                                ));
                                          },
                                        ),
                                      );
                                    } else {
                                      print("2");
                                      return ServiceProviderLoader();
                                    }
                                  } else {
                                    print("3");
                                    return Container(
                                      color: Colors.transparent,
                                      height: 210,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: restroData
                                            .featuredRestaurant!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  ServiceProviderDetailBloc(),
                                                              child:
                                                                  BlocProvider(
                                                                create: (context) =>
                                                                    LocationBloc(),
                                                                child:
                                                                    ViewRestautant(
                                                                  callback: widget
                                                                      .callback,
                                                                  sid: restroData
                                                                      .featuredRestaurant![
                                                                          index]
                                                                      .sId
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            )));
                                              },
                                              child: HomeRestaurantCard(
                                                banner: restroData
                                                    .featuredRestaurant![index]
                                                    .banner
                                                    .toString(),
                                                logo: restroData
                                                    .featuredRestaurant![index]
                                                    .logo
                                                    .toString(),
                                                name: capitalize(restroData
                                                    .featuredRestaurant![index]
                                                    .fullname
                                                    .toString()),
                                                address: restroData
                                                    .featuredRestaurant![index]
                                                    .address
                                                    .toString(),
                                                distance: restroData
                                                    .featuredRestaurant![index]
                                                    .distance
                                                    .toString(),
                                                averageRating: restroData
                                                    .featuredRestaurant[index]
                                                    .averageRating
                                                    .toString(),
                                                openingTime: restroData
                                                    .featuredRestaurant[index]
                                                    .openingTime
                                                    .toString(),
                                                closingTime: restroData
                                                    .featuredRestaurant[index]
                                                    .closingTime
                                                    .toString(),
                                              ));
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  print("4");
                                  return Container(
                                    height: 210,
                                    color: Colors.white,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          restroData.featuredRestaurant!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                ServiceProviderDetailBloc(),
                                                            child: BlocProvider(
                                                              create: (context) =>
                                                                  LocationBloc(),
                                                              child:
                                                                  ViewRestautant(
                                                                callback: widget
                                                                    .callback,
                                                                sid: restroData
                                                                    .featuredRestaurant![
                                                                        index]
                                                                    .sId
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          )));
                                            },
                                            child: HomeRestaurantCard(
                                              banner: restroData
                                                  .featuredRestaurant![index]
                                                  .banner
                                                  .toString(),
                                              logo: restroData
                                                  .featuredRestaurant![index]
                                                  .logo
                                                  .toString(),
                                              name: capitalize(restroData
                                                  .featuredRestaurant![index]
                                                  .fullname
                                                  .toString()),
                                              address: restroData
                                                  .featuredRestaurant![index]
                                                  .address
                                                  .toString(),
                                              distance: restroData
                                                  .featuredRestaurant![index]
                                                  .distance
                                                  .toString(),
                                              averageRating: restroData
                                                  .featuredRestaurant[index]
                                                  .averageRating
                                                  .toString(),
                                              openingTime: restroData
                                                  .featuredRestaurant[index]
                                                  .openingTime
                                                  .toString(),
                                              closingTime: restroData
                                                  .featuredRestaurant[index]
                                                  .closingTime
                                                  .toString(),
                                            ));
                                      },
                                    ),
                                  );
                                }
                              },
                            ),

                            Container(
                              color: Colors.white,
                              height: 5,
                            ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // Container(
                            //   color: Color(0xFFF3F3F3),
                            //   height: 5,
                            // ),
                            // Container(
                            //   // color: Colors.yellow.shade600,
                            //   height: 180,
                            //   child: Image.asset(
                            //     'assets/images/advertisement2-min.png',
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            MiddleAdvertisement(advertdata: widget.advertisement,
                            index: 2,),
                            Container(
                              color: Color(0xFFF3F3F3),
                              height: 5,
                            ),
                            Advertisement(advertdata: widget.advertisement,
                            index: 3,),
                            Container(
                              color: Color(0xFFF3F3F3),
                              height: 5,
                            ),
                            TwoTextInARow(name: "Groceries - Top Pick !"),
                            BlocBuilder<HomePageBloc, HomePageState>(
                              builder: (context, state) {
                                if (widget.data.toString() == '[]') {
                                  if (firstTimeLoading == true) {
                                    if (state is HomePageLoading) {
                                      return ProductLoader();
                                    } else if (state is HomePageLoaded) {
                                      return Container(
                                        height: 220,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state
                                              .data.groceriesTopPick!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  BlocProvider(
                                                                    create: (context) =>
                                                                        ServiceProviderDetailBloc(),
                                                                    child:
                                                                        BlocProvider(
                                                                      create: (context) =>
                                                                          LocationBloc(),
                                                                      child:
                                                                          ViewRestautant(
                                                                        callback:
                                                                            widget.callback,
                                                                        sid: state
                                                                            .data
                                                                            .groceriesTopPick![index]
                                                                            .sId
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                  )));
                                                },
                                                child: FoodItemCard(
                                                  imageUrl: state
                                                      .data
                                                      .groceriesTopPick![index]
                                                      .coverImage
                                                      .toString(),
                                                  foodName: capitalize(state
                                                      .data
                                                      .groceriesTopPick![index]
                                                      .itemName
                                                      .toString()),
                                                  sellingRate: state
                                                      .data
                                                      .groceriesTopPick![index]
                                                      .sellrate
                                                      .toString(),
                                                  normalRate: state
                                                      .data
                                                      .groceriesTopPick![index]
                                                      .normalRate
                                                      .toString(),
                                                  restaurantName: capitalize(
                                                      state
                                                          .data
                                                          .groceriesTopPick![
                                                              index]
                                                          .fullname
                                                          .toString()),
                                                  distance: state
                                                      .data
                                                      .groceriesTopPick![index]
                                                      .distance
                                                      .toString(),
                                                ));
                                          },
                                        ),
                                      );
                                    } else {
                                      return ProductLoader();
                                    }
                                  } else {
                                    return Container(
                                      height: 215,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            stateData.groceriesTopPick!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  ServiceProviderDetailBloc(),
                                                              child:
                                                                  BlocProvider(
                                                                create: (context) =>
                                                                    LocationBloc(),
                                                                child:
                                                                    ViewRestautant(
                                                                  callback: widget
                                                                      .callback,
                                                                  sid: stateData
                                                                      .groceriesTopPick![
                                                                          index]
                                                                      .sId
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            )));
                                              },
                                              child: FoodItemCard(
                                                imageUrl: stateData
                                                    .groceriesTopPick![index]
                                                    .coverImage
                                                    .toString(),
                                                foodName: capitalize(stateData
                                                    .groceriesTopPick![index]
                                                    .itemName
                                                    .toString()),
                                                sellingRate: stateData
                                                    .groceriesTopPick![index]
                                                    .sellrate
                                                    .toString(),
                                                normalRate: stateData
                                                    .groceriesTopPick![index]
                                                    .normalRate
                                                    .toString(),
                                                restaurantName: capitalize(
                                                    stateData
                                                        .groceriesTopPick![
                                                            index]
                                                        .fullname
                                                        .toString()),
                                                distance: stateData
                                                    .groceriesTopPick![index]
                                                    .distance
                                                    .toString(),
                                              ));
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  return Container(
                                    height: 215,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.data.groceriesTopPick!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                ServiceProviderDetailBloc(),
                                                            child: BlocProvider(
                                                              create: (context) =>
                                                                  LocationBloc(),
                                                              child:
                                                                  ViewRestautant(
                                                                callback: widget
                                                                    .callback,
                                                                sid: widget
                                                                    .data
                                                                    .groceriesTopPick![
                                                                        index]
                                                                    .sId
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          )));
                                            },
                                            child: FoodItemCard(
                                              imageUrl: widget
                                                  .data
                                                  .groceriesTopPick![index]
                                                  .coverImage
                                                  .toString(),
                                              foodName: capitalize(widget
                                                  .data
                                                  .groceriesTopPick![index]
                                                  .itemName
                                                  .toString()),
                                              sellingRate: widget
                                                  .data
                                                  .groceriesTopPick![index]
                                                  .sellrate
                                                  .toString(),
                                              normalRate: widget
                                                  .data
                                                  .groceriesTopPick![index]
                                                  .normalRate
                                                  .toString(),
                                              restaurantName: capitalize(widget
                                                  .data
                                                  .groceriesTopPick![index]
                                                  .fullname
                                                  .toString()),
                                              distance: widget
                                                  .data
                                                  .groceriesTopPick![index]
                                                  .distance
                                                  .toString(),
                                            ));
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            // Container(
                            //   color: Colors.white,
                            //   height: 5,
                            // ),
                            // Advertisement(
                            // advertdata: widget.advertisement,
                            // index: 2,),
                            SizedBox(
                              height: 5,
                            ),
                            TwoTextInARow(name: "Featured Groceries"),
                            Container(
                              color: Colors.white,
                              height: 5,
                            ),
                            BlocBuilder<HomePageBloc, HomePageState>(
                              builder: (context, state) {
                                if (widget.data.toString() == '[]') {
                                  if (firstTimeLoading == true) {
                                    if (state is HomePageLoading) {
                                      return ServiceProviderLoader();
                                    } else if (state is HomePageLoaded) {
                                      firstTimeLoading = false;
                                      //firstTimeLoading=true;
                                      stateData = state.data;
                                      print("The state data is saved 1");
                                      return Container(
                                        height: 210,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state
                                              .data.featuredGroceries!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  BlocProvider(
                                                                    create: (context) =>
                                                                        ServiceProviderDetailBloc(),
                                                                    child:
                                                                        BlocProvider(
                                                                      create: (context) =>
                                                                          LocationBloc(),
                                                                      child:
                                                                          ViewRestautant(
                                                                        callback:
                                                                            widget.callback,
                                                                        sid: state
                                                                            .data
                                                                            .featuredGroceries![index]
                                                                            .sId
                                                                            .toString(),
                                                                      ),
                                                                    ),
                                                                  )));
                                                },
                                                child: HomeRestaurantCard(
                                                  banner: state
                                                      .data
                                                      .featuredGroceries![index]
                                                      .banner
                                                      .toString(),
                                                  logo: state
                                                      .data
                                                      .featuredGroceries![index]
                                                      .logo
                                                      .toString(),
                                                  name: capitalize(state
                                                      .data
                                                      .featuredGroceries![index]
                                                      .fullname
                                                      .toString()),
                                                  address: capitalize(state
                                                      .data
                                                      .featuredGroceries![index]
                                                      .address
                                                      .toString()),
                                                  distance: state
                                                      .data
                                                      .featuredGroceries![index]
                                                      .distance
                                                      .toString(),
                                                  averageRating: state
                                                      .data
                                                      .featuredRestaurant![
                                                          index]
                                                      .averageRating
                                                      .toString(),
                                                  openingTime: state
                                                      .data
                                                      .featuredRestaurant![
                                                          index]
                                                      .openingTime
                                                      .toString(),
                                                  closingTime: state
                                                      .data
                                                      .featuredRestaurant![
                                                          index]
                                                      .closingTime
                                                      .toString(),
                                                ));
                                          },
                                        ),
                                      );
                                    } else {
                                      return RestaurantLoader();
                                    }
                                  } else {
                                    firstTimeLoading = false;
                                    //firstTimeLoading=true;
                                    // stateData = state.data;
                                    print("The state data is saved 0");
                                    return Container(
                                      height: 210,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            stateData.featuredGroceries!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  ServiceProviderDetailBloc(),
                                                              child:
                                                                  BlocProvider(
                                                                create: (context) =>
                                                                    LocationBloc(),
                                                                child:
                                                                    ViewRestautant(
                                                                  callback: widget
                                                                      .callback,
                                                                  sid: stateData
                                                                      .featuredGroceries![
                                                                          index]
                                                                      .sId
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            )));
                                              },
                                              child: HomeRestaurantCard(
                                                banner: stateData
                                                    .featuredGroceries![index]
                                                    .banner
                                                    .toString(),
                                                logo: stateData
                                                    .featuredGroceries![index]
                                                    .logo
                                                    .toString(),
                                                name: capitalize(stateData
                                                    .featuredGroceries![index]
                                                    .fullname
                                                    .toString()),
                                                address: capitalize(stateData
                                                    .featuredGroceries![index]
                                                    .address
                                                    .toString()),
                                                distance: stateData
                                                    .featuredGroceries![index]
                                                    .distance
                                                    .toString(),
                                                averageRating: stateData
                                                    .featuredRestaurant![index]
                                                    .averageRating
                                                    .toString(),
                                                openingTime: stateData
                                                    .featuredRestaurant![index]
                                                    .openingTime
                                                    .toString(),
                                                closingTime: stateData
                                                    .featuredRestaurant![index]
                                                    .closingTime
                                                    .toString(),
                                              ));
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  firstTimeLoading = false;
                                  //firstTimeLoading=true;
                                  // stateData = state.data;
                                  print("The state data is saved");
                                  return Container(
                                    height: 210,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.data.featuredGroceries!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                            create: (context) =>
                                                                ServiceProviderDetailBloc(),
                                                            child: BlocProvider(
                                                              create: (context) =>
                                                                  LocationBloc(),
                                                              child:
                                                                  ViewRestautant(
                                                                callback: widget
                                                                    .callback,
                                                                sid: widget
                                                                    .data
                                                                    .featuredGroceries![
                                                                        index]
                                                                    .sId
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          )));
                                            },
                                            child: HomeRestaurantCard(
                                              banner: widget
                                                  .data
                                                  .featuredGroceries![index]
                                                  .banner
                                                  .toString(),
                                              logo: widget
                                                  .data
                                                  .featuredGroceries![index]
                                                  .logo
                                                  .toString(),
                                              name: capitalize(widget
                                                  .data
                                                  .featuredGroceries![index]
                                                  .fullname
                                                  .toString()),
                                              address: capitalize(widget
                                                  .data
                                                  .featuredGroceries![index]
                                                  .address
                                                  .toString()),
                                              distance: widget
                                                  .data
                                                  .featuredGroceries![index]
                                                  .distance
                                                  .toString(),
                                              averageRating: widget
                                                  .data
                                                  .featuredRestaurant![index]
                                                  .averageRating
                                                  .toString(),
                                              openingTime: widget
                                                  .data
                                                  .featuredRestaurant![index]
                                                  .openingTime
                                                  .toString(),
                                              closingTime: widget
                                                  .data
                                                  .featuredRestaurant![index]
                                                  .closingTime
                                                  .toString(),
                                            ));
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      }),
                ),
              );
            }
          },
        );
      },
    );
  }
}
