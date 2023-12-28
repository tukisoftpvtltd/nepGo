import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/User/Controller/Functions/capitalize.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Components/MyDrawer.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../Controller/bloc/RequestHistory/bloc/request_history_bloc.dart';
import '../../Controller/repository/getDriverDetails.dart';
import '../../Model/DriverDetailModel.dart';
import '../components/order_container.dart';
import '../components/size_config.dart';
import '../constants/colors.dart';
import 'IncomeHistoryPage.dart';
import 'RideShareOrderContainer.dart';
import 'notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';

class RideShareHome extends StatefulWidget {
  List notifications;
  List notificationsIds;
  double driverLatitude;
  double driverLongitude;
  GlobalKey<ScaffoldState> mainScaffold;
  bool mainMessageListener;
  Function closeMainMessageListener;
   Function openMainMessageListener;
   Function deleteCallBack;
   bool scrollabel;
   ScrollController scrollController;
   Function clearNotifications;
  RideShareHome({super.key,
  required this.notifications,
  required this.notificationsIds,
  required this.mainScaffold,
  required this.driverLatitude,
  required this.driverLongitude,
  required this.mainMessageListener,
  required this.closeMainMessageListener,
  required this.openMainMessageListener,
  required this.deleteCallBack,
  required this.scrollabel,
  required this.scrollController,
  required this.clearNotifications
  });

  @override
  State<RideShareHome> createState() => _RideShareHomeState();
}

class _RideShareHomeState extends State<RideShareHome> {
  bool isApproved  = false;
  
  List<Map<String, dynamic>> notifications = [];
  String? did='';
   getDriverId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    did = prefs.getString('driverId');
   }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
