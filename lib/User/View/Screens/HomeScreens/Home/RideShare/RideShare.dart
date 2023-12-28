import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/repositories/get_nearby_driver.dart';
import '../../../../../Controller/repositories/rideShare/add_driver_review.dart';
import '../../../../../Model/nearby_driver_model.dart';
import 'Components/MainBottomSheet.dart';
import 'Components/MyDrawer.dart';
import 'Components/RideShareLoader.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'dart:math';
import 'package:http/http.dart' as http;

import 'Views/RideShareDriverPage.dart';
class RideShare extends StatefulWidget {
  bool? fromPayment;
  String latitude;
  String longitude;
  String locationName;
  String placeName;
  RideShare(
      {super.key,
      this.fromPayment,
      required this.latitude,
      required this.longitude,
      required this.locationName,
      required this.placeName});

  @override
  State<RideShare> createState() => _RideShareState();
}

class _RideShareState extends State<RideShare>{
  bool recommendPrice = false;
  maps.LatLng? _center = maps.LatLng(28.2096, 83.9856);
  maps.GoogleMapController? _mapController;
  bool loading = false;
  int _seconds = 0;
  late Timer _timer;
  updateMarkerPositions() {
    setState(() {
      markerPosition1 = maps.LatLng(
        markerPosition1.latitude + 0.00001,
        markerPosition1.longitude + 0.00001,
      );
      markerPosition2 = maps.LatLng(
        markerPosition2.latitude - 0.00001,
        markerPosition2.longitude - 0.00001,
      );
    });
  }
List rideType =['null','Motorbike','Car','Courier','Auto']; 
int indexValue =1;
  indexChecker(int i){
    setState(() {
      indexValue = i;
    });
    print("The index clicked is"+indexValue.toString());
  }
bool cash  = true;
bool canProcessMessages = true;
changePaymentMethod(bool cashValue){
  print("The cash Value is"+cashValue.toString());
  setState(() {
    cash = cashValue;
  });
    print("The cash Value is"+cash.toString());
}
  getNearByDriver() async {
    print("Getting nearby driver");
    NearByDriverRepository repo = NearByDriverRepository();
    NearByDriverModel model =
        await repo.getNearByDriverData(widget.latitude, widget.longitude, '1',(indexValue-1).toString());
    for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
      if(model.nearByDriverPlayerIds == []){
      }
      else{
         double lat =
          double.parse(model.nearByDriverPlayerIds![i].latitude.toString());
      double long =
          double.parse(model.nearByDriverPlayerIds![i].longitude.toString());
      LatLng position = LatLng(lat, long);
      _addDriverMarker(position);
      print(position);
      }
     
    }
  }
  bool alreadyRecommendedOnce = false;
  String recommendedFare = '';
  String distanceValue = '';
  double distance=0.0;
  recommendPriceCallback() {
    LatLng point1 =
        LatLng(sourceLatitude, sourceLongitude); // Coordinates for point 1
    LatLng point2 = LatLng(
        destinationLatitude, destinationLongitude); // Coordinates for point 2

    distance = calculateDistance(point1, point2);
    int dist = distance.toInt();
    int cost = (100+ ((dist-1000) / 1000)*50).toInt();
    print('Distance between point 1 and point 2: ${dist} meters');
    int actualDist = distance.toInt();
    setState(() {
      distanceValue = (dist/1000).toString()+'Km';
      fare.text = 'Rs. ${cost}';
      recommendedFare= 'Rs. ${cost}';
      recommendPrice = true;
    });
    print("The distance values is"+distanceValue.toString());
  }

  double calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // Earth's radius in meters

    // Convert latitude and longitude from degrees to radians
    double lat1 = start.latitude * pi / 180.0;
    double lon1 = start.longitude * pi / 180.0;
    double lat2 = end.latitude * pi / 180.0;
    double lon2 = end.longitude * pi / 180.0;

    // Haversine formula
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;
    double a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  openFirstListener(){
     print("The first listener is opened");
    setState(() {
       messageSubscription00?.resume();
       canProcessMessages =true;
    });
  }
  String profileUrl ='null';
  getUserProfile()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userthumbnail =prefs.getString('user_thumbnail');
     print("The user thumbnail is"+userthumbnail.toString());
     if(userthumbnail.toString() != "null"){
      setState(() {
        profileUrl = userthumbnail.toString();
      });
     }
  }
  @override
  initState() {
    getUserProfile();
  openFirstListener();
  setState(() {
     canProcessMessages =true;
  });
    setCustomMarker();
    setCustomMarker2();
    setSourceCustomMarker();
    setDestinationCustomMarker();
    getNearByDriver();
    fromLocation.text = widget.locationName +' ,' +widget.placeName;
    // _timer = Timer.periodic(Duration(seconds: 30), (timer) {
    //   setState(() {
    //     print(_seconds++);
    //     getNearByDriver();
    //   });
    // });
    super.initState();
  }

  loaderCallback() {
    setState(() {
      loading = false;
    });
  }

 
  bool orderAccepted = false;
  double? latitude;
  double? longitude;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  maps.LatLng markerPosition1 = maps.LatLng(28.2096, 83.9856);
  maps.LatLng markerPosition2 = maps.LatLng(28.2096, 83.9856);

  bool showMap = true;
  bool showBottomSheet = true;
  String userId ='0';

  BitmapDescriptor? customIcon;

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)), // Set the desired size
      'assets/rideshare/resized_bike_icon.png',
    );
  }
   BitmapDescriptor? sourceCustomIcon;

  void setSourceCustomMarker() async {
    sourceCustomIcon= await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(5, 5)), // Set the desired size
      'assets/rideshare/markerA.png',
    );
  }
   BitmapDescriptor? destinationCustomIcon;

  void setDestinationCustomMarker() async {
    destinationCustomIcon= await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)), // Set the desired size
      'assets/rideshare/markerB.png',
    );
  }

  BitmapDescriptor? customIcon2;
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
                Text('Are you done with ride sharing?',style: TextStyle(fontSize: 14),),
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
                    child: Text('No'),
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
                    child: Text('Yes'),
                    onPressed: ()async {
                  // Fluttertoast.showToast(
                  //   msg: 'The ride was cancelled',
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.BOTTOM,
                  //   backgroundColor: Colors.black54,
                  //   textColor: Colors.white,
                  //   fontSize: 16.0,
                  // );
                  Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                         canProcessMessages = true;
                        showMap = false;
                      });
                      // });
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      Get.back();
                      // Future.delayed(Duration(seconds: 1), () {
                      Get.back();
                      // });
                    });
                      
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
  double sourceLatitude = 0.0;
  double sourceLongitude = 0;
  double destinationLatitude = 0;
  double destinationLongitude = 0;
  void setCustomMarker2() async {
    customIcon2 = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)), // Set the desired size
      'assets/rideshare/car_icon4.png',
    );
  }
  final Map<String, Marker> _markers = {
    'marker1': Marker(
    markerId: MarkerId('marker1'),
    position: LatLng(37.7510, -122.2005),
    // Other marker properties
  ),
  'marker2': Marker(
    markerId: MarkerId('marker2'),
    position: LatLng(37.7510, -122.2005),
    // Other marker properties
  ),
  };
  void _addDriverMarker(LatLng position) {
    final MarkerId markerId = MarkerId(position.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      icon: customIcon!,
      infoWindow: InfoWindow(
        title: 'Marker Title',
        snippet: 'Marker Snippet',
      ),
    );
    Map<String, Marker> markerValue ={
      '$markerId':marker
    };
    setState(() {
      _markers.addAll(markerValue);
    });
  }
  TextEditingController fromLocation = TextEditingController();
  TextEditingController toLocation = TextEditingController();
  TextEditingController fare = TextEditingController();
  TextEditingController comment = TextEditingController();
  List<LatLng> _routeCoordinates = [];
  Future<void> getRoute() async {
    final directions = GoogleMapsDirections(
      apiKey: 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0',
    );
    final directionsResponse = await directions.directionsWithLocation(
      Location(lat: sourceLatitude, lng: sourceLongitude),
      Location(lat: destinationLatitude, lng: destinationLongitude),
    );
    print("The direction response is");
    print(directionsResponse);
    if (directionsResponse.isOkay) {
      final route = directionsResponse.routes.first;
      setState(() {
        _routeCoordinates.clear();
        print("route leg is");
        print(route.legs[0].steps);
        for (final step in route.legs[0].steps) {
          print("route");
          _routeCoordinates
              .add(LatLng(step.startLocation.lat, step.startLocation.lng));
          print(_routeCoordinates);
        }
      });
    }
  }
