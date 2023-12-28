import 'package:flutter/material.dart';
import 'package:food_app/User/Controller/Functions/capitalize.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../components/order_container.dart';
import '../components/size_config.dart';

class Home extends StatefulWidget {
  List notifications;
  List notificationsIds;
  Home({super.key,required this.notifications,required this.notificationsIds});

  @override
  State<Home> createState() => _HomeState();
}
  //  'userId': userId!,
  //       'sid': widget.sid,
  //       'mode_of_payment': 'esewa',
  //       'discount': "40",
  //       'vat': "40",
  //       'amount': "${widget.total_value}",
  //       'paymentNote': "online payment",
  //       'remarks': "deliver fast",
  //       'taxable': "0",
  //       'nonTaxable': "${widget.total_value}",
  //       'delivery_location': "$locationName,$placeName",
  //       'lat': latitude!,
  //       'long': longitude!,
  //       'PaymentStatus': '1',
  //       'payment_transaction_id': "cash",
  //       'total':  "${widget.total_value}",
  //       'distance': "1.5",
  //       'delivery_charge': "40",
  //        'payment_note': '',
  //        "customerPlayerId":playerId 

class _HomeState extends State<Home> {
  
   getNotification()async{
    var status = await OneSignal.shared.getDeviceState();
    
    //  OneSignal.shared.setNotificationOpenedHandler((openedResult) { 
    //   for(int i=0; i<notificationIds.length ;i++){
    //   if(openedResult.notification.notificationId == notificationIds[i]){
    //   }
    //   else{
    //   setState(() {
    //     notifications.add(openedResult.notification);
    //     notificationIds.add(openedResult.notification.notificationId);
    //   });
    //   }
    //   }
    // });
  }
  String? did='';
   getDriverId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    did = prefs.getString('driverId');
    print("the driver id is"+did.toString());
   }

int count =0;
@override
  void initState() {
    getDriverId();
    getNotification();
    // TODO: implement initState
    super.initState();
  }
  deleteIndex(int index){
    setState(() {
          // notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: null,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: Text(
            'Mero Auto',
            style: TextStyle(
                fontSize: SizeConfig(context).titleSize()-2,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
          child: Column(
            children: [
              widget.notifications.length ==0?
              Container(
                height: Get.height-200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset('assets/images/order-food.png'))),
                      SizedBox(height: 10,),
                    Center(child: Text("No Order Request")),
                  ],
                ),
              ):
              
                Container(
                  height: Get.height-170,
                  child: ListView.builder(
                    itemCount: widget.notifications.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: OrderContainer(
                          notifications : widget.notifications,
                          index :index,
                          orderCategory: 'Food',
                          orderId:  capitalize(widget.notifications[index]['serviceProviderName']??'N/A'.toString()??'N/A') ,
                          totalAmount:  widget.notifications[index]['amount'] ?? 'N/A'.toString() ?? 'N/A',
                          restaurantLocation: "From: " + capitalize(widget.notifications[index]['serviceProviderLocation']??'N/A'.toString()) ??'N/A',
                          orderLocation:"To: " + capitalize(widget.notifications[index]['delivery_location']??'N/A') ?? 'N/A',
                          itemName1: capitalize(widget.notifications[index]['item1']??'N/A') ?? '',
                          itemQuantity1: widget.notifications[index]['quantity1']??'N/A' ?? '',
                           itemName2: capitalize(widget.notifications[index]['item2']??'N/A') ?? '',
                          itemQuantity2: widget.notifications[index]['quantity2']?? 'N/A',
                          tCode:widget.notifications[index]['tCode']??'N/A',
                          driverId:did!,
                          logoUrl:widget.notifications[index]['logoUrl']??'',
                        ),
                      );
                    }),
                    
                    
                  ),
                ),
            ],
          ),
        )),
      ),
    );
  }
}
