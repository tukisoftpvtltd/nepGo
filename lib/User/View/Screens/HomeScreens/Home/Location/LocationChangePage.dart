import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../HomeScreensNavigation.dart';
import 'locationButton.dart';

class LocationChangePage extends StatefulWidget {
  Function? callback;
  String currentLocation;
  LatLng? position;
  bool? fromPayment;
  PageController? page;
  LocationChangePage({super.key,this.callback, required this.currentLocation,
   this.position,
  this.fromPayment,this.page});

  @override
  State<LocationChangePage> createState() => _LocationChangePageState();
}

class _LocationChangePageState extends State<LocationChangePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        
              Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: (){
              print("back");
              print(widget.callback);
              if(widget.callback != null){
                widget.callback!();
              }
               Get.back();
            },
          ),
          title: Text(
            "Delivery Location",
            style: TextStyle(color: Colors.black),
          ),
          actions: [],
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                    width: 200,
                    height: 200,
                    child:
                        Image.asset('assets/images/delivery boy on scooter.png')),
                LocationButton(
                  page:widget.page,
                  callback:widget.callback,
                  fromPayment : widget.fromPayment,
                  currentLocation: "${widget.currentLocation}",
                  centerPoint:widget.position!
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
