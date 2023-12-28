import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../Controller/bloc/RideShare/ride_share_bloc.dart';
import '../../../../../../Controller/repositories/get_nearby_driver.dart';
import '../../../../../../Controller/repositories/rideShare/cancelRideShareByUser.dart';
import '../../../../../../Controller/repositories/rideShare/userRideShareIssue/userRideShareIssue.dart';
import '../../../../../../Model/nearby_driver_model.dart';
import '../../../../../constants/colors.dart';
import '../../../../../widgets/button.dart';
import '../Fromlocation.dart';
import '../RideShare.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;
import '../Views/RideShareDriverPage.dart';

Color borderColor1 = Colours.primarygreen;
Color borderColor2 = Colors.grey;
Color borderColor3 = Colors.grey;
Color borderColor4 = Colors.grey;

// ignore: must_be_immutable
class MainBottomSheet extends StatefulWidget {
  Function findDriverCallBack;
  TextEditingController fromLocation;
  TextEditingController toLocation;
  TextEditingController fare;
  TextEditingController comment;
  Function getSourceLocation;
  Function getDestinationLocation;
  bool recommendPrice;
  Function recommendPriceCallback;
  double sourceLatitude;
  double sourceLongitude;
  double destinationLatitude;
  double destinationLongitude;
  bool orderAccepted;
  Function onOrderAccepted;
  String oADriverName;
  String oAAmount;
  String oATime;
  String oAPhoneNo;
  String oAPlateNo;
  String oAsourceLocation;
  String oAdestinationLocation;
  String oAVerificationCode;
  String oADriverProfileUrl;
  bool changeFirstBorderColor;
  bool changeSecondBorderColor;
  String recommendedFare;
  Function cancelCallBack;
  bool cash;
  Function cashCallBack;
  Function indexChecker;
  MainBottomSheet({
    Key? key,
    required this.findDriverCallBack,
    required this.fromLocation,
    required this.toLocation,
    required this.comment,
    required this.fare,
    required this.getSourceLocation,
    required this.getDestinationLocation,
    required this.recommendPrice,
    required this.recommendPriceCallback,
    required this.sourceLatitude,
    required this.sourceLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.orderAccepted,
    required this.onOrderAccepted,
    required this.oADriverName,
  required this.oAAmount,
  required this. oATime,
  required this. oAPhoneNo,
  required this. oAPlateNo,
  required this. oAsourceLocation,
  required this. oAdestinationLocation,
  required this.oAVerificationCode,
  required this.oADriverProfileUrl,
  required this.changeFirstBorderColor,
  required this.changeSecondBorderColor,
  required this.recommendedFare,
  required this.cancelCallBack,
  required this.cash,
  required this.cashCallBack,
  required this.indexChecker
  }) : super(key: key);

  @override
  State<MainBottomSheet> createState() => _MainBottomSheetState();
}