CameraPosition? updatedCameraPosition;
bool changeFirstBorderColor = false;
bool changeSecondBorderColor = false;
LatLng? marker1Position;
LatLng? marker2Position;
  getSourceLocation(double sourceLat, double sourceLong) {
    print("The source lat and long is " +
        sourceLat.toString() +
        sourceLong.toString());
    setState(() {
      sourceLatitude = sourceLat;
      sourceLongitude = sourceLong;
      changeFirstBorderColor= true;
      CameraUpdate cameraUpdate =
          CameraUpdate.newLatLng(LatLng(sourceLatitude, sourceLongitude));
      _mapController!.animateCamera(cameraUpdate);
      print("The center is ");
      print(_center);
      LatLng sourcePosition = LatLng(sourceLatitude, sourceLongitude);
      marker1Position =sourcePosition;
      MarkerId markerId = MarkerId(sourcePosition.toString());
      Marker sourceMarker = Marker(
        markerId: markerId,
        position: sourcePosition,
         icon: sourceCustomIcon!,
      );
      _markers['marker1']= sourceMarker;
      if (sourceLatitude != 0 &&
          sourceLongitude != 0 &&
          destinationLatitude != 0 &&
          destinationLongitude != 0) {
        print("show Route");

        getRoute();
        recommendPriceCallback();
      }
    });
  }

  getDestinationLocation(double destinationLat, double destinationLong) {
    print("The destination lat and long is " +
        destinationLat.toString() +
        destinationLong.toString());
    setState(() {
      destinationLatitude = destinationLat;
      destinationLongitude = destinationLong;
      changeSecondBorderColor = true;
      LatLng destinationPosition =
          LatLng(destinationLatitude, destinationLongitude);
            marker2Position =destinationPosition;
      MarkerId markerId = MarkerId(destinationPosition.toString());
      Marker destinationMarker = Marker(
        markerId: markerId,
        position: destinationPosition,
         icon: destinationCustomIcon!,
      );
      _markers['marker2']= destinationMarker;
      if (sourceLatitude != 0 &&
          sourceLongitude != 0 &&
          destinationLatitude != 0 &&
          destinationLongitude != 0) {
        CameraUpdate cameraUpdate = CameraUpdate.newLatLng(
            LatLng(destinationLatitude, destinationLongitude));
        _mapController!.animateCamera(cameraUpdate);
        print("show Route");

        getRoute();
        recommendPriceCallback();
      }
    });
  }

    StreamSubscription<RemoteMessage>? messageSubscription00;
    Future<void>  FindDriver()async{    
    String category1;
    String yourLocation;
    String destinationLocation;
    String fare2;
    String comment1;
    double sourceLatitude2;
    double sourceLongitude2;
    double destinationLatitude2;
    double destinationLongitude2;
    List notifications = [];

      category1 = 'Moto';
      yourLocation = fromLocation.text;
      destinationLocation = toLocation.text;
      fare2 = fare.text;
      comment1 = comment.text;
      sourceLatitude2 = sourceLatitude;
      sourceLongitude2 = sourceLongitude;
      destinationLatitude2 = destinationLatitude;
      destinationLongitude2 = destinationLongitude;
      if (yourLocation == '') {
        print("location Error");
      //  emit(yourlocationError());
      } else if (destinationLocation == '') {
            print("Destination Error");
       // emit(destinationlocationError());
      } else if (fare == '') {
        print("Fare Error");
        //emit(fareError());
      }
      else {
        String token ='';
        List AllPlayerIds = [];

        sendNotificationToNearByRideShareDrivers() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String username = await prefs.getString('fname')!;
          String phoneNo = await prefs.getString('phoneno')!;
          userId  = await prefs.getString('user_id')!;
           
//    if (Platform.isIOS) {
//     FirebaseMessaging.instance.getAPNSToken().then((tokenValue) {
//   if (token != null) {
//     token = tokenValue;
//   } else {
//     token = tokenValue;
//   }

// });
//   } 
//   else{
    await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('Token $value');
              token = value.toString();
            });
          });
          NearByDriverRepository repo = NearByDriverRepository();
          NearByDriverModel model;
          print("The index value is"+indexValue.toString());
          if(indexValue == 1){//Send to bike and scooter
            model=await repo.getNearByDriverData('28.105', '83.8659', '1','0');
             try{
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              if(model.nearByDriverPlayerIds![i].playerId != null){
                 AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    'status':'user ride request',
                    'userId':userId,
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category1,
                    "amount": fare2,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": distanceValue,
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude2.toString(),
                    'sourceLongitude': sourceLongitude2.toString(),
                    'destinationLatitude': destinationLatitude2.toString(),
                    'destinationLongitude': destinationLongitude2.toString(),
                    'rideType':rideType[indexValue].toString(),
                    'userProfileUrl':profileUrl
                  }
                };
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
          }
              }
              catch(e){
                print("Error Occured"+e.toString());
              }
            AllPlayerIds =[];
            print("All player id list is" +AllPlayerIds.toString());
            model=await repo.getNearByDriverData('28.105', '83.8659', '1','2');
             try{
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              if(model.nearByDriverPlayerIds![i].playerId != null){
                 AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    'status':'user ride request',
                    'userId':userId,
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category1,
                    "amount": fare2,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": distanceValue,
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude2.toString(),
                    'sourceLongitude': sourceLongitude2.toString(),
                    'destinationLatitude': destinationLatitude2.toString(),
                    'destinationLongitude': destinationLongitude2.toString(),
                    'rideType':rideType[indexValue].toString(),
                    'userProfileUrl':profileUrl
                  }
                };
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
          }
              }
              catch(e){
                print("Error Occured"+e.toString());
              }
          }
          if(indexValue ==2){//send to taxi
            model=await repo.getNearByDriverData('28.105', '83.8659', '1','1');
             try{
                AllPlayerIds =[];
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              if(model.nearByDriverPlayerIds![i].playerId != null){
                 AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    'status':'user ride request',
                    'userId':userId,
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category1,
                    "amount": fare2,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": distanceValue,
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude2.toString(),
                    'sourceLongitude': sourceLongitude2.toString(),
                    'destinationLatitude': destinationLatitude2.toString(),
                    'destinationLongitude': destinationLongitude2.toString(),
                    'rideType':rideType[indexValue].toString(),
                    'userProfileUrl':profileUrl
                  }
                };
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
          }
              }
              catch(e){
                print("Error Occured"+e.toString());
              }
          }
          if(indexValue ==3){//Send to bike and Scooter
            AllPlayerIds =[];
            
            model=await repo.getNearByDriverData('28.105', '83.8659', '1','0');
             try{
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              if(model.nearByDriverPlayerIds![i].playerId != null){
                 AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    'status':'user ride request',
                    'userId':userId,
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category1,
                    "amount": fare2,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": distanceValue,
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude2.toString(),
                    'sourceLongitude': sourceLongitude2.toString(),
                    'destinationLatitude': destinationLatitude2.toString(),
                    'destinationLongitude': destinationLongitude2.toString(),
                    'rideType':rideType[indexValue].toString(),
                    'userProfileUrl':profileUrl
                  }
                };
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
          }
              }
              catch(e){
                print("Error Occured"+e.toString());
              }
                AllPlayerIds =[];
                print("All player id list is" +AllPlayerIds.toString());
            model=await repo.getNearByDriverData('28.105', '83.8659', '1','2');
             try{
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              if(model.nearByDriverPlayerIds![i].playerId != null){
                 AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    'status':'user ride request',
                    'userId':userId,
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category1,
                    "amount": fare2,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": distanceValue,
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude2.toString(),
                    'sourceLongitude': sourceLongitude2.toString(),
                    'destinationLatitude': destinationLatitude2.toString(),
                    'destinationLongitude': destinationLongitude2.toString(),
                    'rideType':rideType[indexValue].toString(),
                    'userProfileUrl':profileUrl
                  }
                };
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
          }
              }
              catch(e){
                print("Error Occured"+e.toString());
              }
          }
          if(indexValue ==4){
              AllPlayerIds =[];
            model=await repo.getNearByDriverData('28.105', '83.8659', '1','2');
             try{
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              if(model.nearByDriverPlayerIds![i].playerId != null){
                 AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    'status':'user ride request',
                    'userId':userId,
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category1,
                    "amount": fare2,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": distanceValue,
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude2.toString(),
                    'sourceLongitude': sourceLongitude2.toString(),
                    'destinationLatitude': destinationLatitude2.toString(),
                    'destinationLongitude': destinationLongitude2.toString(),
                    'rideType':rideType[indexValue].toString(),
                    'userProfileUrl':profileUrl
                  }
                };
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
          }
              }
              catch(e){
                print("Error Occured"+e.toString());
              }
          }
          // if(indexValue == 3){
          //    model=await repo.getNearByDriverData('28.105', '83.8659', '1','0');
          // }
          // else{
          
          
             
        }

        sendNotificationToNearByRideShareDrivers();
      final player = AudioPlayer();
      playNotification(){
  print("play sound");
  player.play(AssetSource('notification.wav'));
 }
       callback() {
          notifications = [];
          notifications.length = 0;
          print(notifications);
          print(notifications.length);
          print("cleared notification");
          
          
         // messageSubscription.cancel();
        }
        Map<String,dynamic> firstData ={};   
        bool firstMessageReceived = false;
         if(canProcessMessages == true){
        
        messageSubscription00=
             FirebaseMessaging.onMessage.listen((RemoteMessage message){
             
            print(canProcessMessages);
            print(message.data);
            if (canProcessMessages == true) {
             
              print("the notification length is");
              print(notifications.length);
              print(message.data['status']);
              if(message.data['status'] == 'cancelled'){
                Get.back();
                // _showReviewDialog();
               // showReviewNotification();
              }
              if(message.data['status'] == 'ride completed'){
                _showReviewDialog();
               // showReviewNotification();
              }
              if(message.data['status'] == 'driver ride request'){
                 notifications.add(message.data);
                 if (notifications.length == 1) {
                playNotification();
                setState(() {
                  canProcessMessages = false;
                  loading = false;
                });
                print("The data received is");
                print(message.data);
                  Get.to(RideShareDriverPage(
                    userId:userId,
                    orderAccepted:onOrderAccepted,
                    callback: callback,
                    firstNotification: message.data,
                    flag: true,
                    cancelCallBack:cancelCallBack,
                    cash:cash,
                    openFirstListener:openFirstListener,
                    travelDistance:distance
                  ));
                  // messageSubscription00?.cancel();
                   
               
              }
              }
             
            }
            canProcessMessages = false;
          });
          
          }
        
      }
      //}
}

  Future<void> showReviewNotification() async {
  // Create a notification object.
  try{
    print("notification 1");
    const iosNotificatonDetail = DarwinNotificationDetails();
    const androidNotificationDetail = AndroidNotificationDetails(
          'channel_id', 'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/ic_launcher');
  final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetail,
      iOS: iosNotificatonDetail);
  await FlutterLocalNotificationsPlugin().show(1,
      'MeroAto', 
      'Provide driver feedback',
      notificationDetails);
  }
  catch(e){
    print("The error is"+e.toString());
  }
}
   findDriverCallBack() {
    print("Finding Drivers");
    FindDriver();
    if(mounted){
setState(() {
      loading = !loading;
    });
    }
    else{
      loading = !loading;
    }
    
  }

