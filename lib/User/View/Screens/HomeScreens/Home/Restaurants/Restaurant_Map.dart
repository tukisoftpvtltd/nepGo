import 'package:flutter/material.dart';
import 'package:food_app/User/View/custome_loader.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantMap extends StatefulWidget {
  double latitude;
  double longitude;
  RestaurantMap({super.key,
  required this.latitude,
  required this.longitude,
  });

  @override
  State<RestaurantMap> createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {
  
  // void findLocation() {
  //   final double latitude = markerPosition.latitude;
  //   final double longitude = markerPosite;
  // }

  Set<Marker> markers = {

  };

  GoogleMapController? mapController;

  Marker staticMarker = Marker(
    markerId: MarkerId('static_marker'),
    position: LatLng(0, 0),
    draggable: false,
  );

  // bool locationloaded = false;
  // String? locationName = 'null';
  // String? placeName = 'null';
  // Position? currentLocation;
  // Position? currentPosition;
  // bool loading = true;
  // Future<void> getCurrentLocationInMobile() async {
  //   try {
  //     SharedPreferences _locationDetail = await SharedPreferences.getInstance();
  //     String? latitude = _locationDetail.getString('latitude');
  //     String? longitude = _locationDetail.getString('longitude');
  //     print(latitude);
  //     if (latitude != null) {
  //       setState(() {
  //         _center = LatLng(double.parse(latitude!), double.parse(longitude!));
  //         locationloaded = true;
  //         loading = false;
  //       });
  //       locationName = _locationDetail.getString('locationName');
  //       placeName = _locationDetail.getString('placeName');
  //     } else {
  //       currentPosition = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );

  //       List<Placemark> placemarks = await placemarkFromCoordinates(
  //         currentPosition!.latitude,
  //         currentPosition!.longitude,
  //         localeIdentifier: 'en',
  //       );

  //       setState(() {
  //         _center =
  //             LatLng(currentPosition!.latitude, currentPosition!.longitude);
  //         Placemark currentPlacemark = placemarks.first;
  //         locationName = currentPlacemark.name ?? '';
  //         placeName = currentPlacemark.street ?? '';
  //         print("The current location is: $locationName, $placeName");

  //         loading = false;
  //         locationloaded = true;
  //       });
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during location retrieval
  //     print('Error getting current location: $e');
  //   }
  // }

  // Future<void> getLocation(double latitude, double longitude) async {
  //   try {
  //     SharedPreferences _locationDetail = await SharedPreferences.getInstance();
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       latitude,
  //       longitude,
  //       localeIdentifier: 'en',
  //     );

  //     Placemark currentPlacemark = placemarks.first;
  //     setState(() {
  //       locationName = currentPlacemark.name ?? '';
  //       placeName = currentPlacemark.street ?? '';
  //       _locationDetail.setString('locationName', locationName!);
  //       _locationDetail.setString('placeName', placeName!);
  //       _locationDetail.setString('latitude', latitude.toString()!);
  //       _locationDetail.setString('longitude', longitude.toString()!);
  //       locationloaded = true;
  //       print("The current location is: $locationName, $placeName");
  //     });
  //     Get.offAll(BlocProvider(
  //       create: (context) => HomePageBloc(),
  //       child: HomeScreen(currentIndexNumber: 0,loginStatus: "true",),
  //     ));
  //   } catch (e) {
  //     // Handle any errors that occur during location retrieval
  //     print('Error getting current location: $e');
  //   }
  // }
  LatLng _center =LatLng(28.21754500300589, 83.98650613439649); 
  LatLng markerPosition = LatLng(28.21754500300589, 83.98650613439649);
  @override
  initState() {
    super.initState();
    _center = LatLng(widget.latitude,widget.longitude);
    markerPosition = LatLng(widget.latitude,widget.longitude);
    loading=false;

  }

bool loading = true;
bool showMap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            setState(() {
              loading=true;
              showMap=false;
            });
            Future.delayed(Duration(seconds: 2), () {
            
              Navigator.pop(context);
            });
            
          }, icon: Icon(Icons.arrow_back,
          color: Colors.black,),
        ),
        title: Text(
          "Location",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:Stack(
              children: [
                //WebViewExample(),
                showMap ?GoogleMap(
                  // liteModeEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  indoorViewEnabled: true,
                  mapType: MapType.normal,
                  // onMapCreated: (controller) {
                  //   mapController = controller;
                  // },
                  onCameraMove: (cameraPosition) {
                    // setState(() {
                    //   markerPosition = cameraPosition.target;
                    // });
                  },
                  initialCameraPosition:
                      CameraPosition(target: _center!, zoom: 18),
                  onTap: (position) {},
                  markers: {
                    Marker(
    markerId: MarkerId('static_marker'),
    position: LatLng(markerPosition.latitude, markerPosition.longitude),
    draggable: false,
  ),
                  },
                ):Container(),
                loading == true ?CustomeLoader():Container(),
                // Center(
                //   child: CircularProgressIndicator(),
                // ),
              
              ],
            ),

    );
  }
}



// class WebViewExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'https://maps.google.com/?q=37.819922,-122.478655',
//     );
//   }
// }

