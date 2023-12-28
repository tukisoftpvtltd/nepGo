// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/size_config.dart';
import '../constants/colors.dart';
import 'RideRequestPage.dart';

class RideShareOrderContainer extends StatefulWidget {
  final List notifications;
  final int index;
  final String phoneNo;
  final String totalAmount;
  final String fromLocation;
  final String toLocation;
  final String itemName1;
  final String itemQuantity1;
  final String itemName2;
  final String itemQuantity2;
  final String passengerName;
  final String tCode;
  final String driverId;
  final String logoUrl;
  final String distance;
  final String  customerPlayerId;
  final String sourceLatitude;
  final String sourceLongitude;
  final String destinationLatitude;
  final String destinationLongitude;
  double driverLatitude;
  double driverLongitude;
  bool mainMessageListener;
  Function deleteCallback;
  Function closeMainMessageListener;
    Function openMainMessageListener;
    Function clearNotifications;
  String userProfileUrl;
   RideShareOrderContainer(
      {super.key,
      required this.notifications,
      required this.index,
      required this.passengerName,
      required this.phoneNo,
      required this.totalAmount,
      required this.fromLocation,
      required this.toLocation,
      required this.itemName1,
      required this.itemQuantity1,
      required this.itemName2,
      required this.itemQuantity2,
      required this.tCode,
      required this.driverId,
      required this.logoUrl,
      required this.distance,
      required this.customerPlayerId,
      required this.destinationLatitude,
      required this.destinationLongitude,
      required this.sourceLatitude,
      required this.sourceLongitude,
      required this.driverLatitude,
      required this.driverLongitude,
      required this.mainMessageListener,
      required this.closeMainMessageListener,
      required this.openMainMessageListener,
      required this.deleteCallback,
      required this.clearNotifications,
      required this.userProfileUrl
      });

  @override
  State<RideShareOrderContainer> createState() => _RideShareOrderContainerState();
}

class _RideShareOrderContainerState extends State<RideShareOrderContainer> {

    void launchGoogleMaps({
  required String fromLocation,
   required String toLocation,
}) async {
  final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&origin=$fromLocation&destination=$toLocation&travelmode=driving";
  
  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }
}
@override
initState(){
  super.initState();
 
}


