import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/screens/all_restaurant_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Controller/bloc/RideShare/ride_share_bloc.dart';
import '../../../../../Controller/bloc/Search/bloc/search_bloc.dart';
import '../../../../../Controller/bloc/map/bloc/map_bloc.dart';
import '../../../../constants/colors.dart';
import '../Groceries/StoresScreen.dart';
import '../Restaurants/screens/restaurants_page.dart';
import '../RideShare/RideShare.dart';

// ignore: must_be_immutable
class RestroGroceryLink extends StatefulWidget {
  Function callback;
  Function callback2;
   RestroGroceryLink({super.key,
   required this.callback,
   required this.callback2 });

  @override
  State<RestroGroceryLink> createState() => _RestroGroceryLinkState();
}

class _RestroGroceryLinkState extends State<RestroGroceryLink> {
    String latitude = '';
    String longitude ='';
    String locationName ='';
    String placeName ='';
    getLocation()async{
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      setState(() {
      latitude = _locationDetail.getString('latitude')?? '28.2096';
      longitude = _locationDetail.getString('longitude')??'83.9856';
      locationName = _locationDetail.getString('locationName')??'';
      placeName = _locationDetail.getString('placeName')??'';
      });
    }
      void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alert!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Please log in to enter ride share',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
            ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Login'),
                    onPressed: () {
                      widget.callback2();
                    Navigator.of(context).pop();
                      
                    },
              ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
       
      );
    },
  );
}


  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => SearchBloc(),
                              child: AllRestaurantPage(tabValue: 0,
                              callback:widget.callback,
                              ),
                            )));
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/images/restaurant.png",
                        fit: BoxFit.fill,
                      )),
                ),
                Text(
                  "Restaurants",
                  style: TextStyle(fontSize: 9),
                ),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => SearchBloc(),
                              child: AllRestaurantPage(tabValue: 1,
                              callback: widget.callback,),
                            )));
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/images/grocery-cart.png",
                        fit: BoxFit.fill,
                      )),
                ),
                Text(
                  "Groceries",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () async{
                     SharedPreferences prefs = await SharedPreferences.getInstance();
          String? isLoggedIn = prefs.getString('isLoggedIn');
          if (isLoggedIn == "true") {
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => RideShareBloc(), // Replace with your RideShareBloc
                    child: BlocProvider(
                      create: (context) => MapBloc(), // Replace with your MapBloc
                      child: RideShare(
                        fromPayment: false,
                        latitude:latitude,
                        longitude:longitude,
                        locationName:locationName,
                        placeName:placeName,
                      ),
                    ),
                  ),
                ),
              );
          } else {
            _showAlertDialog(context);
          }
                    
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/images/rideabike.png",
                        fit: BoxFit.fill,
                      )),
                ),
                Text(
                  "Ride",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
