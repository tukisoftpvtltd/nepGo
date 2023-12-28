import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Location/MapPage3.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Location/MapScreen.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../Controller/bloc/map/bloc/map_bloc.dart';
import '../../../../constants/colors.dart';
import 'MapPage.dart';
import 'MapPage2.dart';

class LocationButton extends StatefulWidget {
  String currentLocation;
  bool? fromPayment;
  PageController? page;
  LatLng centerPoint;
  Function? callback;
  LocationButton({
    super.key,
    required this.currentLocation,
    this.fromPayment,
    this.page,
    this.callback,
    required this.centerPoint,
  });

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 0.5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Where should we deliver your order?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colours.primarygreen,
                size: 30,
              ),
              Container(
                width: 250,
                child: Text(
                  "${widget.currentLocation}",
                ),
              )
            ],
          ),
          Container(
            width: 250,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if(widget.page == null){
                  Get.to(() => BlocProvider(
                      create: (context) => MapBloc(),
                      child:
                      MapPage3(
                        callback: widget.callback,
                        fromPayment: widget.fromPayment,
                        centerPoint: widget.centerPoint,
                      ),
                      //  MapPage(
                        
                      //   fromPayment: widget.fromPayment,),
                    ));
                }
                else{
                     widget.page?.animateToPage(
            1,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
                }
                
              },
              child: Text("Change Location"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colours.primarygreen),
              ),
            ),
          ),
        ],
      ),
    );
  
  }
}