List list =["something",'nothing'];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SwipeActionCell(
      key: ObjectKey(list[0]),
      closeWhenScrolling: true,
     trailingActions: <SwipeAction>[
       SwipeAction(
           widthSpace: Get.width/3,
           title: "Show On Map",
           color: Colors.white,
           style: TextStyle(color: Colors.black),
           icon: Icon(Icons.map),
           onTap: (CompletionHandler handler) async {
            String fromLocation = widget.sourceLatitude+','+widget.sourceLongitude;
                  String toLocation = widget.destinationLatitude+','+widget.destinationLongitude;
             launchGoogleMaps(fromLocation: fromLocation,toLocation:toLocation );
           },
          ),

       SwipeAction(
           widthSpace: Get.width/3,
           title: "Hide",
           color: Colors.white,
           style: TextStyle(color: Colors.black),
           icon: Icon(Icons.remove_red_eye),
           onTap: (CompletionHandler handler) async {
             
           },
          ),
          SwipeAction(
           widthSpace: Get.width/3,
           title: "Complain",
           color: Colors.white,
           style: TextStyle(color: Colors.black),
           icon: Icon(Icons.warning),
           onTap: (CompletionHandler handler) async {
             
           },
          ),
          
     ],
      child: Container(
        width: double.infinity,
        height: SizeConfig(context).containerHeight()-Get.height/11,
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(
              width: 0.2,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 30, top: 8, bottom: 0),
              child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width-150,
                            child: Text(
                              '${widget.passengerName}',
                               maxLines:1,
                              style: TextStyle(
                                  fontSize: SizeConfig(context).nameSize()-2,
                                  fontWeight: FontWeight.w600,
                                 
                                 ),
                            ),
                          ),
                          Container(
                            width: Get.width-150,
                            child: Text(
                              "Phone no :  ${widget.phoneNo}",
                              style: TextStyle(
                                  fontSize: SizeConfig(context).textSize()-2,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.grey.shade600),
                                  maxLines:1,
                                  overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "Amount: ${widget.totalAmount}",
                            style: TextStyle(
                                fontSize: SizeConfig(context).textSize()-2,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey.shade600),
                          ),
                          Row(
                            children: [
                              Container(
                               
                                width: 15,
                                height: 50,
                                child:

                                 SvgPicture.asset(
              'assets/rideshare/icon.svg', 
              height: 15, 
              width: 50,  
            )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth-150,
                                      child: Text(
                                        "From: ${widget.fromLocation}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: SizeConfig(context).textSize()-2,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                   Padding(
                                     padding: const EdgeInsets.fromLTRB(0,5,0,5),
                                     child: Container(
                                      width: screenWidth-250,
                                       child: CustomPaint(
                                           size: Size(20, 2), // Set the width and height of the line
                                           painter: DottedLinePainter(),
                                         ),
                                     ),
                                   ),
                                    Container(
                                      width: screenWidth-150,
                                      child: Text("To: ${widget.toLocation}",
                                      maxLines: 1,
                                      style: TextStyle(
                                      fontSize: SizeConfig(context).textSize()-2,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey.shade600),
                                                                ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
            //           widget.userProfileUrl.toString() =='null'?

            //                      SvgPicture.asset(
            //   'assets/rideshare/icon.svg', 
            //   height: 15, 
            //   width: 50,  
            // ):Image.asset(widget.userProfileUrl,
            // fit: BoxFit.cover,),
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 70,
                              height: 70,
                              child: widget.userProfileUrl.toString() =='null'?
                              Image.asset('assets/rideshare/person.jpg',fit: BoxFit.cover,
                              ):Image.network(widget.userProfileUrl,
           fit: BoxFit.cover,),
                            ),
                          ),
                          Container(
                            width: 70,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,15,0,0),
                              child: Text(widget.distance,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colours.primarygreen),),
                            ),
                          ),
                        ],
                      ),
                     
                    ],
                  ),
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print(widget.index);
                    widget.deleteCallback(widget.index);
                    // deleteIndex(widget.index);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig(context).buttonHorizontalPadding(),
                        vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Decline'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Get.to(WaitingPage());
                    widget.closeMainMessageListener();
                    Get.to(RideRequestPage(
                      distance: widget.distance,
                      customerPlayerId:widget.customerPlayerId,
                      sourceLatitude:widget.sourceLatitude,
                      sourceLongitude:widget.sourceLongitude,
                      destinationLatitude:widget.destinationLatitude,
                      destinationLongitude:widget.destinationLongitude,
                      passengerName:widget.passengerName,
                      phoneNo: widget.phoneNo,
                      sourceLocation : widget.fromLocation,
                      destinationLocation:widget.toLocation,
                      amount:widget.totalAmount,
                      driverLatitude:widget.driverLatitude,
                      driverLongitude:widget.driverLongitude,
                      openMainMessageListener:widget.openMainMessageListener,
                      index:widget.index,
                      deleteCallBack:widget.deleteCallback,
                      clearNotifications:widget.clearNotifications,
                      userProfileUrl:widget.userProfileUrl

                    ));
                    
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig(context).buttonHorizontalPadding(),
                        vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('View'),
                ),
              ],
            )
          
          ],
        ),
      ),
    );
  }
}
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Color of the dots
      ..strokeWidth = 1 // Thickness of the dots
      ..strokeCap = StrokeCap.round;

    final double dashWidth = 4;
    final double dashSpace = 4;
    double distance = 0;

    while (distance < size.width) {
      canvas.drawLine(
        Offset(distance, 1),
        Offset(distance + dashWidth, 1),
        paint,
      );
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}