import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Views/HelpAndSupport.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Views/Settings.dart';
import 'package:get/get.dart';


import '../../Controller/repository/getDriverDetails.dart';
import '../../Model/DriverDetailModel.dart';
import '../constants/Constants.dart';
import 'FAQ.dart';
import 'RequestHistory/DriverRequestHistory.dart';
goToPassengerMode(){
  Get.back();
  Get.back();
  Get.back();
}
class MyDrawer extends StatefulWidget {
  bool? isDriver;
  String fullname;
  MyDrawer({super.key, this.isDriver,required this.fullname});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
   bool loading =true;
  DriverDetailModel? model;
  getDriverDetail()async{
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   setState(() {
      loading= false;
    });
  }

  @override
  void initState() {
    getDriverDetail();
    // TODO: implement initState
    super.initState();
  }
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
                          child: loading ==true || model!.driverDetails!.profileImage.toString() == "null" ? 
                          ClipOval(
                    child: Container(
                                height: 80,
                                width: 80,
                                child:  Image.asset(
                                  'assets/images/imageLoader.png',
                                  fit: BoxFit.cover,
                                ),
                                
                              //   Image.network('$baseUrl/driverimages/${widget.citizenship}',
                              //   fit: BoxFit.cover,),
                               ),):  ClipOval(
                    child: Container(
                                height: 80,
                                width: 80,
                                child:  FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/imageLoader.png',
                                  image: '$baseUrl/driverimages/${model!.driverDetails!.profileImage}',
                                  fit: BoxFit.cover,
                                ),
                                
                              //   Image.network('$baseUrl/driverimages/${widget.citizenship}',
                              //   fit: BoxFit.cover,),
                               ),
                  )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,0,0,0),
                          child: Text(widget.fullname.toString(),
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
                      Get.to(DriverRequestHistory());
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

                ],
              ),
            ),
          );
  }
}

