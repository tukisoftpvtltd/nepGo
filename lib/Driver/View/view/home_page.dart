import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/Driver/Controller/repository/postDriverLocation.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:food_app/Driver/View/view/IncomeHistoryPage.dart';
import 'package:food_app/Driver/View/view/RiddeShareHome.dart';
import 'package:food_app/Driver/View/view/reviews.dart';
import 'package:food_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/bloc/Deliveries/deliveries_bloc.dart';
import '../../Controller/bloc/RequestHistory/bloc/request_history_bloc.dart';
import 'MyDrawer.dart';
import 'QRScanningPage.dart';
import 'home.dart';
import 'my_deliveries.dart';
import 'notifications.dart';
import 'profile.dart';
 late ScrollController _scrollController;
 bool scrollabel = true;
class HomePage extends StatefulWidget {
  String driver_type;

  HomePage({
    super.key,
    required this.driver_type,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int currentIndex = 0;
  bool Switch = false;
  _switchTabBar() {
    setState(() {
      Switch = !Switch;
    });
  }

  _goToSearchScreen() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Container()));
  }

  String token = '';
  getPlayerId() async {
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
        print('TOken$value');
        token = value.toString();
      });
    });
    //}
    String playerId = token!;
    print("Your player id is");
    print(playerId);
  }

// }
//  @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);

//     // Check if the app is coming to the foreground
//     if (state == AppLifecycleState.resumed) {
//       _refreshJournals();
//       // Add your logic here when the app comes to the foreground
//     }
//   }

  // void _refreshJournals() async {

  //   final data = await SQLHelper.getItems();
  //   try{
  //     setState(() {
  //     notifications= data;
  //   });
  //   }
  //   catch(e){
  //     print(e.toString());
  //   }

  // }
  //   void _deleteItem(int id) async {
  //   await SQLHelper.deleteItem(id);
  //   print('Successfully deleted a journal!');
  //   _refreshJournals();
  // }
  // deleteCallBack(int index){
  //   print("Delete Callback");
  //   _deleteItem(notifications[index]['id']);
  // }
  deleteCallBack() {}

  double driverLatitude = 0.0;
  double driverLongitude = 0.0;
  updateDriverLocation() async {
    try {
      DriverLocation repo = DriverLocation();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? did = prefs.getString('driverId');
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        driverLatitude = position.latitude;
        driverLongitude = position.longitude;
      });
      String lat = position.latitude.toString();
      String long = position.longitude.toString();
      print("the driver location is");
      print(did);
      print(lat);
      print(long);
      repo.PostDriverLocation(did!, lat, long);
    } catch (e) {
      print("The error is " + e.toString());
    }
  }

  int count = 0;
  List notifications = [];
  List notificationIds = [];
  StreamSubscription<RemoteMessage>? messageSubscription;
  bool mainMessageListener = true;
  //  Future<void> _addItem(
  //    String passengerName,
  // String phoneNo,
  // String amount,
  // String fromLocation,
  // String toLocation,
  // String item1,
  // String quantity1,
  // String item2,
  // String quantity2,
  // String tCode,
  // String logoUrl,
  // String distance,
  // String customerPlayerId,
  // String sourceLatitude,
  // String sourceLongitude,
  // String destinationLatitude,
  // String destinationLongitude,

  //   ) async {

  //   await SQLHelper.createItem(
  //         passengerName,
  // phoneNo,
  // amount,
  // fromLocation,
  // toLocation,
  // item1,
  // quantity1,
  // item2,
  // quantity2,
  // tCode,
  // logoUrl,
  // distance,
  // customerPlayerId,
  // sourceLatitude,
  // sourceLongitude,
  // destinationLatitude,
  // destinationLongitude
  // );
  // }
  // addDataToSql(){

  // }
  