sendCancelNotification()async{
    try{   
      var data = {
      'to' : '$oADriverPlayerId',
      'priority': 'high',
      'data':{
        'phoneno':'$oAPhoneNo',
        'verificationCode':'$oAVerificationCode',
        'status':'cancelled'
      }
      };
      print(data);
      print("posting Data to"); 
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode (data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
    //sendRejectResponsetoAllOtherDrivers(driverId);
      
    }
    catch(e){
      print("Error Occured");
    }
}
cancelCallBack(){
    setState(() {
      sendCancelNotification();
      setState(() {
        messageSubscription00?.cancel();
      loading =true;
      });
      
      Future.delayed(Duration(seconds: 2));
      showMap =false;
      Get.back();
    });
  }

  String oADriverName='';
  String oAAmount='';
  String oATime='';
  String oAPhoneNo='';
  String oAPlateNo='';
  String oAsourceLocation='';
  String oAdestinationLocation='';
  String oADriverPlayerId ='';
  String oAVerificationCode ='';
  String oADriverId ='';
  String oADriverProfileUrl = '';
  onOrderAccepted(String driverPlayerId,String driverName,String amount,String time,
   String phoneNo,String plateNo, String sourceLocation,String destinationLocation,
   String verificationCode,
   String driver_id,String  driver_profile_url){
    print("call back 3");
    if(mounted){
      print('mounted');
      setState(() {
      oADriverPlayerId = driverPlayerId;
      orderAccepted = true;
      oADriverName = driverName;
      oAAmount = amount;
      oATime = time;
      oAPhoneNo= phoneNo;
      oAPlateNo = plateNo;
      oAsourceLocation = sourceLocation;
      oAdestinationLocation = destinationLocation;
      oAVerificationCode = verificationCode;
      oADriverId = driver_id.toString();
      oADriverProfileUrl = driver_profile_url.toString();
   });
    }
     else{
       print('not mounted');
       orderAccepted = true;
      oADriverName = driverName;
      oAAmount = amount;
      oATime = time;
      oAPhoneNo= phoneNo;
      oAPlateNo = plateNo;
      oAsourceLocation = sourceLocation;
      oAdestinationLocation = destinationLocation;
    }
  }

   @override
  void dispose() {
    messageSubscription00?.cancel();
    print("dispose");
    _mapController?.dispose();
    _timer.cancel();
   
    super.dispose();
  }
  int rate=0;
  TextEditingController _titleController = TextEditingController();
    TextEditingController _reviewController = TextEditingController();

   void _showReviewDialog() {
    

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: const Center(child: Text('Write your driver review')),
          content: Container(
            width: screenWidth < 400 ? screenWidth / 1.5 : screenWidth / 1.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ratings:',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFFF7F09),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating.toInt();
                        });
                      },
                    ),
                  ],
                ),
                Text("Title"),
                Container(
                  height: 50,
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                TextFormField(
                  maxLines: 3,
                  controller: _reviewController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 250,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    width: screenWidth / 3.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFFFF0909),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    width: screenWidth / 3.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_titleController.text == '' ||
                            _reviewController.text == '') {
                              
                          Fluttertoast.showToast(
                            msg: "Please provide a full review",
                            toastLength:
                                Toast.LENGTH_SHORT, // Duration of the toast
                            gravity: ToastGravity.BOTTOM, // Toast position
                            timeInSecForIosWeb: 1, // Time duration for iOS
                            backgroundColor: Colors.black54, // Background color
                            textColor: Colors.white, // Text color
                            fontSize: 16.0, // Font size
                          );
                        } else {
                         
      SharedPreferences userData = await SharedPreferences.getInstance();
      String? userId = userData.getString('user_id');
      AddDriverReviewRepository review = new AddDriverReviewRepository();
      AddDriverReviewResponse response =
          await review.AddDriverReview(userId!, oADriverId, _titleController.text,  _reviewController.text, rate);
      print(response.body);
      var data = jsonDecode(response.body);
      if(data['status']=="success"){
         Fluttertoast.showToast(
                            msg: "The review was submitted",
                            toastLength:
                                Toast.LENGTH_SHORT, // Duration of the toast
                            gravity: ToastGravity.BOTTOM, // Toast position
                            timeInSecForIosWeb: 1, // Time duration for iOS
                            backgroundColor: Colors.black54, // Background color
                            textColor: Colors.white, // Text color
                            fontSize: 16.0, // Font size
                          );
                          _titleController.clear();
                          _reviewController.clear();
                          Navigator.pop(context);
                           Navigator.pop(context);
      }
      else{
        Fluttertoast.showToast(
                            msg: "Error Occured",
                            toastLength:
                                Toast.LENGTH_SHORT, // Duration of the toast
                            gravity: ToastGravity.BOTTOM, // Toast position
                            timeInSecForIosWeb: 1, // Time duration for iOS
                            backgroundColor: Colors.black54, // Background color
                            textColor: Colors.white, // Text color
                            fontSize: 16.0, // Font size
                          );
      }
                          

                          
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFF0DAD6A),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   
    CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(double.parse(widget.latitude),double.parse(widget.longitude)),
    zoom: 15.0,
    tilt: 0,
    bearing: 0,
  );
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                key: _scaffoldKey,
                drawer: MyDrawer(showMap: showMap, loading:loading),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: BackButton(
                    color: Colors.black,
                    onPressed: () {
                         _showAlertDialog(context);
                    },
                  ),
                  title: Text(
                    "Ride Share",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        //getDirections();
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  ],
                ),
                body: showMap
                    ? Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: initialCameraPosition,
                            onMapCreated: (GoogleMapController controller) {
                              _mapController = controller;
                               getSourceLocation(double.parse(widget.latitude),double.parse(widget.longitude));
                            },
                            myLocationEnabled: true,
                            onCameraMove: (CameraPosition position) {
                              setState(() {
                                latitude = position.target.latitude;
                                longitude = position.target.longitude;
                                showBottomSheet = false;
                              });
                            },
                            onCameraIdle: () {
                              Future.delayed(Duration(milliseconds: 350), () {
                                setState(() {
                                  showBottomSheet = true;
                                });
                              });
                            },
                            polylines: {
                              maps.Polyline(
                                width: 4,
                                polylineId: PolylineId('route'),
                                color: Colours.primarygreen,
                                points: _routeCoordinates,
                              )
                            },
                            markers:  _markers.values.toSet(),
                          ),
                        ],
                      )
                    : Container(),
                bottomSheet: showBottomSheet
                    ? MainBottomSheet(
                              findDriverCallBack: findDriverCallBack,
                              fromLocation: fromLocation,
                              toLocation: toLocation,
                              fare: fare,
                              comment: comment,
                              getSourceLocation: getSourceLocation,
                              getDestinationLocation: getDestinationLocation,
                              recommendPrice: recommendPrice,
                              recommendPriceCallback: recommendPriceCallback,
                              sourceLatitude: sourceLatitude,
                              sourceLongitude: sourceLongitude,
                              destinationLatitude: destinationLatitude,
                              destinationLongitude: destinationLongitude,
                              orderAccepted:orderAccepted,
                              onOrderAccepted: onOrderAccepted,
                              oADriverName: oADriverName,
        oAAmount: oAAmount  ,
       oATime: oATime  ,
       oAPhoneNo: oAPhoneNo  ,
       oAPlateNo: oAPlateNo  ,
       oAsourceLocation: oAsourceLocation  ,
       oAdestinationLocation: oAdestinationLocation  ,
       oAVerificationCode:oAVerificationCode,
       oADriverProfileUrl:oADriverProfileUrl,
       changeFirstBorderColor:changeFirstBorderColor,
       changeSecondBorderColor: changeSecondBorderColor,
       recommendedFare:recommendedFare,
       cancelCallBack:cancelCallBack,
       cash:cash,
       cashCallBack : changePaymentMethod,
       indexChecker:indexChecker
                             )
                    : null,
              ),
              loading
                  ? RideShareLoader(
                    userId:userId,
                      callback: loaderCallback,
                    )
                  : Container()
            ],
          )),
    );
  }
}
