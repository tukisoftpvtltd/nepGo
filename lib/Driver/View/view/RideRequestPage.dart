import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'as maps;
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../User/Controller/repositories/rideShare/userRideShareIssue/userRideShareIssue.dart';
import '../../Controller/repository/cancel/cancelRideShareByDriver.dart';
import '../../Controller/repository/driverIssue/driverIssue.dart';
import '../../Controller/repository/getDriverDetails.dart';
import '../../Controller/repository/makeRideComplete/completeRideByDriver.dart';
import '../../Model/DriverDetailModel.dart';
import '../components/RideShareLoader.dart';
import '../components/colors.dart';
import 'dart:math';

import '../constants/Constants.dart';
// ignore: must_be_immutable
class RideRequestPage extends StatefulWidget {
  String customerPlayerId;
  String sourceLatitude;
  String sourceLongitude;
  String destinationLatitude;
  String destinationLongitude;
  String passengerName;
  String phoneNo;
  String sourceLocation;
  String destinationLocation;
  String amount;
  double driverLatitude;
  double driverLongitude;
  Function openMainMessageListener;
  String distance;
  int index;
  Function deleteCallBack;
  Function clearNotifications;
  String userProfileUrl;
  RideRequestPage({super.key,
  required this.customerPlayerId,
  required this.sourceLatitude,required this.sourceLongitude,
  required this.destinationLatitude,required this.destinationLongitude,
  required this.passengerName,required this.phoneNo,
  required this.sourceLocation, required this.destinationLocation,
  required this.amount,
  required this.driverLatitude,
  required this.driverLongitude,
  required this.openMainMessageListener,
  required this.distance,
  required this.index,
  required this.deleteCallBack,
  required this.clearNotifications,
  required this.userProfileUrl
  });

  @override
  State<RideRequestPage> createState() => _RideRequestPageState();
}

class _RideRequestPageState extends State<RideRequestPage> {

getToken()async{
  await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('TOken $value');
              setState(() {
                token = value.toString();
              });
              
            });
          });
}
double radians(double degrees) {
  return degrees * (pi / 180.0);
}

double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
  const double earthRadius = 6371.0; // Earth radius in kilometers

  // Convert degrees to radians
  double startLatRad = radians(startLatitude);
  double endLatRad = radians(endLatitude);
  double latDiffRad = radians(endLatitude - startLatitude);
  double lonDiffRad = radians(endLongitude - startLongitude);

  // Haversine formula
  double a = sin(latDiffRad / 2) * sin(latDiffRad / 2) +
      cos(startLatRad) * cos(endLatRad) * sin(lonDiffRad / 2) * sin(lonDiffRad / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate distance
  double distance = earthRadius * c;

  return distance;
}