int count =0;
DriverDetailModel? model;

  getDriverDetail()async{
   
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   if(model!.driverDetails!.approved.toString() =='0'){
    setState(() {
      isApproved = false;
    });
    widget.closeMainMessageListener();
    
    print("Not Approved");
   }
   if(model!.driverDetails!.approved.toString() =='1'){
    setState(() {
      isApproved = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedBoolValue = await prefs.getBool('online');
    if(storedBoolValue == true){
      setState(() {
      _switchValue = storedBoolValue!;
      });
      widget.openMainMessageListener();
      
    }
    else{
      setState(() {
      _switchValue = storedBoolValue!;
      });
      widget.closeMainMessageListener();
    }
    print("Approved");
   }
  //  setState(() {
  //     loading= false;
  //   });
  }

@override
  void initState() {
    getDriverId();
    getDriverDetail();
    widget.scrollController = ScrollController();
    widget.scrollController.addListener(_scrollListener);
    
    // TODO: implement initState
    super.initState();
  }
  // deleteIndex(int index){
  //   print("delete Index");
  //   setState(() {
  //     widget.deleteCallBack(index);
  //   });
  // }
  deleteIndex(int index){
    setState(() {
          widget.notifications.removeAt(index);
    });
  }

  void _scrollListener() {
  if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward || widget.scrollController.position.userScrollDirection == ScrollDirection.reverse ) {
    widget.scrollabel = false;
    print("Scrolling ");
  } else{
    print("not scrolling");
   widget.scrollabel =true;
  }
}
//   scrollListToTop(){
//   try{
//      print("scrolling to the top");
//     // scrollabel ?
//     widget.scrollController.animateTo(
//       widget.scrollController.position.maxScrollExtent, // Scroll to the top (position 0)
//       duration: Duration(milliseconds: 500), // Adjust the duration as needed
//       curve: Curves.easeInOut, // Adjust the curve as needed
//     );
//     //:(){};
//   }
//   catch(e){
//     print(e.toString());
//   }
 
// }
  bool isOnlineValue = true;
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
        void _showAlertDialog() {
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
                Text('You must be verifed before going online',style: TextStyle(fontSize: 14),),
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
                    child: Text('Ok'),
                    onPressed: ()async {
                    setState(() {
                      isOnlineValue =false;
                    });
                    Get.back();
                      
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

    return WillPopScope(
      onWillPop: ()async{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading:GestureDetector(
            onTap: (){
              print("pressed");
              Get.to( NotificationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FaIcon(
                FontAwesomeIcons.bell,
                color: Colors.black,
                size: 25,
                
                ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(80,0,0,0),
            child: Text(
              'Mero Ato',
              style: TextStyle(
                  fontSize: SizeConfig(context).titleSize()-4,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
            actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu,
                    color: Colors.black,),
                    onPressed: () {
                      // Scaffold.of(context).openDrawer();
                      widget.mainScaffold.currentState?.openDrawer();
                      print("Open Drawer");
                    },
                  ),
                ],
        ),
        
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top:0),
              child: Column(
                children: [
                  Divider(),
                  Stack(
                    children: [
                      FlutterSwitch(
                      width: 130.0,
                      height: 45.0,
                      valueFontSize: 10.0,
                      toggleSize: 30.0,
                      value: _switchValue,
                      borderRadius: 30.0,
                      padding: 8.0,
                      activeColor: Color.fromARGB(255, 178, 253, 204),
                      inactiveColor: Color.fromARGB(255, 252, 160, 160),
                      activeText: 'On',
                      inactiveText: 'Off',
                      toggleColor: Colors.white,
                      activeTextColor: Colors.black,
                      inactiveTextColor: Colors.black,
                      onToggle: (value) async{
            if(isApproved== false){
              widget.closeMainMessageListener();
              _showAlertDialog();
            }
            else {
              setState(() {
              _switchValue = value;
            });
            if(_switchValue == true){
             SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.setBool('online', _switchValue);
            widget.openMainMessageListener();
            }
            else{
              SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.setBool('online', _switchValue);
              widget.closeMainMessageListener();
            }
            }
      },
    ),
    !_switchValue?
    Padding(
      padding: const EdgeInsets.fromLTRB(30,10,0,0),
      child: Center(child: Text("Offline",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
    ):
    Padding(
      padding: const EdgeInsets.fromLTRB(0,10,30,0),
      child: Center(child: Text("Online",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
    )

                    ],
                  ),
        //           Switch(
        //   value: _switchValue,
        //   onChanged: (value) {
        
            
        //   },
        // ),
                  // LiteRollingSwitch(
                  //   value: isOnlineValue,
                  //                      textOn: "Online",
                  //                      textOff: "Offline",
                  //                      colorOn: Color.fromARGB(255, 178, 253, 204),
                  //                      colorOff: Color.fromARGB(255, 252, 160, 160),
                  //                      iconOn: Icons.done,
                  //                      iconOff: FontAwesomeIcons.minus,
                  //                      textSize: 16.0,
                  //                      textOnColor: Colors.black,
                  //                      textOffColor: Colors.black,
                  //                      width: 150,
                  //                      onChanged: 
                  //                      (bool position)async {
                  //                       // print(position);
                  //                       // setState(() {
                  //                       //   isOnlineValue =false;
                  //                       // });
                  //                       position ==true?
                  //                       _showAlertDialog():(){};
                                        
                  //                     //  print("The button is $position");
                  //                     //  setState(() {
                  //                     //    isOnlineValue = position;
                  //                     //  });
                  //                     //   SharedPreferences prefs = await SharedPreferences.getInstance();
                  //                     //  await prefs.setBool('online', position);
                  //                     //  position == true ?
                  //                     //  _showAlertDialog():Container();
                  //                     //  setState(() {
                  //                     //    isOnlineValue = position;
                  //                     //  });
                  //                     //  if(position ==false){
                  //                     //   widget.closeMainMessageListener();
                  //                     //  }
                  //                     //  if(position==true){
                  //                     //   widget.openMainMessageListener();
                  //                     //  }
                                       
                  //                      },
                  //                       onDoubleTap: (){
                  //                         return true;
                  //                       }, onSwipe: (){
                  //                         return true;
                  //                       }, onTap: (){
                  //                         return true;
                  //                       },
                  //                      ),
                    Divider(),
                  widget.notifications.length ==0?
                  Container(
                    height: Get.height-170,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                     
                        SizedBox(
                          height: 150,
                        ),
                        Container(
                          height: 200,
                          width: 200,
                          child: Opacity(
                            opacity: 0.5,
                            child: Image.asset('assets/rideshare/animation2white.gif',
                            fit: BoxFit.cover,))),
                          SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade500,
                          highlightColor: Colors.grey.shade300,
                          child: Center(child: Text("Finding Passengers...."))),
                      ],
                    ),
                  ):
                  
                    RefreshIndicator(
                      onRefresh: ()async{
                        
                      },
                      child: SingleChildScrollView(
                        child: Container(
                          height: widget.notifications.length ==1 ?SizeConfig(context).containerHeight()-Get.height/11+20 :
                          widget.notifications.length ==2 ? 2*(SizeConfig(context).containerHeight()-Get.height/11)+20 :
                          Get.height-250,
                          child: NotificationListener<ScrollNotification>(
                                 onNotification: (scrollNotification) {
                                  if (scrollNotification is ScrollEndNotification) {
                                    
                                    print('Scrolling ended');
                                    setState(() {
                                      
                                      widget.scrollabel = true;
                                    });
                                  }
                                  return false;
                                },
                                child: ListView.builder(
                              reverse: true,
                              itemCount: widget.notifications.length,
                              shrinkWrap: true,
                              addAutomaticKeepAlives: true,
                            controller: widget.scrollController,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                  ),
                                  child: RideShareOrderContainer(
                                    notifications : widget.notifications,
                                    index :index,
                                    passengerName:  capitalize(widget.notifications[index]['passengerName'] ?? 'N/A'.toString()??'N/A') ,
                                    phoneNo:  capitalize(widget.notifications[index]['phoneNo'] ?? 'N/A'.toString()??'N/A') ,
                                    totalAmount:  widget.notifications[index]['amount'] ?? 'N/A'.toString(),
                                    fromLocation: capitalize(widget.notifications[index]['fromLocation']??'N/A'.toString()) ,
                                    toLocation: capitalize(widget.notifications[index]['tolocation']??'N/A'.toString()),
                                    itemName1: capitalize(widget.notifications[index]['item1']??'N/A').toString(),
                                    itemQuantity1: (widget.notifications[index]['quantity1'] ?? 'N/A').toString(),
                                     itemName2: capitalize(widget.notifications[index]['item2']??'N/A').toString(),
                                    itemQuantity2: (widget.notifications[index]['quantity2']??'N/A').toString(),
                                    tCode:(widget.notifications[index]['tCode']??'N/A').toString(),
                                    driverId:did??'0'.toString()!,
                                    logoUrl:(widget.notifications[index]['logoUrl']??'').toString(),
                                    distance:widget.notifications[index]['distance'] ?? 'N/A' ,
                                    customerPlayerId:widget.notifications[index]["customerPlayerId"] ?? 'N/A',
                                    sourceLatitude:widget.notifications[index]["sourceLatitude"] ?? '0.0',
                                    sourceLongitude:widget.notifications[index]["sourceLongitude"] ?? '0.0',
                                    destinationLatitude:widget.notifications[index]["destinationLatitude"] ?? '0.0',
                                    destinationLongitude:widget.notifications[index]["destinationLongitude"] ?? '0.0',
                                    driverLatitude:widget.driverLatitude,
                                    driverLongitude:widget.driverLongitude,
                                    mainMessageListener:widget.mainMessageListener,
                                    closeMainMessageListener:widget.closeMainMessageListener,
                                    openMainMessageListener:widget.openMainMessageListener,
                                    deleteCallback:deleteIndex,
                                    clearNotifications: widget.clearNotifications,
                                    userProfileUrl: widget.notifications[index]["userProfileUrl"].toString(),

                                  ),
                                );
                              }),
                              
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )),
          ),
        ),
        
      ),
    );
  }
}

// class SwitchButton extends StatefulWidget {
//   @override
//   _SwitchButtonState createState() => _SwitchButtonState();
// }

// class _SwitchButtonState extends State<SwitchButton> {
//   bool status = false;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }