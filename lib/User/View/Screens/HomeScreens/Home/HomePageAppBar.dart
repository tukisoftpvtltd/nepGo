import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/SearchScreen2/SearchScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Controller/Functions/UserStatus.dart';
import '../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../Controller/bloc/Search/bloc/search_bloc.dart';
import '../../../constants/colors.dart';
import '../Notifications/Notifications.dart';
import 'FirstScreen.dart';
import 'Location/LocationChangePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:marquee/marquee.dart';

// ignore: must_be_immutable
class HomePageAppBar extends StatefulWidget {
  Function callback;
  var homeData;
  var advertisementData;
  Function callback2;
  HomePageAppBar(
      {super.key,
      required this.callback,
      required this.homeData,
      required this.advertisementData,
      required this.callback2});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  bool locationloaded = false;
  String? locationName = '';
  String? placeName = '';
  Position? currentLocation;
  double? lat;
  double? long;
  String? userLoginStatus;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
    getUserLoginStatus();
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
                Text('Please log in to view notifications.',style: TextStyle(fontSize: 14),),
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



  getUserLoginStatus() async {
    userLoginStatus = await isUserLoggedIn();
  }

  void launchGoogleMaps() async {
    final String googleMapsUrl = 'https://www.google.com/maps';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool? reload;
    return CustomScrollView( slivers: <Widget>[
        SliverAppBar(
    toolbarHeight: 62,
    backgroundColor: Colors.white,
    pinned: true,
    snap: true,
    floating: true,
    elevation: 0,
    leading: IconButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? isLoggedIn = prefs.getString('isLoggedIn');
          if (isLoggedIn == "true") {
            Get.to(Notifications());
          } else {
            _showAlertDialog(context);
          }
        },
        icon:const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.bell,
            color: Colors.black,
            size: 28,
          ),
        )),
    flexibleSpace: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationChangePage(
                       
                        callback:widget.callback,
                          currentLocation: "$locationName, $placeName",
                          position: LatLng(lat!, long!),)));
                },
                child: const Text(
                  "Map Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => LocationBloc(),
                      child: LocationChangePage(
                        currentLocation: "$locationName ,$placeName " ,
                        position: LatLng(lat!, long!),
                        ),
                    )));
          },
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoadingState) {
                return Container(
                   width: 250,
                  child: const Text(
                    "Set your location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  ),
                );
              } else if (state is LocationLoadedState) {
                locationName = state.LocationName;
                placeName = state.PlaceName;
                lat = double.parse(state.latitude);
                long = double.parse(state.longitude);
                String totalName =
                    locationName.toString() + placeName.toString();
                return totalName.length > 20
                    ? Container(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 220,
                              height: 25,
                              child: Marquee(
                                text:
                                    "${state.LocationName}, ${state.PlaceName}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                                blankSpace:
                                    20.0, // Adjust this value to control the gap between repetitions.
                                velocity:
                                    30.0, // Adjust this value to control the speed of sliding.
                                pauseAfterRound:const  Duration(
                                    seconds:
                                        1), // Optional: Pause after each round.
                                startPadding:
                                    10.0, // Optional: Initial padding before starting the slide.
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                scrollAxis: Axis.horizontal,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 13,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${state.LocationName},${state.PlaceName}",
                              textAlign: TextAlign.center,
                              style:const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 13,
                            ),
                          ],
                        ),
                      );
              } else {
                return Container(
                  width: 250,
                  child: Text(
                    "Set your location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15.0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0XFFF3F3F3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => SearchBloc(),
                        child: BlocProvider(
                          create: (context) => BasketBloc(),
                          child: SearchScreen(
                            callback:widget.callback
                          ),
                        ),
                      )));
            },
          ),
        ),
      ),
    ],
        ),
        SliverToBoxAdapter(
    child: Column(
      children: [
        Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    ),
        ),
         SliverToBoxAdapter(
          
           child: FirstScreen(
               latitude: lat == null ? 0.0 : lat!,
               longitude: long == null ? 0.0 : long!,
               data: [],
               advertisement: [],
               reload:reload,
               callback:widget.callback,
               callback2:widget.callback2
               
             ),
         ),
        
      //    SliverList(
      //  delegate: SliverChildListDelegate([
       
    
      //    ])),
      ]);
  }
}