scrollListToTop(){
  try{
     print("scroll called");
     print('Scrollable value is'+scrollabel.toString());
     scrollabel ?
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent+300, // Scroll to the top (position 0)
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the curve as needed
    ):(){};
  }
  catch(e){
    print(e.toString());
  }
 
}
List<String> userIdList=[];

  @override
  void initState() {
    _scrollController = ScrollController();
    // TODO: implement initState
    getPlayerId();
    updateDriverLocation();
    super.initState();
    getUserInformation();
    startTimer();
    WidgetsBinding.instance?.addObserver(this);
    if (mainMessageListener == true) {
      messageSubscription =
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        if (mainMessageListener == true) {
          print("The main Message Listener Value is" +
              mainMessageListener.toString());
            //  {passengerName: Abiral, sourceLatitude: 28.2225222, amount: Rs. 259, distance: 3.191Km, userId: 1, destinationLongitude: 83.9701268, phoneNo: 9866046607, sourceLongitude: 83.9854153, customerPlayerId: cxFg3C4oToCHu4T0_jfhKO:APA91bHKwmhbqX5DKrggwBeG3HKNKoUDit1yOm0_FIPlBYOU9DKvHa2UKXZUyEH6XScs4j4ue6GIasjpL_wZ82NZIPwmqA8ALCTpKY3eId2GIauogC-Ag-DjmgFvBXVjkDX-YPBYuIU1, tolocation: Damside, Pokhara, Nepal, fromLocation: 9 ,Chiple Dhunga Rd 9, category: Moto, destinationLatitude: 28.1971773, status: user ride request}
          //setState(() {
            final player = AudioPlayer();
            playNotification() {
              print("play sound");
              player.play(AssetSource('notification.wav'));
            }
            
           if(widget.driver_type =='0'&&message.data['status']!='cancel other delivery request'){
            playNotification();
            notifications.add(message.data);
            // print(messagae.data);
           }
            print(message.data);
            if(message.data['status'] == 'user ride request'){
               playNotification();
               notifications.add(message.data);
               print("The notification length is"+notifications.length.toString());
               if(notifications.length>2){
                scrollListToTop();
               }
               
            //    try{
            //   notifications.length != 1 ?  
            // :(){};
            //    }
            //    catch(e){
            //     print("Error is"+e.toString());
            //    }
            }
            if(message.data['status']=='cancel other delivery request'){
              print(notifications[0]['tCode']);
              print(message.data['verificationCode']);
                int indexToDelete = notifications.indexWhere(
      (notification) => notification["tCode"] == message.data['verificationCode'] );
      print("the index to delete is"+indexToDelete.toString());
    
              notifications.removeAt(indexToDelete);

            }
            if(message.data['status'] == 'rejected'){
              int indexToDelete = notifications.indexWhere(
      (notification) => notification["userId"] == message.data['userId'] );
      print("the index to delete is"+indexToDelete.toString());
              notifications.removeAt(indexToDelete);
              
               //playNotification();
            //    notifications.add(message.data);
            // scrollListToTop();
            }
           

//      List currentNotifications = [];
//    currentNotifications.add(message.data);
//      playNotification();
//      print(currentNotifications);
//       _addItem(
//         currentNotifications[0]['passengerName']?.toString() ?? 'N/A',
// currentNotifications[0]["phoneNo"]?.toString() ?? 'N/A',
// currentNotifications[0]["amount"]?.toString() ?? 'N/A',
// currentNotifications[0]["fromLocation"]?.toString() ?? 'N/A',
// currentNotifications[0]["toLocation"]?.toString() ?? 'N/A',
// currentNotifications[0]["item1"]?.toString() ?? 'N/A',
// currentNotifications[0]["quantity1"]?.toString() ?? 'N/A',
// currentNotifications[0]["item2"]?.toString() ?? 'N/A',
// currentNotifications[0]["quantity2"]?.toString() ?? 'N/A',
// currentNotifications[0]["tCode"]?.toString() ?? 'N/A',
// currentNotifications[0]["logoUrl"]?.toString() ?? 'N/A',
// currentNotifications[0]["distance"]?.toString() ?? 'N/A',
// currentNotifications[0]["customerPlayerId"]?.toString() ?? 'N/A',
// currentNotifications[0]["sourceLatitude"]?.toString() ?? 'N/A',
// currentNotifications[0]["sourceLongitude"]?.toString() ?? 'N/A',
// currentNotifications[0]["destinationLatitude"]?.toString() ?? 'N/A',
// currentNotifications[0]["destinationLongitude"]?.toString() ?? 'N/A',

//       );
         // });
        }
      });
    }
    // _refreshJournals();
  }

  closeMainMessageListener() {
    print("Main Messenger Closed");
    setState(() {
      mainMessageListener = false;
    });
  }

  openMainMessageListener() {
    print("Main Messenger OPENED");
    setState(() {
      mainMessageListener = true;
    });
  }