class _MainBottomSheetState extends State<MainBottomSheet> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
 
  orderHasBeenAccepeted(String driverPlayerId,String driverName,String amount,String time,
   String phoneNo,String plateNo, String sourceLocation,String destinationLocation){
      widget.findDriverCallBack();
      widget.onOrderAccepted(driverPlayerId, driverName, amount,  time,
     phoneNo,  plateNo,   sourceLocation,  destinationLocation);
  
  }
  TextEditingController myfare = TextEditingController();
  // @override
  // void dispose() {
  //   print("bottom sheet dispose");
  //   // TODO: implement dispose
  //   super.dispose();
  // }
     void _showOfferBottomSheet(BuildContext context1,Function fareCallback){
  FocusNode _focusNode = FocusNode();
   final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

    bool cash =true;
    showModalBottomSheet(
      context: context1,
      builder: (BuildContext context1) {
        FocusScope.of(Get.context!).requestFocus(_focusNode);
        _focusNode.addListener(() {
  if (!_focusNode.hasFocus) {
    //  Navigator.of(context1).pop();
  }
});
        return 
          StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return KeyboardVisibilityProvider(
                //controller: _keyboardVisibilityController,
                child: Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            child: Text("NPR.",
                            style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.w600),)),
                          Container(
                            width: 60,
                            child: TextField(
                              controller: myfare,
                              style: TextStyle(
                             fontSize: 20.0, // Set the text size here
                            ),
                              onSubmitted: (val){
                               // myfare.text = "Rs. "+val.toString();
                               // widget.fare.text = "Rs. "+val.toString();
                               fareCallback("Rs. "+val);
                                Get.back();
                              },
                              decoration: InputDecoration(
                   // labelText: 'Enter text',
                    labelStyle: TextStyle(
                      fontSize: 50.0, // Set the text size here
                    ),
                  ),
                              focusNode: _focusNode,
                              keyboardType: TextInputType.number, // Set the keyboard type to number
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // Accept only digits
                    ],
                            )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Specify a reasonable price"),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                           setState(() {
                            cash =true;
                            widget.cashCallBack(true);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,15,0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              border: Border.all(color:cash==true ? Colors.green:Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,0,20,0),
                                    child: Icon(FontAwesomeIcons.moneyBillWave,
                                    color: cash==true ? Colors.green:Colors.grey),
                                  ),
                                   Text("Cash"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                child: Icon(Icons.check_circle_outline_rounded,color: cash==true ? Colors.green:Colors.grey),
                              )
                            ],)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                           setState(() {
                            cash =false;
                            widget.cashCallBack(false);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,15,0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              border: Border.all(color:cash==false ? Colors.green:Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8.0,0,20,0),
                                    child: Icon(Icons.wallet,
                                    color: cash==false ? Colors.green:Colors.grey),
                                  ),
                                   Text("E-Wallet"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,20,0),
                                child: Icon(Icons.check_circle_outline_rounded,color: cash==false? Colors.green:Colors.grey),
                              )
                            ],)
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              );
            }
          );
      },
    );
  }
      void _showCommentBottomSheet(BuildContext context,Function CommentCallback){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: (){
                          setState(() {
                            ChildSheet = !ChildSheet;
                          });
                          print("Child Sheet");
                          
                        },
                        leading: Icon(
                          Icons.child_care),
                        title: Text("Child Seat"),
                        trailing: CupertinoSwitch(
                    value: ChildSheet,
                    onChanged: (value) {
                       setState(() {
                        ChildSheet =value;  
                      });
                    },
                  ),
            
                      ),
                      ListTile(
                        onTap: (){
                          setState(() {
                            passenger = !passenger;
                          });
                        },
                        leading: Icon(Icons.people),
                        title: Text("More than 4 passenger"),
                        trailing:CupertinoSwitch(
                    value: passenger,
                    onChanged: (value) {
                      setState(() {
                        passenger =value;  
                      });
                                    },
                  ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,0,15,10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Text("Close",style: TextStyle(color: Colors.red),)),

                            GestureDetector(
                              onTap: (){
                                String value = '';
                                if(ChildSheet == true){
                                  value += 'Child Sheet';
                                }
                                if(passenger == true){
                                  value += 'More than 4 Passenger';
                                }
                                if(ChildSheet == true && passenger ==true){
                                  value = "Child Sheet + More than 4 Passenger";

                                }
                                CommentCallback(value);
                                
                                Get.back();
                              },
                              child: Text("Submit",style: TextStyle(color: Colours.primarygreen),))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
          }
        );
      },
    );
  }
  
  double? sourceLat;
  double? sourceLong;
 
  callback1(String fromLocationValue,double sourceLatitude,double sourceLongitude){
         setState(() {
          sourceLat = sourceLatitude;
          sourceLong = sourceLongitude;
        widget.fromLocation.text = fromLocationValue;
        widget.changeFirstBorderColor  = true;
        print("The border Color is changed");
        widget.getSourceLocation(sourceLatitude,sourceLongitude);
        if(widget.toLocation.text != '' && widget.fromLocation.text !=''){
          // widget.recommendPriceCallback();
          // widget.fare.text = "Rs 170";
        }
          });
      }
  double? destinationLat;
  double? destinationLong;
 callback2(String toLocationValue,double destinationLatitude,double destinationLongitude){
  destinationLat = destinationLatitude;
  destinationLong = destinationLongitude;
        widget.toLocation.text = toLocationValue;
         widget.changeSecondBorderColor  = true;
         widget.getDestinationLocation(destinationLatitude,destinationLongitude);
        if(widget.toLocation.text != '' && widget.fromLocation.text !=''){
        //   setState(() {
        //   widget.recommendPriceCallback();
        // });
        // widget.fare.text = "Rs 170";
       
        }
        
      }
      // recommendPrice(){

      // }
      callback3(String price){
        // setState(() {
          widget.fare.text = price;
        // });
      }
      callback4(String commentValue){
        widget.comment.text = commentValue;
      }
      void makePhoneCall(String phoneno) async {
  String phoneNumber = 'tel:$phoneno'; // Replace with the phone number you want to call
  if (await canLaunch(phoneNumber)) {
    await launch(phoneNumber);
  } else {
    // Handle the case where the phone call cannot be initiated.
    print('Could not launch $phoneNumber');
  }
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
                      UserRideShareIssueRepository repo = UserRideShareIssueRepository();
                      UserRideShareIssueResponse response = await repo.updateUserRideShareIssue(widget.oAVerificationCode, complaint.text);                      // CompleteRideByDriverRepository repo = CompleteRideByDriverRepository();
                      // CompleteRideByDriverResponse response = await repo.CompleteRideByDriver('AEMJuM4y5P');  
                      var data = jsonDecode(response.body);
                      print(data);
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
                        // widget.openMainMessageListener();
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
            height: 180,
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
                    
                     
              SizedBox(
                width: 20,
              ),
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
                    CancelRideShareByUserRepository repo =CancelRideShareByUserRepository();
                    CancelRideShareByUserResponse response = await repo.CancelRideShareByUser(widget.oAVerificationCode, cancelReason.text);
                    print(response.body);
                    print(response.statusCode);
                    var data= jsonDecode( response.body);
                    if(data['message'] == "Sale cancelled successfully"){
                                 Fluttertoast.showToast(
                    msg: 'The ride was cancelled',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                    widget.cancelCallBack();
                      Navigator.of(context).pop();
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
  
  Widget build(BuildContext context) {
     
    return widget.orderAccepted ?
    Container(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
  //           String oADriverName;
  // String oAAmount;
  // String oATime;
  // String oAPhoneNo;
  // String oAPlateNo;
  // String oAsourceLocation;
  // String oAdestinationLocation;
          Padding(
            padding: const EdgeInsets.fromLTRB(15,20,15,15),
            child: Text('${widget.oADriverName} has accepted your order for ${widget.oAAmount}, will arrive in ${widget.oATime}',
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey.shade50,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(
                    width: 10,
                  ),
                  widget.oADriverProfileUrl == '' ||widget.oADriverProfileUrl == 'null'? 
                  ClipOval(
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                      'assets/rideshare/person.jpg',
                      fit: BoxFit.cover,)),
                  ):
                  ClipOval(
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Image.network(
                      widget.oADriverProfileUrl,
                      fit: BoxFit.cover,)),
                  )
                  ,
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: Get.width*0.52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.oADriverName}',
                        style: TextStyle(
                          fontSize: 14,fontWeight: FontWeight.w600,
                        ),),
                        Text('Phone No:${widget.oAPhoneNo}'),
                        Text('Plate No: ${widget.oAPlateNo}')
                      ],
                    )),
                  GestureDetector(
                    onTap: (){
                      String phoneno = '${widget.oAPhoneNo}';
                      makePhoneCall(phoneno);
                    },
                    child: ClipOval(
                      child: Container(
                        color: Colours.primarygreen,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.call_rounded,
                          color: Colors.white,
                          size: 30,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,10,0,10),
                child: Text("Amount : ${widget.oAAmount}",
                style: TextStyle(
                        fontSize: 14,fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,10,0),
                child: ElevatedButton(
                      style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
                          ),
                      child: Text('File Complaint'),
                      onPressed: () {
                        _showComplaintDialog();
                      },
                ),
              ),
            ],
          ),
          Row(children: [
             SizedBox(
              width: 25,
            ),
            Container(
              height: 80,
              width: 25,
              child: SvgPicture.asset('assets/rideshare/icon.svg',fit: BoxFit.contain),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: Get.width*0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${widget.oAsourceLocation}',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 35,
                  ),
                  Text('${widget.oAdestinationLocation}',
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                   _showCancelDialogBox();
                  },
                  child: ClipOval(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.red,
                      child: Icon(Icons.cancel_rounded,
                      color: Colors.white,
                      size: 40,)),
                  ),
                ),
                Text("Cancel Ride",style: TextStyle(color: Colors.red,fontSize: 12),)
              ],
            ),
          ],)
        ],
      ),
    )
    :BlocListener<RideShareBloc, RideShareState>(
      listener: (context, state) {
        if(state is firstDriverFound){
          

        }
    if(state is searchingForDriver){
     widget.findDriverCallBack();
    }
  },
      child: Container(
                width: Get.width,
                height: widget.recommendPrice == true ? 420:360,
                decoration: BoxDecoration(
                   color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                     borderColor1 = Colours.primarygreen;
                                     borderColor2 = Colors.grey;
                                     borderColor3  = Colors.grey;
                                     borderColor4 = Colors.grey;
                                  });
                                  widget.indexChecker(1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: borderColor1),
                                      borderRadius: BorderRadius.circular(5),
                                      color: borderColor1.withOpacity(0.2),
                                    ),
                                    height:60,
                                    width:70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 34,
                                            width: 40,
                                            child: Image.asset('assets/rideshare/bycicle.png')),
                                          Text("Moto",style: TextStyle(fontSize: 10),)
                                        ],
                                      ),
                                    )),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                      borderColor1 = Colors.grey;
                                     borderColor2 = Colours.primarygreen;
                                     borderColor3  = Colors.grey;
                                        borderColor4 = Colors.grey;
                                  });
                                  widget.indexChecker(2);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: borderColor2),
                                      borderRadius: BorderRadius.circular(5),
                                      
                                     color: borderColor2.withOpacity(0.2),
                                    ),
                                    height:60,
                                    width:70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 34,
                                            width: 40,
                                            child: Image.asset('assets/rideshare/sport-car.png',
                                            fit: BoxFit.fitWidth,)),
                                          Text("Ride",style: TextStyle(fontSize: 10),)
                                        ],
                                      ),
                                    )),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                      borderColor1 = Colors.grey;
                                     borderColor2 = Colors.grey;
                                     borderColor3  = Colours.primarygreen;
                                        borderColor4 = Colors.grey;
                                  });
                                   widget.indexChecker(3);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: borderColor3),
                                      borderRadius: BorderRadius.circular(5),
                                      color:borderColor3.withOpacity(0.2),
                                    ),
                                    height:60,
                                    width:70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            child: Image.asset('assets/rideshare/delivery.png',
                                            fit: BoxFit.fitHeight,)),
                                            SizedBox(height: 4,),
                                          Text("Courier",style: TextStyle(fontSize: 10),)
                                        ],
                                      ),
                                    )),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                      borderColor1 = Colors.grey;
                                     borderColor2 = Colors.grey;
                                     borderColor3  = Colors.grey;
                                        borderColor4 = Colours.primarygreen;
                                  });
                                   widget.indexChecker(4);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: borderColor4),
                                      borderRadius: BorderRadius.circular(5),
                                     color: borderColor4.withOpacity(0.2),
                                    ),
                                    height:60,
                                    width:70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 34,
                                            width: 40,
                                            child: Image.asset('assets/rideshare/taxi.png',
                                            fit: BoxFit.fitWidth,)),
                                          Text("Auto",style: TextStyle(fontSize: 10),)
                                        ],
                                      ),
                                    )),
                                ),
                              ),
    
                            ],
                          ),
                          //Text("From:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color:widget.changeFirstBorderColor? Colours.primarygreen.withOpacity(0.4):Colors.grey.shade300,width: 2),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          controller: widget.fromLocation,
                          readOnly: true,
                          onTap: (){
                          Get.to(FromLocation(callback: callback1,type:'from',latValue:widget.sourceLatitude,longValue:widget.sourceLongitude));
                          },
                          decoration: InputDecoration(
                          border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                hintText: "Select Your Location",
                                floatingLabelStyle: TextStyle(color: Colours.primarybrown),
                                labelStyle:
                                    TextStyle(color: Colours.primarybrown),
                                hintStyle:TextStyle(
                                      color: Colours.primarybrown,
                                      fontSize: 14),
    
                                ),
                        ),
                      ),
                          SizedBox(height: 5,),
                          //Text("To:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          SizedBox(height: 5,),
                          Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: widget.changeSecondBorderColor?Colours.primarygreen.withOpacity(0.4): Colors.grey.shade300,width: 2),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          maxLines: 1,
                          controller: widget.toLocation,
                          readOnly: true,
                          onTap: (){
                          Get.to(FromLocation(callback: callback2,type:'to',latValue:widget.destinationLatitude,longValue:widget.destinationLongitude));
                          },
                          decoration: const InputDecoration(
                          border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                hintText: "Select Destination Location",
                                floatingLabelStyle: TextStyle(color: Colours.primarybrown),
                                labelStyle:
                                    TextStyle(color: Colours.primarybrown),
                                hintStyle:TextStyle(
                                      color: Colours.primarybrown,
                                      fontSize: 14),
                                ),
                        ),
                      ),
                          //TextContainer(hintText: 'Select Destination Location  1',controller: widget.toLocation,),
                          SizedBox(height: 5,),
                          //Text("Offer Your Fare:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          SizedBox(height: 5,),
                          widget.recommendPrice == true ?
                          RecommendedPriceContainer(
                            price: borderColor1 ==Colours.primarygreen ? widget.recommendedFare: (double.parse(widget.recommendedFare.replaceAll('Rs.', ''))*2).toString(),
                            time: '${(double.parse(widget.recommendedFare.replaceAll("Rs. ", ""))/10).toInt()}'
                            ):Container(),
                          
                            Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300,width: 2),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          controller: widget.fare,
                          readOnly: true,
                          onTap: (){
                          _showOfferBottomSheet(context,callback3);
                          },
                          decoration: InputDecoration(
                          border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                hintText: "Your Offered Fare",
                                floatingLabelStyle: TextStyle(color: Colours.primarybrown),
                                labelStyle:
                                    TextStyle(color: Colours.primarybrown),
                                hintStyle:TextStyle(
                                      color: Colours.primarybrown,
                                      fontSize: 14),
    
                                ),
                        ),
                      ),
                          SizedBox(height: 5,),
                          //Text("Comment:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          SizedBox(height: 5,),
                           Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300,width: 2),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          controller: widget.comment,
                          readOnly: true,
                          onTap: (){
                          _showCommentBottomSheet(context,callback4);
                          },
                          decoration: InputDecoration(
                          border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                hintText: "Write your comment",
                                floatingLabelStyle: TextStyle(color: Colours.primarybrown),
                                labelStyle:
                                    TextStyle(color: Colours.primarybrown),
                                hintStyle:TextStyle(
                                      color: Colours.primarybrown,
                                      fontSize: 14),
    
                                ),
                        ),
                      ),
                          SizedBox(height: 15,),
            
                  Center(
        child: Container(
          width: Get.width,
          child: CustomButton(
            label: 'Find a Driver',
            onpressed: () async {
              String category = '';
              if (borderColor1 == Colours.primarygreen) {
                category = "Moto";
              } else if (borderColor2 == Colours.primarygreen) {
                category = "Ride";
              } else if (borderColor3 == Colours.primarygreen) {
                category = "Delivery";
              }
              if(widget.fromLocation.text == ''){
                Get.to(FromLocation(callback: callback1,type:'from',latValue: widget.sourceLatitude,longValue: widget.sourceLongitude,));
              }
              else if(widget.toLocation.text ==''){
                 Get.to(FromLocation(callback: callback2,type:'to',latValue: widget.destinationLatitude,longValue: widget.destinationLongitude,));
              }
              else if(widget.fare.text == ''){
               _showOfferBottomSheet(context,callback3);
              }
              else{  
              widget.findDriverCallBack();
                
                // widget.findDriverCallBack();
              // BlocProvider.of<RideShareBloc>(context).add(findRideShareDriver(
              //   context,
              //   category,
              //   widget.fromLocation.text,
              //   widget.toLocation.text,
              //   widget.fare.text,
              //   widget.comment.text,
              //   widget.sourceLatitude,
              //   widget.sourceLongitude,
              //   widget.destinationLatitude,
              //   widget.destinationLongitude,
              //   orderHasBeenAccepeted
              // ));
                
              }
              
            },
            color: Colours.primarygreen,
          ),
        ),
      ),
      
    
                      ]),
                    ),
                  ),
              ),
    );
  }

}




