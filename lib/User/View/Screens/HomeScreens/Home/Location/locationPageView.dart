import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Location/LocationChangePage.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Location/MapPage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../../Controller/bloc/map/bloc/map_bloc.dart';
import '../../../../constants/colors.dart';
import '../../../../custome_loader.dart';

class LocationPageView extends StatefulWidget {
  bool? fromPayment;
  Function? callback;
  LocationPageView({super.key, this.fromPayment,this.callback});

  @override
  State<LocationPageView> createState() => _LocationPageViewState();
}

class _LocationPageViewState extends State<LocationPageView> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  bool loading =false;
  bool locationloaded =false;
  Position? currentLocation;
  Position? currentPosition;
  LatLng _center =
      LatLng(28.21754500300589, 83.98650613439649);
    Future<void> getCurrentLocationInMobile() async {
    try {
      print("Hello");
      setState(() {
        loading =true;
      });
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      String? latitude = _locationDetail.getString('latitude');
      String? longitude = _locationDetail.getString('longitude');
      print(latitude);
      if (latitude != null) {
        print("Part 1");
        setState(() {
          _center = LatLng(double.parse(latitude!), double.parse(longitude!));
          locationloaded = true;
          loading = false;
        });
        locationName = _locationDetail.getString('locationName');
        placeName = _locationDetail.getString('placeName');
      } else {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude,
          currentPosition!.longitude,
          localeIdentifier: 'en',
        );

        setState(() {
          _center =
              LatLng(currentPosition!.latitude, currentPosition!.longitude);
          
          Placemark currentPlacemark = placemarks.first;
          locationName = currentPlacemark.name ?? '';
          placeName = currentPlacemark.street ?? '';
          print("The current location is: $locationName, $placeName");

          loading = false;
          locationloaded = true;
        });
      }
      setState(() {
        print(loading);
        loading =false;
      });
    } catch (e) {
      // Handle any errors that occur during location retrieval
      print('Error getting current location: $e');
    }
  }

  @override
  void initState() {
    BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
    getCurrentLocationInMobile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        // First page content
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
             String locationName='';
             String placeName ='';
            if(state is LocationLoadedState){
              locationName = state.LocationName;
              placeName = state.PlaceName;
              
            }
            return LocationChangePage(
                currentLocation: '$locationName , $placeName', page: _pageController,
             
                );
          },
        ),
        // Second page with Google Map
        Scaffold(
          resizeToAvoidBottomInset:false,
            body: BlocProvider(
          create: (context) => MapBloc(),
          child: MapPage(
            page: _pageController,centerPoint:_center,fromPayment: widget.fromPayment,callback:widget.callback
        )),)
      ],
    );
  }
}

// class LocationChangePage extends StatefulWidget {
//   String currentLocation;
//   bool? fromPayment;
//   PageController page;
//   LocationChangePage(
//       {super.key,
//       required this.currentLocation,
//       this.fromPayment,
//       required this.page});

//   @override
//   State<LocationChangePage> createState() => _LocationChangePageState();
// }

// class _LocationChangePageState extends State<LocationChangePage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return WillPopScope(
//       onWillPop: () async {
//         Get.back();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           leading: BackButton(
//             color: Colors.black,
//             onPressed: () {
//               Get.back();
//             },
//           ),
//           title: Text(
//             "Delivery Location",
//             style: TextStyle(color: Colors.black),
//           ),
//           actions: [],
//           backgroundColor: Colors.white,
//         ),
//         body: Container(
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 80,
//                 ),
//                 Container(
//                     width: 200,
//                     height: 200,
//                     child: Image.asset(
//                         'assets/images/delivery boy on scooter.png')),
//                 Container(
//                   height: 220,
//                   width: 350,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade200, width: 0.5),
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Text(
//                         "Where should we deliver your order?",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w700),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Icon(
//                             Icons.location_on_outlined,
//                             color: Colours.primarygreen,
//                             size: 30,
//                           ),
//                           Container(
//                             width: 250,
//                             child: Text(
//                               "$locationName, $placeName",
//                             ),
//                           )
//                         ],
//                       ),
//                       Container(
//                         width: 250,
//                         height: 40,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             widget.page.animateToPage(
//                               1,
//                               duration: Duration(milliseconds: 400),
//                               curve: Curves.easeInOut,
//                             );
//                           },
//                           child: Text("Change Location"),
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Colours.primarygreen),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class GoogleMapPage extends StatefulWidget {
  final PageController page;
  GoogleMapPage({super.key, required this.page});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

String? locationName;
String? placeName;

class _GoogleMapPageState extends State<GoogleMapPage> {
  bool loading = false;

  bool locationloaded = false;
  Future<void> getLocation(double latitude, double longitude) async {
    try {
      // BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
      setState(() {
        loading = true;
      });
      print("the loader is");
      print(loading);
      SharedPreferences _locationDetail = await SharedPreferences.getInstance();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: 'en',
      );

      Placemark currentPlacemark = placemarks.first;
      setState(() {
        loading = true;
        locationName = currentPlacemark.name ?? '';
        placeName = currentPlacemark.street ?? '';
        _locationDetail.setString('locationName', locationName!);
        _locationDetail.setString('placeName', placeName!);
        _locationDetail.setString('latitude', latitude.toString()!);
        _locationDetail.setString('longitude', longitude.toString()!);
        locationloaded = true;
        print("The current location is: $locationName, $placeName");
      });
      await Future.delayed(Duration(seconds: 2));
      widget.page.animateToPage(
        0,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      // if (widget.fromPayment == true) {
      //   Get.back();
      //   Get.back();
      // } else {

      // }
    } catch (e) {
      // Handle any errors that occur during location retrieval
      print('Error getting current location: $e');
    }
  }

  LatLng markerPosition = LatLng(28.21754500300589, 83.98650613439649);
  void findLocation() {
    final double latitude = markerPosition.latitude;
    final double longitude = markerPosition.longitude;
  }

  GoogleMapController? _controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Stack(
            children: [
              GoogleMap(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet(),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      28.2096, 83.9856), // Set the initial position of the map
                  zoom: 14.0, // You can adjust the initial zoom level
                ),
                // Set markers if needed
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Icon(
                    Icons.location_pin,
                    size: 60,
                    color: Colours.primarygreen,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () async {
                            getLocation(markerPosition.latitude.toDouble(),
                                markerPosition.longitude.toDouble());
                          },
                          child: Text("SET LOCATION"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colours.primarygreen),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
              loading ? Container(child: CustomeLoader()) : Container()
            ],
          ),
          BackButton(
            onPressed: () {
              widget.page.animateToPage(
                0,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
