import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Driver/Controller/repository/postDeliveries.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/Controller/repositories/get_nearby_driver.dart';
import '../../../User/Model/nearby_driver_model.dart';
import 'size_config.dart';

class OrderContainer extends StatefulWidget {
  final List notifications;
  final int index;
  final String orderId;
  final String totalAmount;
  final String restaurantLocation;
  final String orderLocation;
  final String itemName1;
  final String itemQuantity1;
  final String itemName2;
  final String itemQuantity2;
  final String orderCategory;
  final String tCode;
  final String driverId;
  final String logoUrl;

  OrderContainer(
      {super.key,
      required this.notifications,
      required this.index,
      required this.orderCategory,
      required this.orderId,
      required this.totalAmount,
      required this.restaurantLocation,
      required this.orderLocation,
      required this.itemName1,
      required this.itemQuantity1,
      required this.itemName2,
      required this.itemQuantity2,
      required this.tCode,
      required this.driverId,
      required this.logoUrl,

      });

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
   deleteIndex(int index){
    setState(() {
          widget.notifications.removeAt(index);
    });
  }
@override
initState(){
  print("the given t code is"+widget.tCode);
}
sendRejectResponseToAllOtherNearByDriver(String acceptedPlayerId,String verificationCode)async{
  List AllPlayerIds =[];
   NearByDriverRepository repo = NearByDriverRepository();
          NearByDriverModel model =
              await repo.getNearByDriverData('28.105', '83.8659', '0','0');
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              print(model.nearByDriverPlayerIds![i].playerId);
              if(model.nearByDriverPlayerIds![i].playerId != null){
                
              AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
              }
            }
            for(int j=0;j<AllPlayerIds.length;j++){
              try{
                if(AllPlayerIds[j].toString() == acceptedPlayerId.toString()){

              }
              else{
                SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId =  prefs.getString('driverId');
                 var data = {
      'to' : '${AllPlayerIds[j]}',
      'priority': 'high',
      'data':{
        'status':'cancel other delivery request',
        'verificationCode':verificationCode,
        'driverId':driverId
      }
      };
      print("Reject Response is"+data.toString());
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
              }
               
              }
              catch(e){
                print("Error is"+e.toString());
              }
            }
}
}
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: SizeConfig(context).containerHeight()-65,
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.orderCategory} Order',
                          style: TextStyle(
                              fontSize: SizeConfig(context).nameSize(),
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          width: Get.width-150,
                          child: Text(
                            "Order From:  ${widget.orderId}",
                            style: TextStyle(
                                
                                fontSize: SizeConfig(context).textSize(),
                                fontWeight: FontWeight.w100,
                                color: const Color.fromARGB(255, 75, 74, 74)),
                                maxLines:1,
                                overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "Total Amount: Rs. ${widget.totalAmount}",
                          style: TextStyle(
                              fontSize: SizeConfig(context).textSize(),
                              fontWeight: FontWeight.w100,
                              color: const Color.fromARGB(255, 75, 74, 74)),
                        ),
                        Container(
                          
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color.fromARGB(255, 75, 74, 74),
                              ),
                              Container(
                                width: screenWidth-150,
                                child: Text(
                                  "${widget.restaurantLocation}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: SizeConfig(context).textSize(),
                                      fontWeight: FontWeight.w100,
                                      color: const Color.fromARGB(255, 75, 74, 74)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.fire_truck_outlined,
                              color: Color.fromARGB(255, 75, 74, 74),
                            ),
                            Text(
                              "${widget.orderLocation}",
                              style: TextStyle(
                                  fontSize: SizeConfig(context).textSize(),
                                  fontWeight: FontWeight.w100,
                                  color: const Color.fromARGB(255, 75, 74, 74)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // widget.logoUrl != null ? Container(
                    //   width: 60,
                    //   height: 60,
                    //   child: Image.network(widget.logoUrl))
                    // :
                    Image(
                      image: AssetImage('assets/images/food-seeklogo3.png'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Items",
                //       style: TextStyle(
                //           color: const Color.fromARGB(255, 75, 74, 74),
                //           fontWeight: FontWeight.w500,
                //           fontSize: SizeConfig(context).nameSize() - 2),
                //     ),
                //     Text(
                //       "Qty",
                //       style: TextStyle(
                //           color: const Color.fromARGB(255, 75, 74, 74),
                //           fontWeight: FontWeight.w500,
                //           fontSize: SizeConfig(context).nameSize() - 2),
                //     ),
                //   ],
                // ),
               
                //   Padding(
                //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           widget.itemName1,
                //           style: TextStyle(
                //               color: const Color.fromARGB(255, 75, 74, 74),
                //               fontWeight: FontWeight.w500,
                //               fontSize: SizeConfig(context).textSize()),
                //         ),
                //         Text(
                //           widget.itemQuantity1.toString(),
                //           style: TextStyle(
                //               color: const Color.fromARGB(255, 75, 74, 74),
                //               fontWeight: FontWeight.w500,
                //               fontSize: SizeConfig(context).textSize()),
                //         ),
                //       ],
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           widget.itemName2,
                //           style: TextStyle(
                //               color: const Color.fromARGB(255, 75, 74, 74),
                //               fontWeight: FontWeight.w500,
                //               fontSize: SizeConfig(context).textSize()),
                //         ),
                //         Text(
                //           widget.itemQuantity2.toString(),
                //           style: TextStyle(
                //               color: const Color.fromARGB(255, 75, 74, 74),
                //               fontWeight: FontWeight.w500,
                //               fontSize: SizeConfig(context).textSize()),
                //         ),
                //       ],
                //     ),
                //   ),
              
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
                  deleteIndex(widget.index);
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
                child: const Text('DECLINE'),
              ),
              ElevatedButton(
                onPressed: () async{
                  PostDeliveriesRepository repo = PostDeliveriesRepository();
                  repo.PostDeliveries(
                    widget.tCode,
                    widget.driverId
                  );
                  await FirebaseMessaging.instance.requestPermission().then((value) {
      FirebaseMessaging.instance.getToken().then((value) {
        print('TOken$value');
       sendRejectResponseToAllOtherNearByDriver(value.toString(),widget.tCode);
      });
    });
                  
                 //sendRejectResponseToAllOtherNearByDriver(widget.notifications[0]['playerId'].toString(),'');
                  deleteIndex(widget.index);
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
                child: const Text('ACCEPT'),
              ),
            ],
          )
        
        ],
      ),
    );
  }
}