bool ChildSheet = true;
bool passenger = true;
class RecommendedPriceContainer extends StatefulWidget {
  String price;
  String time;
  RecommendedPriceContainer({super.key,required this.price,required this.time});

  @override
  State<RecommendedPriceContainer> createState() => _RecommendedPriceContainerState();
}

class _RecommendedPriceContainerState extends State<RecommendedPriceContainer> {
  @override
  initState(){
    int timeValue = int.parse(widget.time);
    // int hourValue  = int.parse(timeValue /60);
    print("The time value is"+widget.time.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,10),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("The recommended price is Rs. ${widget.price} and Travel Time is approx. ${widget.time} min"),
        ),
      ),
    );
  }
}
// // ignore: must_be_immutable
// class TextContainer extends StatefulWidget {
//   String hintText;
//   TextEditingController controller;
 
//   TextContainer({super.key,required this.hintText,required this.controller});

//   @override
//   State<TextContainer> createState() => _TextContainerState();
// }
   
// class _TextContainerState extends State<TextContainer> {
   
//    bool isKeyboardVisible = false;
//         @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
    
//   }
//     void removeFocus() {
//   FocusManager.instance.primaryFocus?.unfocus();
// } 

//     callback(String inputValue){
//       removeFocus();
//       print("The input Value is");
//       print(inputValue);
//       widget.controller.text = inputValue;
//     }

