// ignore_for_file: await_only_futures
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Baskets/payment_page.dart';
import 'package:food_app/User/View/custome_loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Controller/bloc/Baskets/Basket_detail.dart/bloc/basket_detail_bloc.dart';
import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../Controller/repositories/Basket/delete_from_basket_repository.dart';
import '../../../../constants/Constants.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/BackButton2.dart';
import 'widget/basketMenuExpansion.dart';
import 'items_container.dart';
import 'widget/size_config.dart';
import 'basket_list.dart';

// ignore: must_be_immutable
class ViewBasket extends StatefulWidget {
  String sid;

  ViewBasket({
    super.key,
    required this.sid,
  });

  @override
  State<ViewBasket> createState() => _ViewBasketState();
}

class _ViewBasketState extends State<ViewBasket> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BasketDetailBloc>(context)
        .add(onBasketDetailLoading(widget.sid));
    getUserDatas();
    getMyLocation();
  }

  String phoneno = '';
  getUserDatas() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    //final userId = userData .getString('user_id');
    setState(() {
      phoneno = userData.getString('phoneno') == null
          ? ''
          : userData.getString('phoneno')!;
    });
  }

  bool loading = true;

  DeleteItemFromBasket(String sid, int itemId) async {
    setState(() {
      loading = true;
    });
    DeleteFromBasketRepository repo = new DeleteFromBasketRepository();
    DeleteFromBasketResponse responseData =
        await repo.DeleteFromBasket("1", sid, itemId);
    print(responseData.body);
    await Future.delayed(Duration(milliseconds: 100));
    BlocProvider.of<BasketDetailBloc>(context)
        .add(onBasketDetailLoading(widget.sid));
  }

  int total_sum = 0;
  int total_value = 0;
  List CurrenBasketItem = [];

  expansionCallBack() async {
    await Future.delayed(Duration(milliseconds: 100));
    BlocProvider.of<BasketDetailBloc>(context)
        .add(onBasketDetailLoading(widget.sid));
  }
  double distance=0.0;
  double deliveryCost = 0.0;
  void calculateDistance(
    double initialLatitude,
    double initialLongitude,
    double targetLatitude,
    double targetLongitude
  ) async {
    double distanceInMeters = await Geolocator.distanceBetween(
      initialLatitude,
      initialLongitude,
      targetLatitude,
      targetLongitude,
    );

    // Convert distance from meters to kilometers
    double distanceInKilometers = distanceInMeters / 1000;
    setState(() {
      distance = distanceInKilometers;
      deliveryCost = 100 + (distance-1)*35;
    });
    print("The delivery cost is"+deliveryCost.toString());
  }
  double myLatitude=0.0;
  double myLongitude =0.0;
  getMyLocation()async{
    SharedPreferences  locationDetail = await SharedPreferences.getInstance();
    myLatitude = double.parse(locationDetail.getString('latitude').toString());
    myLongitude = double.parse(locationDetail.getString('longitude').toString());
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // void _showDialog(BuildContext context) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Center(child: Text('Pay Via')),
    //         content: Container(
    //           width: 300, // Set the desired width
    //           height: 200,
    //           child: Column(
    //             children: [
    //               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //                 GestureDetector(
    //                   onTap: () {
    //                     print("Pay with esewa");
    //                     Esewa esewa = Esewa();
    //                     esewa.pay(
    //                       sid: widget.sid,
    //                       discount: 40,
    //                       vat: 40,
    //                       amount: total_sum,
    //                     );
    //                   },
    //                   child: Container(
    //                       width: 120,
    //                       height: 150,
    //                       child: Image.asset('assets/images/esewa-logo.png')),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     print("Pay with khalti");
    //                     Khalti khalti = new Khalti();
    //                     khalti.payWithKhalti(context, total_sum);
    //                   },
    //                   child: Container(
    //                       width: 120,
    //                       height: 150,
    //                       child: Image.asset('assets/images/khalti-logo.png')),
    //                 ),
    //               ]),
    //               ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   primary: Colours
    //                       .primarygreen, // Set the button's background color
    //                   onPrimary: Colors.white, // Set the button's text color
    //                   minimumSize:
    //                       Size(200, 36), // Set the button's width and height
    //                 ),
    //                 child: Text('Go Back'),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    void addItemsDialog(BuildContext context) {
      // BlocProvider.of<ServiceProviderDetailBloc>(context)
      //   .add(OnServiceProviderDetailLoading(widget.sid));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(3),
              insetPadding: EdgeInsets.all(20),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu'),
                  IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                  ),
                ],
              ),
              // content: Container(
              //   height: 500,
              //   width: 500,
              //   child: ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: 1,
              //       itemBuilder: (context, index) {
              //         return BlocProvider(
              //           create: (context) => ServiceProviderDetailBloc(),
              //           child: MenuExpansion(
              //             dishName: '',
              //             menuItems: [],
              //           ),
              //         );
              //       }),
              // ),
              content: Container(
                width: 500,
                height: 500,
                child: BlocProvider(
                  create: (context) => ServiceProviderDetailBloc(),
                  child: BasketMenuExpansion(
                    dishName: '',
                    menuItems: [],
                    sid: widget.sid,
                    expansionCallBack: expansionCallBack,
                  ),
                ),
              ));
        },
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    String sidName = '';
    String logoUrl = '';
    String restaurantName = '';
    String location = '';
    bool firstLoading = true;
    String openTime = '';
    String closeTime = '';
    double ratings = 0.0;
    double latitude =0.0;
    double longitude =0.0;
    // final List<Widget> _pages = [
    //   Center(child: Text('Page 1')),
    //   Center(child: Text('Page 2')),
    //   Center(child: Text('Page 3')),
    // ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton2(),
        title: const Text(
          'My Basket',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        BlocBuilder<BasketDetailBloc, BasketDetailState>(
                          builder: (context, state) {
                            if (state is BasketDetailLoaded) {
                              sidName = widget.sid;
                              logoUrl = "$baseUrl/serviceproviderprofile/" +
                                  state.ServiceProviderData.logo;
                              restaurantName =
                                  state.ServiceProviderData.fullname;
                              location = state.ServiceProviderData.address;
                              openTime = state.ServiceProviderData.openingTime;
                              closeTime = state.ServiceProviderData.closingTime;
                              latitude = double.parse(state.ServiceProviderData.latitude);
                              longitude = double.parse(state.ServiceProviderData.longitude);
                              print("Longitude is"+longitude.toString());
                              calculateDistance(latitude, longitude , myLatitude, myLongitude);
                              ratings = double.parse(
                                  state.ServiceProviderData.averageRate);
                              firstLoading = false;
                              return BasketListTile(
                                sid: sidName,
                                logoUrl: logoUrl,
                                restaurantName: capitalize(restaurantName),
                                location: location,
                                price: 10,
                                itemQty: "1",
                                openTime: openTime,
                                closeTime: closeTime,
                                ratings: ratings,
                                items: [],
                              );
                            } else {
                              if (firstLoading == false) {
                                return BasketListTile(
                                    sid: sidName,
                                    logoUrl: logoUrl,
                                    restaurantName: restaurantName,
                                    location: location,
                                    price: 10,
                                    itemQty: "1",
                                    openTime: openTime,
                                    closeTime: closeTime,
                                    items: [],
                                    ratings: ratings);
                              } else {
                                return Container();
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              width: screenWidth,
                              child: Text(
                                "ITEMS",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 75, 74, 74),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig(context).nameSize() - 2),
                              ),
                            ),
                          ),
                          BlocBuilder<BasketDetailBloc, BasketDetailState>(
                            builder: (context, state) {
                              if (state is BasketDetailLoaded) {
                                CurrenBasketItem = state.BasketItem;
                                return Container(
                                  height: screenHeight / 2.5,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.BasketItem.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // int rate = state.BasketItem[index].rate;
                                      // int quantity =
                                      //     state.BasketItem[index].quantity;
                                      return Container(
                                        height: 100,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: screenWidth - 20,
                                                  height: 95,
                                                  child: BasketItemsContainer(
                                                    sid: widget.sid,
                                                    itemId: state
                                                        .BasketItem[index]
                                                        .itemId,
                                                    itemName: state
                                                        .BasketItem[index]
                                                        .itemName
                                                        .toString(),
                                                    price: state
                                                        .BasketItem[index].rate,
                                                    count: state
                                                        .BasketItem[index]
                                                        .quantity
                                                        .toString(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    DeleteItemFromBasket(
                                                        widget.sid,
                                                        state.BasketItem[index]
                                                            .itemId);
                                                  },
                                                  child: Container(
                                                    height: 80,
                                                    width: 100,
                                                    color: Colors.red,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: 32,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                if (CurrenBasketItem.isEmpty == true) {
                                  return Container();
                                } else {
                                  return Container(
                                    height: 300,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: CurrenBasketItem.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // int rate = CurrenBasketItem[index].rate;
                                        // int quantity =
                                        //     CurrenBasketItem[index].quantity;
                                        print(total_sum);
                                        return Dismissible(
                                          key: Key("Hello"),
                                          child: Container(
                                            height: 100,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: screenWidth - 20,
                                                      height: 95,
                                                      child: BasketItemsContainer(
                                                        sid: widget.sid,
                                                        itemId: CurrenBasketItem[
                                                                index]
                                                            .itemId,
                                                        itemName:
                                                            CurrenBasketItem[
                                                                    index]
                                                                .itemName
                                                                .toString(),
                                                        price: CurrenBasketItem[
                                                                index]
                                                            .rate,
                                                        count: CurrenBasketItem[
                                                                index]
                                                            .quantity
                                                            .toString(),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        DeleteItemFromBasket(
                                                            widget.sid,
                                                            CurrenBasketItem[
                                                                    index]
                                                                .itemId);
                                                      },
                                                      child: Container(
                                                        height: 80,
                                                        width: 100,
                                                        color: Colors.red,
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                          size: 32,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            loading == true
                ? BlocBuilder<BasketDetailBloc, BasketDetailState>(
                    builder: (context, state) {
                      if (state is BasketDetailLoading) {
                        return CustomeLoader();
                      } else {
                        return Container();
                      }
                    },
                  )
                : Container()
          ],
        ),
      ),
      bottomSheet: Container(
        height: 280,
        width: screenWidth,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SUB-TOTAL',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      BlocBuilder<BasketDetailBloc, BasketDetailState>(
                        builder: (context, state) {
                          if (state is BasketDetailLoaded) {
                            total_value = state.total_sum;
                            return Text(
                              "Rs.${state.total_sum}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            );
                          } else {
                            return Text(
                              "Rs.${total_value}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Rs. 0',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'DELIVERY CHARGE',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Rs. 0',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GRAND TOTAL',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig(context).nameSize() - 2),
                      ),
                      BlocBuilder<BasketDetailBloc, BasketDetailState>(
                        builder: (context, state) {
                          if (state is BasketDetailLoaded) {
                            total_value = state.total_sum;
                            return Text(
                              "Rs.${state.total_sum}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          } else {
                            return Text(
                              "Rs.${total_value}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      addItemsDialog(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,4,0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colours.primarygreen,
                              ),
                              width: 50,
                              height: 50,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("Add items",
                        style: TextStyle(fontSize: 10,color: Colours.primarygreen),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
            BlocBuilder<BasketDetailBloc, BasketDetailState>(
              builder: (context, state) {
                List basketList=[];
                if(state is BasketDetailLoaded){
                  logoUrl = "$baseUrl/serviceproviderprofile/" +
                                  state.ServiceProviderData.logo;
                  restaurantName =
                                  state.ServiceProviderData.fullname;
                  location = state.ServiceProviderData.address;
                  
                  print(logoUrl);
                  print(restaurantName);
                  print(location);
                  print(state.BasketItem);
                  basketList = state.BasketItem;
                  print(basketList);
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(BlocProvider(
                        create: (context) => LocationBloc(),
                        child: PaymentPage(
                            serviceProviderName:restaurantName,
                            serviceProviderlocation :location ,
                            logoUrl : logoUrl,
                            basketItem: basketList,
                            sid: widget.sid,
                            phoneNo: phoneno,
                            total_value: total_value),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: const Color(0xFF0DAD6A),
                    ),
                    child: Text(
                      'SUBMIT ORDER',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig(context).nameSize()),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyDialogShape extends RoundedRectangleBorder {
  // Custom shape for the AlertDialog
  @override
  RoundedRectangleBorder resolve(Set<MaterialState> states) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Set the desired border radius
    );
  }
}