double driverDistance = 0.0;
String verificationCode = '';
DriverDetailModel? model;
String vehicleNumber='1234';
String driverProfileUrl = '';
  getDriverDetail()async{
   
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
    setState(() {
   if(model != null){
    vehicleNumber = model!.driverDetails!.vechicleNumber.toString();
    driverProfileUrl  = '$baseUrl/driverimages/${model!.driverDetails!.profileImage}';
    print("The driver Profile Url is $driverProfileUrl");
   }
   
  
      loading= false;
    });
  }
    @override
  void initState() {
    getDriverDetail();
    setState(() {
           driverDistance = calculateDistance(
        double.parse(widget.sourceLatitude), 
        double.parse(widget.sourceLongitude), 
        widget.driverLatitude,
        widget.driverLongitude);
    });

    getToken();
     
  //}
  print("the token is $token");
      setSourceCustomMarker();
     setDestinationCustomMarker();
     getRoute1();
     getRoute2();
     Timer(Duration(seconds: 1), () {
      setMakers();
    });
    
    //  if(listen =false){
    //   messageSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // setState(() {
    //   notifications.add(message.data);
    // });
    // });
    //  }
     
      
       // print("Message received 333");
       messageSubscription= FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       if(listen == true){
        print("Data is in new page 333");
      RemoteNotification?  notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      setState(() {
        notifications2.add(message.data);
      });
      print(notifications2);
      print(notifications2[0]['status']);
      print(notifications2[0]['verificationCode']);
     //if(notifications2.length >1){
      if(notifications2[0]['status'] == 'rejected'){
        widget.openMainMessageListener();
        print(notifications2);
         Fluttertoast.showToast(
    msg: "Your offer was rejected",
    toastLength: Toast.LENGTH_SHORT, // Duration for the toast message
    gravity: ToastGravity.BOTTOM, // Toast position
    timeInSecForIosWeb: 1, // Time duration for iOS (ignored on Android)
    backgroundColor: Colors.black54, // Background color of the toast
    textColor: Colors.white, // Text color of the toast
    fontSize: 16.0, // Font size of the toast message
  );    
       widget.deleteCallBack(widget.index);
         
        Future.delayed(Duration(seconds: 1), () {
          loading =false;
          showMap = false;
              
  
        Get.back();
 
      
  });
       
       // notifications2 =[];
      }
    // }
      
      
        if(notifications2[0]['status'] == 'cancelled'){
           widget.openMainMessageListener();
        showNotification(); 


        //Hit an API Here to show the ride was cancelled on notification page


        widget.deleteCallBack(widget.index);
        showMap = false;
             Future.delayed(Duration(seconds: 1), () {
    
        Get.back();
  });
        }
       
        //notifications2 =[];
      
       else if(notifications2[0]['status'] == 'accepted'){
        loading =false;
        showTimer = true;
       _startTimer();
       print(notifications2[0]['verificationCode']);
        verificationCode = (notifications2[0]['verificationCode']??'code').toString();
       notifications2.clear();
       //setState(() {
        
       //});
      
       launchGoogleMaps(
        double.parse(widget.sourceLatitude),
        double.parse(widget.sourceLongitude),
        double.parse(widget.destinationLatitude),
        double.parse(widget.destinationLongitude)
        );
      }
       }
      });
      
    // TODO: implement initState
    super.initState();
  }
  void launchGoogleMaps(double sourceLat, double sourceLng, double destLat, double destLng) async {
  String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&origin=$sourceLat,$sourceLng&destination=$destLat,$destLng&travelmode=driving";

  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not launch Google Maps';
  }
}
  Future<void> showNotification() async {
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
      'The Ride was cancelled by the user',
      notificationDetails);
  }
  catch(e){
    print("The error is"+e.toString());
  }
}
  
  List<LatLng> _routeCoordinates1 = [];
    List<LatLng> _routeCoordinates2 = [];
   Future<void> getRoute1() async {
  final directions = GoogleMapsDirections(
    apiKey: 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0',
  );
  final directionsResponse = await directions.directionsWithLocation(
    Location(lat:widget.driverLatitude,lng:widget.driverLongitude),
    Location(lat:double.parse( widget.sourceLatitude),lng:double.parse( widget.sourceLongitude)),
  );
  print("The direction response is");
  print(directionsResponse);
  if (directionsResponse.isOkay) {
    final route = directionsResponse.routes.first;
    setState(() {
      _routeCoordinates1.clear();
      print("route leg is");
      print(route.legs[0].steps);
      for (final step in route.legs[0].steps){
        print("route");
        _routeCoordinates1.add(LatLng(step.startLocation.lat, step.startLocation.lng));
        //print(_routeCoordinates1);
      }
    });
  }
}
   Future<void> getRoute2() async {
  final directions = GoogleMapsDirections(
    apiKey: 'AIzaSyBV7ECMpja47Pu0shoRXUMUAPYY2CSX8n0',
  );
  final directionsResponse = await directions.directionsWithLocation(
    Location(lat:double.parse( widget.sourceLatitude),lng:double.parse( widget.sourceLongitude)),
    Location(lat:double.parse( widget.destinationLatitude),lng:double.parse( widget.destinationLongitude)),
  );
  print("The direction response is");
  print(directionsResponse);
  if (directionsResponse.isOkay) {
    final route = directionsResponse.routes.first;
    setState(() {
      _routeCoordinates2.clear();
      print("route leg is");
      print(route.legs[0].steps);
      for (final step in route.legs[0].steps){
        print("route");
        _routeCoordinates2.add(LatLng(step.startLocation.lat, step.startLocation.lng));
        print(_routeCoordinates2);
      }
    });
  }
}
String token ='';
sendAcceptRequest()async{

    await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('TOken $value');
              token = value.toString();
            });
          });
  //}
  print("the token is $token");
  try{ 
        SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fullname =  prefs.getString('fullname');
      String? phoneNo =  prefs.getString('phoneno');
      String? driver_address =  prefs.getString('driver_address');
      int increase =0;

      if(amountIndex ==0){
        increase =0;
      }
      else if(amountIndex ==1){
        increase =5;
      }
      else if(amountIndex ==2){
        increase =10;
      }
      else if(amountIndex ==3){
        increase =15;
      }
      print("the increase is");
      print(increase);
      String time  = '5 min';
      if(timerIndex ==0){
        time = '3 min';
      }
      else if(timerIndex ==1){
        time = '5 min';
      }
      else if(timerIndex ==2){
        time = '10 min';
      }
      else if(timerIndex ==3){
        time = '20 min';
      }
       String? driver_id = prefs.getString('driverId');
      String amount = "Rs. "+(int.parse(widget.amount.replaceAll("Rs. ", ""))+increase).toString();
      print("The amount is"+amount);
      var data = {
      'to' : widget.customerPlayerId,
      'priority': 'high',
      'notification': {
      'title': 'test',
      'body': 'test',
      },
      'data':{
        'status':'driver ride request',
        "rate":amount,
        "driver_name": fullname,
        "driver_rating":'5',
        "address":driver_address,
        "phoneno":phoneNo,
        'driverPlayerId':token,
        'fromLocation':widget.sourceLocation,
        'toLocation':widget.destinationLocation,
        'time':time,
        'distance': (driverDistance.toStringAsFixed(3)).toString()+ " Km",
        'driver_id':driver_id,
        'plate_no':vehicleNumber,
        'driverProfileUrl':driverProfileUrl
      }
      };
      
      print("posting Datas to"); 
      print(data);
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode (data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
    setState(() {
      listen = true;
    });
    }
    catch(e){
      print("Error Occured");
    }
}