//     fareCallback(String val){
//       widget.controller.text = val;
//     }

//     CommentCallback(String value){
//      widget.controller.text = value;
//     }
  
//      void _showOfferBottomSheet(BuildContext context1,Function fareCallback){
//   FocusNode _focusNode = FocusNode();
//    final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
//   //  KeyboardVisibilityController? _keyboardVisibilityController;
//   //   _keyboardVisibilityController = KeyboardVisibilityController();
//   //   print("initialized");
//   //   _keyboardVisibilityController!.onChange.listen((isVisible) {
//   //     if (!isVisible) {
//   //       print("Keyboard minimized");
//   //       Get.back();
       
//   //     }
//   //   });
//     bool cash =true;

    
//     showModalBottomSheet(
//       context: context1,
//       builder: (BuildContext context1) {
        
//         FocusScope.of(Get.context!).requestFocus(_focusNode);
//         _focusNode.addListener(() {
//   if (!_focusNode.hasFocus) {
//     //  Navigator.of(context1).pop();
//   }
// });
        

//         return 
//           StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return KeyboardVisibilityProvider(
//                 //controller: _keyboardVisibilityController,
//                 child: Container(
//                   height: 1000,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 80,
//                             child: Text("NPR.",
//                             style: TextStyle(fontSize: 25,
//                             fontWeight: FontWeight.w600),)),
//                           Container(
//                             width: 60,
//                             child: TextField(
//                               style: TextStyle(
//                              fontSize: 20.0, // Set the text size here
//                             ),
//                               onSubmitted: (val){
//                                 fareCallback("Rs. "+val);
//                                 Get.back();
//                               },
//                               decoration: InputDecoration(
//                    // labelText: 'Enter text',
//                     labelStyle: TextStyle(
//                       fontSize: 50.0, // Set the text size here
//                     ),
//                   ),
//                               focusNode: _focusNode,
//                               keyboardType: TextInputType.number, // Set the keyboard type to number
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.digitsOnly, // Accept only digits
//                     ],
//                             )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text("Specify a reasonable price"),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: (){
//                            setState(() {
//                             cash =true;
//                           });
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15,0,15,0),
//                           child: Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                               // color: Colors.red,
//                               border: Border.all(color:cash==true ? Colors.green:Colors.grey),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.fromLTRB(8.0,0,20,0),
//                                     child: Icon(FontAwesomeIcons.moneyBillWave,
//                                     color: cash==true ? Colors.green:Colors.grey),
//                                   ),
//                                    Text("Cash"),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0,0,20,0),
//                                 child: Icon(Icons.check_circle_outline_rounded,color: cash==true ? Colors.green:Colors.grey),
//                               )
//                             ],)
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: (){
//                            setState(() {
//                             cash =false;
//                           });
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15,0,15,0),
//                           child: Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                               // color: Colors.red,
//                               border: Border.all(color:cash==false ? Colors.green:Colors.grey),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.fromLTRB(8.0,0,20,0),
//                                     child: Icon(Icons.wallet,
//                                     color: cash==false ? Colors.green:Colors.grey),
//                                   ),
//                                    Text("E-Wallet"),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0,0,20,0),
//                                 child: Icon(Icons.check_circle_outline_rounded,color: cash==false? Colors.green:Colors.grey),
//                               )
//                             ],)
//                           ),
//                         ),
//                       ),
                      