clearNotifications(){
  //setState(() {
  notifications = [];
  //});
}

  int _remainingTime = 1 * 60;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          print(_remainingTime);
        } else {
          updateDriverLocation();
          setState(() {
            _remainingTime = 1 * 60;
          });
          // _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    //messageSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  String fullname = '';
  String email = '';
  String phoneno = '';
  getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullname = prefs.getString('fullname') ?? '';
    email = prefs.getString('email') ?? '';
    phoneno = prefs.getString('phoneno') ?? '';
  }

  callback(String name, String mail, String phone) {
    print("hello123");
    print("the name is");
    print(name);
    setState(() {
      fullname = name;
      email = mail;
      phoneno = phone;
    });
  }

  GlobalKey<ScaffoldState> mainScaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screens = [
      widget.driver_type == "1"
          ? RideShareHome(
              notifications: notifications,
              notificationsIds: [],
              mainScaffold: mainScaffold,
              driverLatitude: driverLatitude,
              driverLongitude: driverLongitude,
              mainMessageListener: mainMessageListener,
              closeMainMessageListener: closeMainMessageListener,
              openMainMessageListener: openMainMessageListener,
              deleteCallBack: deleteCallBack,
              scrollabel:scrollabel,
              scrollController :_scrollController,
              clearNotifications:clearNotifications
              )
          : Home(
              notifications: notifications,
              notificationsIds: notificationIds,
            ),
      widget.driver_type == "1"?
      ReviewScreen()
      :NotificationScreen(),
      widget.driver_type == "1"
          ? BlocProvider(
              create: (context) => RequestHistoryBloc(),
              child: IncomeHistoryPage(),
            )
          : BlocProvider(
              create: (context) => DeliveriesBloc(),
              child: MyDeliveriesScreen(
                index: 0,
              ),
            ),
      DriverProfile(
        callback: callback,
        fullname: fullname,
        email: email,
        phoneno: phoneno,
        driver_type: widget.driver_type,
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            key: mainScaffold,
            drawer: MyDrawer(
              fullname:fullname,
            ),
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, widget.driver_type == "1" ? 0 : 30, 0),
                      child: Icon(
                        widget.driver_type == "1" ?Icons.reviews:Icons.notifications_active_outlined,
                      ),
                    ),
                    label: widget.driver_type == "1"
                        ? 'Reviews'
                        : 'Notifications                                   ',
                    backgroundColor: Colors.blue,
                  ),
                  widget.driver_type == "1"
                      ? BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Icon(FontAwesomeIcons.moneyBill),
                          ),
                          label: 'Income',
                          backgroundColor: Colors.blue,
                        )
                      : BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.fromLTRB(
                                widget.driver_type == "1" ? 0 : 35, 0, 0, 0),
                            child: Icon(Icons.bus_alert_outlined),
                          ),
                          label: widget.driver_type == "1"
                              ? 'Deliveries'
                              : '         Deliveries',
                          backgroundColor: Colors.blue,
                        ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_pin_circle_outlined,
                    ),
                    label: 'Account',
                    backgroundColor: Colors.red,
                  ),
                ]),
          ),
          widget.driver_type == "1"
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => QRScannerPage());
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colours.primarygreen,
                              height: 60,
                              width: 60,
                              child: Icon(
                                Icons.qr_code,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