sendRideCompleteRequest()async{
  setState(() {
    loading = true;
  });
    await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('TOken $value');
              token = value.toString();
            });
          });
  //}
  print("the token is $token");
  try{ 
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fullname =  prefs.getString('fullname');
      String? phoneNo =  prefs.getString('phoneno');
      String? driver_address =  prefs.getString('driver_address');
      String? driver_id = prefs.getString('driverId');
      int increase =0;
      var data = {
      'to' : widget.customerPlayerId,
      'priority': 'high',
      'notification': {
      'title': 'test',
      'body': 'test',
      },
      'data':{
        "status":"ride completed",
        "rate":widget.amount,
        "driver_name": fullname,
        "driver_rating":'5',
        "address":driver_address,
        "phoneno":phoneNo,
        'driverPlayerId':token,
        'fromLocation':widget.sourceLocation,
        'toLocation':widget.destinationLocation,
        'distance': widget.distance,
        'driver_id':driver_id
      }
      };
      
      print("posting Datas to"); 
      print(data);
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode (data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
    Fluttertoast.showToast(
      msg: "Review Request Was Sent",
      toastLength: Toast.LENGTH_SHORT, // Duration of the toast
      gravity: ToastGravity.BOTTOM, // Position of the toast
      timeInSecForIosWeb: 1, // Time duration in seconds for iOS (Web ignored)
      backgroundColor: Colors.black, // Background color of the toast
      textColor: Colors.white, // Text color of the toast
      fontSize: 16.0, // Font size of the toast message
    );
    setState(() {
      listen = true;
      loading = false;
    });
    }
    catch(e){
      print("Error Occured");
    }


}
bool listen = true;
late Timer _timer;
  int _totalSeconds = 300;
  
   bool _isTimerInitialized = false; 
   bool canReceivePayment = false;