//                     ],
//                   ),
//                 ),
//               );
//             }
//           );
//       },
//     );
//   }
//       void _showCommentBottomSheet(BuildContext context,Function CommentCallback){
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Container(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ListTile(
//                         onTap: (){
//                           setState(() {
//                             ChildSheet = !ChildSheet;
//                           });
//                           print("Child Sheet");
                          
//                         },
//                         leading: Icon(
//                           Icons.child_care),
//                         title: Text("Child Seat"),
//                         trailing: CupertinoSwitch(
//                     value: ChildSheet,
//                     onChanged: (value) {
//                        setState(() {
//                         ChildSheet =value;  
//                       });
//                     },
//                   ),
            
//                       ),
//                       ListTile(
//                         onTap: (){
//                           setState(() {
//                             passenger = !passenger;
//                           });
//                         },
//                         leading: Icon(Icons.people),
//                         title: Text("More than 4 passenger"),
//                         trailing:CupertinoSwitch(
//                     value: passenger,
//                     onChanged: (value) {
//                       setState(() {
//                         passenger =value;  
//                       });
//                                     },
//                   ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(15,0,15,10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: (){
//                                 Get.back();
//                               },
//                               child: Text("Close",style: TextStyle(color: Colors.red),)),

//                             GestureDetector(
//                               onTap: (){
//                                 String value = '';
//                                 if(ChildSheet == true){
//                                   value += 'Child Sheet';
//                                 }
//                                 if(passenger == true){
//                                   value += 'More than 4 Passenger';
//                                 }
//                                 if(ChildSheet == true && passenger ==true){
//                                   value = "Child Sheet + More than 4 Passenger";

//                                 }
//                                 CommentCallback(value);
                                
//                                 Get.back();
//                               },
//                               child: Text("Submit",style: TextStyle(color: Colours.primarygreen),))
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//           }
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
 
//     return Container(
//       height: 40,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: TextField(
//                         readOnly: true,
//                         controller: widget.controller,
//                         onTap: 
//                         (){
//                           if(widget.hintText == 'Select Your Location'){
//                           removeFocus();
//                           Get.to(FromLocation(callback: callback,type:'from'));
//                           }
//                           if(widget.hintText == 'Select Destination Location'){
//                             removeFocus();
//                           Get.to(FromLocation(callback: callback,type:'to'));
//                           }
//                           if(widget.hintText == 'Your offered fare'){
//                             _showOfferBottomSheet(context,fareCallback);
//                           }
//                           if(widget.hintText == 'Write Your Comment'){
//                             _showCommentBottomSheet(context,CommentCallback);
//                           }
                            
                          
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                 hintText: widget.hintText,
//                                 floatingLabelStyle: TextStyle(color: Colours.primarybrown),
//                                 labelStyle:
//                                     TextStyle(color: Colours.primarybrown),
//                                 hintStyle:TextStyle(
//                                       color: Colours.primarybrown,
//                                       fontSize: 14),

//                                 ),
//                       ),
//                     );
//   }
// }

