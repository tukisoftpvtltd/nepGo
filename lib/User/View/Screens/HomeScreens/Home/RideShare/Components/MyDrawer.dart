import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Views/HelpAndSupport.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Views/RequestHistory.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Views/Settings.dart';
import 'package:get/get.dart';

import '../../../../../../../Driver/View/view/home_page.dart';
import '../../../../../constants/colors.dart';
import '../Views/FAQ.dart';
goToPassengerMode(){
  Get.back();
  Get.back();
  Get.back();
}
class MyDrawer extends StatefulWidget {
  bool? isDriver;
  bool showMap;
  bool loading;
  MyDrawer({super.key, this.isDriver,
  required this.showMap,
  required this.loading});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: ClipOval(
                            child: Container(
                              height: 80,
                              width: 80,
                              child: Image.asset('assets/rideshare/person.jpg',
                              fit: BoxFit.cover,)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: Text("Abiral Pokhrel",
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('City'),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Request History'),
                    onTap: () {
                      Get.to(RequestHistory());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                       Get.to(Settings());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('FAQ'),
                    onTap: () {
                       Get.to(FAQ());
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Help & Support'),
                    onTap: () {
                       Get.to(HelpAndSupport());
                    },
                  ),
                  widget.isDriver == true? 
                  ListTile(
                    leading: Icon(Icons.app_registration),
                    title: Text('Online Registration'),
                    onTap: () {
                       Get.to(HelpAndSupport());
                    },
                  ):Container(),

                  // SizedBox(
                  //   height: 260,
                  // ),
                  // Divider(),
                  
                  //  Padding(
                  //    padding: const EdgeInsets.fromLTRB(15,15,15,15),
                  //    child:GestureDetector(
                  //     onTap: (){
                        
                  //     //   Get.back();
                  //     //    Future.delayed(Duration(seconds: 2), () {
                  //     //     widget.showMap = false;
                  //     //     widget.loading =true;
                  //     //       Get.back();
                  //     //  });
                        
                  //     //  widget.isDriver == true ? goToPassengerMode()
                  //     //  : Get.to(HomePage(driver_type: '1',));
                  //     },
                  //      child: Container(
                  //       decoration: BoxDecoration(
                  //          borderRadius: BorderRadius.circular(12.0),
                  //          color: Colors.red,
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Center(
                  //           child: Text(
                  //             widget.isDriver == true ?
                  //             "Cancel Ride":
                  //             "Cancel Ride",
                  //           style: TextStyle(color: Colors.white),),
                  //         ),
                  //       ),
                        
                  //                    ),
                  //    ),
                  //  ),
                  
                  //  Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //    children: [
                  //     FaIcon(FontAwesomeIcons.facebook,color: Colors.blue,size: 40,),
                  //      FaIcon(FontAwesomeIcons.instagram,color: Colors.pinkAccent,size: 40,),
                  //    ],
                  //  ),
                ],
              ),
            ),
          );
  }
}