void _startTimer() {
  if(timerIndex==0){
    _totalSeconds=3*60;
  }
  else if(timerIndex==1){
    _totalSeconds=5*60;
  }
  else if(timerIndex==2){
    _totalSeconds=10*60;
  }
  else if(timerIndex==3){
    _totalSeconds=20*60;
  }

    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        _isTimerInitialized = true; 
        if (_totalSeconds > 0) {
          _totalSeconds--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }
  String _formatTime() {
    final minutes = (_totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_totalSeconds % 60).toString().padLeft(2, '0');
    if(minutes == '0' && seconds == '0'){
      setState(() {
        canReceivePayment = true;
      });
    }
    return '$minutes:$seconds';
  }
  @override
  void dispose() {
    messageSubscription?.cancel();
    
    if(_isTimerInitialized == true){
      widget.clearNotifications();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    }
    super.dispose();
  }
bool  showBottomSheet = true;
bool showMap = true;
bool loading=false;
bool showTimer =false;
  //List notifications = [];
  List notifications2 =[];
  List notificationIds = [];
  StreamSubscription<RemoteMessage>? messageSubscription;
  Map<String, Marker> _markers={};
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
      mipmaps: false
    );
  }
  setMakers(){
    LatLng position = LatLng(double.parse(widget.sourceLatitude), double.parse(widget.sourceLongitude));
     final MarkerId markerId = MarkerId(position.toString());
   Marker marker = Marker(
      markerId: markerId,
      position: position,
     icon:sourceCustomIcon!,
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
    LatLng position2 = LatLng(double.parse(widget.destinationLatitude), double.parse(widget.destinationLongitude));
     final MarkerId markerId2 = MarkerId(position2.toString());
   Marker marker2 = Marker(
      markerId: markerId2,
      position: position2,
     icon:destinationCustomIcon!,
      infoWindow: InfoWindow(
        title: 'Marker Title',
        snippet: 'Marker Snippet',
      ),
    );
    Map<String, Marker> markerValue2 ={
      '$markerId2':marker2
    };
    setState(() {
      _markers.addAll(markerValue2);
    });
  }

  int amountIndex =0;
  int timerIndex = 0;
  GoogleMapController? _mapController;
  void _launchPhoneCall(String phoneNumber) async {
  final url = "tel:$phoneNumber";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
callback(){
  setState(() {
    loading = false;
  });
}
void _showComplaintDialog() {
  TextEditingController complaint = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('File Complaint?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Write your issue here',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: complaint,
                ),
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
                    child: Text('Back'),
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
                    child: Text('Submit'),
                    onPressed: () async{
                      // Navigator.of(context).pop(); 
                      print("The tCode is"+verificationCode);
                      DriverIssueRepository repo = DriverIssueRepository();
                      DriverIssueResponse response = await repo.updateDriverIssue(verificationCode, complaint.text);                      // CompleteRideByDriverRepository repo = CompleteRideByDriverRepository();
                      // CompleteRideByDriverResponse response = await repo.CompleteRideByDriver('AEMJuM4y5P');  
                      var data = jsonDecode(response.body);
                       Get.back();
                      if(data['message'] =="Sale cancelled successfully"){
                         
                        Fluttertoast.showToast(
      msg: 'Complaint reported',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Get.back();
                      //   widget.openMainMessageListener();
                      // sendRideCompleteRequest();
                      // widget.deleteCallBack(widget.index);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pop();

                      }
                      
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
 
void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ride Complete ?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Ride Complete Implies that you have received your payment and the ride sharing was complete',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
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
                    child: Text('File Complaint'),
                    onPressed: () {
                      _showComplaintDialog();
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Confirm'),
                    onPressed: () async{
                      CompleteRideByDriverRepository repo = CompleteRideByDriverRepository();
                      CompleteRideByDriverResponse response = await repo.CompleteRideByDriver(verificationCode);  
                      var data = jsonDecode(response.body);
                      print(data);
                      widget.openMainMessageListener();
                      sendRideCompleteRequest();
                      widget.deleteCallBack(widget.index);
                      Navigator.of(context).pop();
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

 void _showCancelDialogBox() {
   TextEditingController cancelReason = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cancel',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Reason to cancel the ride ?',style: TextStyle(fontSize: 14),),
                 TextField(
                  controller: cancelReason,
                ),
                
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
                      if(cancelReason.text == ''){
                        Fluttertoast.showToast(
                    msg: 'Please mention your reason',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                      }
                      else{
                        CancelRideShareByDriverRepository repo =CancelRideShareByDriverRepository();
                         CancelRideShareByDriverResponse response = await repo.CancelRideShareByDriver(verificationCode, cancelReason.text); 
                        var data =jsonDecode(response.body);
                        if(data['message']=="Sale cancelled successfully"){
                                                widget.openMainMessageListener();
                       widget.deleteCallBack(widget.index);
                      setState(() {
                        showMap = false;
                      }); 
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fullname =  prefs.getString('fullname');
      String? phoneNo =  prefs.getString('phoneno');
      String? driver_address =  prefs.getString('driver_address');
      String? driver_id = prefs.getString('driverId');
                      var data = {
      'to' : widget.customerPlayerId,
      'priority': 'high',
      'notification': {
      'title': 'test',
      'body': 'test',
      },
      'data':{
        'status':'cancelled',
        "driver_name": fullname,
        "driver_rating":'5',
        "address":driver_address,
        'driver_id':driver_id
      }
      };
      
      print("posting Datas to"); 
      print(data);
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode (data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
                  Fluttertoast.showToast(
                    msg: 'The ride was cancelled',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  
                      Navigator.of(context).pop(); 
                      Get.back();
                        }
                        else{
                          Fluttertoast.showToast(
                    msg: 'Error Occured',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                        }
                    

                  
                        }
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Stack(
        children:[
            Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.black,
            onPressed: (){
              if(showTimer == false){
                 setState(() {
              loading = true;
              });
              widget.openMainMessageListener();
               Future.delayed(Duration(seconds: 2), (){
                setState(() {
                  showMap =false;
                });
                Get.back();
               });
              }
              else{
                 _showCancelDialogBox();
              }
             
            },),
            title: Text("Ride Request",style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Stack(
            children: [
              showMap?GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(widget.destinationLatitude), double.parse(widget.destinationLongitude)),
                      zoom: 15.0, 
                      tilt: 0, 
                      bearing: 0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                                   _mapController = controller;
                                  },
                                  myLocationEnabled: true,
                                  onCameraMove: (CameraPosition position){
                                    setState(() {
                                   // latitude = position.target.latitude;
                                    //longitude = position.target.longitude;
                                    showBottomSheet = false;
                                   });
                                  },
                                  onCameraIdle: (){
                                     Future.delayed(Duration(milliseconds: 350), () {
                                      setState(() {
                                    showBottomSheet = true;
                                   });
                                     });
                                    
                                  },
                                  polylines: {
                                    maps.Polyline(
                                      width: 4,
                                      polylineId: PolylineId('route1'),
                                      color: Colors.blue,
                                    points: _routeCoordinates1,
                                  ),
                                  maps.Polyline(
                                      width: 4,
                                      polylineId: PolylineId('route2'),
                                      color: Colours.primarygreen,
                                    points: _routeCoordinates2,
                                  )
                                  },
                                  markers:  _markers.values.toSet(),
                                ):Container(),
            showTimer?Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width/3,
                  height: 70,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text('${_formatTime()}',
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ):Container()
            ],
          ),
          bottomSheet: showBottomSheet ? Container(
            height: showTimer ? 330: 310,
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                       SizedBox(
                        width: 10,
                      ),
                      ClipOval(child: Container(
                        height: 60,width: 60
                        ,child: widget.userProfileUrl.toString() =='null'?
                        Image.asset('assets/rideshare/person.jpg',fit: BoxFit.cover,):
                        Image.network(widget.userProfileUrl,fit: BoxFit.cover,))
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/rideshare/markerA.png',
                              width: 20,
                              height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            Container(
                              width: Get.width/2,
                              child: Text(widget.sourceLocation,
                              maxLines: 1,)),
                              
                          ],
                        ),
                          Row(
                            children: [
                              Image.asset('assets/rideshare/markerB.png',
                              width: 20,
                              height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                              width: Get.width/2,
                              child: Text(widget.destinationLocation,
                              maxLines: 1,)),
                            ],
                          ),
                        // Text(widget.destinationLocation),
                        Text(widget.amount,style: TextStyle(color: Colours.primarygreen,fontSize: 20),)
                      ],),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          showTimer ? _launchPhoneCall(widget.phoneNo):(){};
                        },
                        child: ClipOval(
                          child: Container(
                            color: showTimer ? Colours.primarygreen:Colors.grey,
                            width: 50,
                            height: 50,
                            child: Icon(Icons.phone,color: Colors.white,size: 30,)),
                        ),
                      ),
                     
                      
                    ],),
                  ),
                ),
              ),
                SizedBox(
                  width: 10,
                ),
               Column(
                children: [
                   SizedBox(
                  height: 10,
                ),
                  Row(children: [
                   SizedBox(
                  width: 10,
                ),
                    Container(
                      width: Get.width/4.0,
                      child: Text("Your offer:")),
                    Container(
                      padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: amountIndex == 0 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      child: GestureDetector(
                        onTap:(){
                          setState(() {
                            if(showTimer == false){
                              amountIndex =0;
                            }
                          });
                        },
                        child:Text(widget.amount,
                        style: TextStyle(color:amountIndex == 0 ? Colors.white:Colors.black),
                        ),
                        ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: amountIndex == 1 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: GestureDetector(
                        onTap:(){
                          setState(() {
                            if(showTimer == false){
                              amountIndex =1;
                            }
                          });
                        },
                        child:Text("Rs. "+(int.parse(widget.amount.replaceAll("Rs. ", ""))+5).toString(),
                        style: TextStyle(color:amountIndex == 1 ? Colors.white:Colors.black),),
                        ),
                      ),
                      SizedBox(
                      width: 5,
                    ),
                      Container(
                         padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: amountIndex == 2 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: GestureDetector(
                        onTap:(){
                          setState(() {
                             if(showTimer == false){
                              amountIndex =2;
                            }
                          });
                        },
                        child:Text("Rs. "+(int.parse(widget.amount.replaceAll("Rs. ", ""))+10).toString(),
                         style: TextStyle(color:amountIndex == 2 ? Colors.white:Colors.black),),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                         padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: amountIndex == 3 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: GestureDetector(
                        onTap:(){
                          setState(() {
                            if(showTimer == false){
                              amountIndex =3;
                            }
                          });
                        },
                        child:Text("Rs. "+(int.parse(widget.amount.replaceAll("Rs. ", ""))+15).toString(),
                         style: TextStyle(color:amountIndex == 3 ? Colors.white:Colors.black),),
                        ),
                      ),
                  ],),
                  SizedBox(
                  height: 10,
                ),
                  Row(children: [
                    SizedBox(
                  width: 10,
                ),
                    Container(
                      width: Get.width/4.0,
                      child: Text("Your arrival time:")),
                    Container(
                        padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: timerIndex ==0 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap:(){
                          setState(() {
                            if(showTimer == false){
                              timerIndex =0;
                            }
                          });
                        },
                        child:Text("3 min",
                        style: TextStyle(color:timerIndex == 0 ? Colors.white:Colors.black),
                        ),
                        ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                      Container(
                         padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: timerIndex ==1 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: GestureDetector(
                        onTap:(){
                           setState(() {
                            if(showTimer == false){
                              timerIndex =1;
                            }
                          });
                        },
                        child:Text("5 min",
                        style: TextStyle(color:timerIndex == 1 ? Colors.white:Colors.black),),
                        
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: timerIndex ==2 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: GestureDetector(
                        onTap:(){
                           setState(() {
                             if(showTimer == false){
                              timerIndex =2;
                            }
                          });
                        },
                        child:Text("10 min",
                         style: TextStyle(color:timerIndex == 2 ? Colors.white:Colors.black),),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                         padding: EdgeInsets.fromLTRB(8,5,8,5),
                      decoration: BoxDecoration(
                        color: timerIndex ==3 ? Colours.primarygreen:Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                        child: GestureDetector(
                        onTap:(){
                           setState(() {
                             if(showTimer == false){
                              timerIndex =3;
                            }
                          });
                        },
                        child:Text("20 min",
                         style: TextStyle(color:timerIndex == 3 ? Colors.white:Colors.black),),
                        ),
                      ),
                  ],)
                ],),
                 SizedBox(
                  height: showTimer == false ? 30:10,
                ),
                showTimer == false ? GestureDetector(
                  onTap: (){
                    setState(() {
                      loading=true;
                      listen = true;
                    });
                    sendAcceptRequest();
                  },
                  child: Container(child: 
                  Center(child: Text("Submit",style: TextStyle(color: Colors.white),))
                  ,height: 40,
                  width: Get.width-20,
                  color: Colours.primarygreen,),
                ):Container(),
                showTimer ==true?GestureDetector(
                  onTap: (){
                    _showAlertDialog(context);
                  },
                  child: Container(child: 
                  Center(child: Text("Ride Complete ?",style: TextStyle(color: Colors.white),))
                  ,height: 40,
                  width: Get.width-20,
                  color: Colours.primarygreen,),
                ):Container(),
                SizedBox(
                  height: 10,
                ),
                showTimer ==true?GestureDetector(
                  onTap: (){
                    _showCancelDialogBox();
                  },
                  child: Container(child: 
                  Center(child: Text("Cancel Ride ?",style: TextStyle(color: Colors.white),))
                  ,height: 40,
                  width: Get.width-20,
                  color: Colors.red,),
                ):Container(),
            ]),
          ):null
        ),
            loading ? RideShareLoader(callback: callback,):Container(),
        ] 
      ),
    );
  }
}

