import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Views/Payment/payment_methods.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Controller/repositories/get_nearby_driver.dart';
import '../../../../../../Controller/repositories/rideShare/Sales/addSales.dart';
import '../../../../../../Model/nearby_driver_model.dart';
import '../../../../../constants/colors.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
bool listen = true;
// ignore: must_be_immutable
class RideShareDriverPage extends StatefulWidget {
  String userId;
  Function orderAccepted;
  Function? callback;
  Map<String,dynamic> firstNotification;
  bool flag;
  Function cancelCallBack;
  bool cash;
  Function openFirstListener;
  double travelDistance;
  RideShareDriverPage({
    super.key,
    required this.userId,
    required this.orderAccepted,
    this.callback,
    required this.firstNotification,
    required this.flag,
    required this.cancelCallBack,
    required this.cash,
    required this.openFirstListener,
    required this.travelDistance,
  });

  @override
  State<RideShareDriverPage> createState() => _RideShareDriverPageState();
}

class _RideShareDriverPageState extends State<RideShareDriverPage> {
  String generateRandomCode(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    List.generate(length, (index) => charset.codeUnitAt(random.nextInt(charset.length))),
  );
}
  //StreamSubscription<RemoteMessage>? messageSubscription;
  sendAcceptResponse(String driverPlayerId, String phoneNo,String verificationCode,String driverId)async{
  try{  
      var data = {
      'to' : '$driverPlayerId',
      'priority': 'high',
      'data':{
        'phoneno':'$phoneNo',
        'verificationCode':'$verificationCode',
        'status':'accepted',
        'userId':widget.userId
      }
      };
      print(data);
      print("posting Data to"); 
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode (data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
    sendRejectResponseToAllOtherNearByDriver(driverPlayerId,verificationCode);
    //sendRejectResponsetoAllOtherDrivers(driverId,verificationCode);
      
    }
    catch(e){
      print("Error Occured");
    }
}
 sendRejectResponse(String driverId, String phoneNo,String verificationCode)async{
  try{   

      var data = {
      'to' : '$driverId',
      'priority': 'high',
      'data':{
        'phoneno':'$phoneNo',
        'verificationCode':'$verificationCode',
        'status':'rejected',
        'userId':widget.userId
      }
      };
      print(data);
      print("The reject response was sent"); 
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode (data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
    }
    catch(e){
      print("Error Occured");
    }
}
sendRejectResponseToAllOtherNearByDriver(String acceptedPlayerId,String verificationCode)async{
  List AllPlayerIds =[];
   NearByDriverRepository repo = NearByDriverRepository();
          NearByDriverModel model =
              await repo.getNearByDriverData('28.105', '83.8659', '1','0');
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
                 var data = {
      'to' : '${AllPlayerIds[j]}',
      'priority': 'high',
      'data':{
        'status':'rejected',
        'verificationCode':verificationCode,
        'userId':widget.userId
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

sendRejectResponsetoAllOtherDrivers(String acceptedPlayerId,String verificationCode)async{
  try{ 
    for(int i=0;i<AllDriverPlayerIdWhoAcceptedYourRequest.length;i++){
      if(AllDriverPlayerIdWhoAcceptedYourRequest[i] == acceptedPlayerId){

      }
      else{
         var data = {
      'to' : '${AllDriverPlayerIdWhoAcceptedYourRequest[i]}',
      'priority': 'high',
      'data':{
        'status':'rejected',
        'verificationCode':verificationCode
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
      
    }
    catch(e){
      print("Error Occured");
    }

}

List AllDriverPlayerIdWhoAcceptedYourRequest = [];
StreamSubscription<RemoteMessage>? messageSubscription;


  @override
  void initState() {
   
    setState(() {
     
        listen =true;
    });
    widget.flag =false;
    AllDriverPlayerIdWhoAcceptedYourRequest.add(widget.firstNotification['driverPlayerId']);
    notifications.add(widget.firstNotification);
      if(listen ==true) {
        print("Message received 333");
       messageSubscription =FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       if(listen == true){
        print("Data is in new page 333");
      RemoteNotification?  notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print(message.data);
        final player = AudioPlayer();
      playNotification(){
  print("play sound");
  player.play(AssetSource('notification.wav'));
 }  
      playNotification();
      setState(() {
        notifications.add(message.data);
      });
      print("The notification is");
      print(notifications);
      AllDriverPlayerIdWhoAcceptedYourRequest.add(message.data['driverPlayerId']);
     
       }
      });
      }
     
    // TODO: implement initState
    super.initState();
  }




   List notifications = [];
    deleteRequest(index) {
    setState(() {
      notifications.removeAt(index);
      if(notifications.length ==0){
        setState(() {
          notifications=[];
        listen =false;
        });
        widget.callback!();
         Navigator.of(context).pop();
      }
      
    });
    // OneSignal.shared.removeNotification(notificationsIds[index]);
    // animationController?.removeAt(index);
  }

  @override
void dispose() {

  widget.callback!();
 messageSubscription?.cancel();
  super.dispose();
}

Future<void> showNotification() async {
  // Create a notification object.
  try{
    print("notification 1");
    const iosNotificatonDetail = DarwinNotificationDetails();
    const androidNotificationDetail = AndroidNotificationDetails(
          'channel_id', 'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/ic_launcher');
  final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetail,
      iOS: iosNotificatonDetail);
  await FlutterLocalNotificationsPlugin().show(1,
      'MeroAto', 
      'Your Driver is on the way',
      notificationDetails);
  }
  catch(e){
    print("The error is"+e.toString());
  }
}



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        sendRejectResponseToAllOtherNearByDriver('','');
        widget.callback!();
        widget.openFirstListener();
        setState(() {
          notifications=[];
        listen =false;
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Find Driver",style: TextStyle(color: Colors.black),),
          leading: BackButton(color: Colors.black,
          onPressed: (){
               sendRejectResponseToAllOtherNearByDriver('','');
            widget.openFirstListener();
             widget.callback!();
              setState(() {
                notifications=[];
        listen=false;
        });
          
             Get.back();
          },),
        ),
        body:Container(
              height: 800,
              child: notifications.length == 0
                  ? Container(
                      height: 400,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: Get.width,
                            
                          ),
                          Text(
                            'Loading....',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          width: MediaQuery.of(context).size.width ,
                    padding: EdgeInsets.all(5),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                         CounterOffer(
                          indexValue:index,
                          callback:deleteRequest,
                          driverProfileUrl:notifications[index]['driverProfileUrl']??'null',
                          distance: notifications[index]['distance'],
                          amount: notifications[index]['rate']
                                              ?.toString() ??
                                          'N/A',
                          label: notifications[index]['driver_name']
                                              ?.toString() ??
                                          'N/A',
                          image: notifications[index]['person_image']
                                              ?.toString() ??'assets/rideshare/person.jpg',
                          icon: Icons.star,
                          star: notifications[index]['driver_rating']
                                              ?.toString() ??
                                          'N/A',
                          service:
                              notifications[index]['address']
                                              ?.toString() ??
                                          'N/A',
                          phoneno:notifications[index]['phoneno']
                                              ?.toString() ??
                                          'N/A',
                          counterType:notifications[index]['requestType']
                                              ?.toString() ??
                                          'N/A',
                          offer1:notifications[index]['offer1']
                                              ?.toString() ??
                                          'N/A',
                          offer2:notifications[index]['offer2']
                                              ?.toString() ??
                                          'N/A',
                          offer3:notifications[index]['offer3']
                                              ?.toString() ??
                                          'N/A',
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AcceptDecline(
                                onpressed: () {
                                  print("The index is ");
                                  print(index);
                                  widget.openFirstListener();
                                  sendRejectResponse(notifications[index]['driverPlayerId'].toString(),
                                   notifications[index]['phoneno'].toString(),
                                   notifications[index]['verificationCode'].toString(),);
                                  deleteRequest(index);
                                },
                                bgcolor: Colors.red,
                                label: 'Decline',
                              ),
                              const SizedBox(width: 30),
                              AcceptDecline(
                                onpressed: () async{
                                  
                                  print("The widget.cash value is"+widget.cash.toString());
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String? userId =  prefs.getString('user_id');
                                  String randomCode = generateRandomCode(10);
                                  print("My Generated Tcode is"+randomCode);
                                  print(notifications[index]);
                                  String driverPlayerId = notifications[index]['driverPlayerId'].toString();
                                  String driverName = notifications[index]['driver_name'].toString();
                                  String rate = notifications[index]['rate'].toString();
                                  String time = notifications[index]['time'].toString();
                                  String phoneNo = notifications[index]['phoneno'].toString();
                                  String fromLocation = notifications[index]['fromLocation'].toString();
                                  String toLocation = notifications[index]['toLocation'].toString();
                                   String verificationCode = randomCode;
                                   String driver_id = notifications[index]['driver_id'].toString();
                                   String plate_no= notifications[index]['plate_no'].toString();
                                   String driver_profile_url = notifications[index]['driverProfileUrl'].toString();
                                  print("The notification list is");
                                  print(notifications);
                                  
                                  String amountValue = rate.replaceAll('Rs. ', '');
                                  int? amount  = int.parse(amountValue);
                                  AddRideShareSalesRepository repo = AddRideShareSalesRepository();
                                  repo.AddSales(userId!,
                                randomCode,driver_id,amount,'remarks',fromLocation,toLocation,widget.travelDistance);
                                  widget.orderAccepted(
                                    driverPlayerId,
                                    driverName,
                                    rate,
                                    time,
                                    phoneNo,
                                    plate_no,
                                    fromLocation,
                                    toLocation,
                                    verificationCode,
                                    driver_id,
                                    driver_profile_url
                                  );
                                  Timer(Duration(seconds: 5), () {
                                widget.openFirstListener();
                                    });
                                  
                                   sendAcceptResponse(notifications[index]['driverPlayerId'].toString(),
                                   notifications[index]['phoneno'].toString(),
                                   verificationCode,driver_id);
                                  // setState(() {
                                  // notifications=[];
                                  // //listen =false;
                                  //  });
                                if(widget.cash ==true){
                                  showNotification();
                                }
                                 
                                 Get.back();
                                //  Timer timer = Timer(const Duration(seconds: 1), () {
                                //   Get.back();
                                //  });
                                  
                                  // Get.to(WaitingPage(
                                  // )
                                  // );
                                  
                                  if(widget.cash ==false){
                                    Get.to(PaymentMethods(
                                      sessionBookingId:1,
                                       amount: '100',
                                        sessionBookingName: "Abiral"
                                        ));
                                  }
                                  
                                 
                                },
                                bgcolor: Colours.primarygreen,
                                label: 'Accept',
                              ),
                            ],
                          ),
                        ),
                       
                      ],
                    ),
                  );
                }
              ),
            ),
          
      ),
    );
  }
}
class CounterOffer extends StatefulWidget {
  String driverProfileUrl;
  int indexValue;
  Function callback;
  final String label;
  final String image;
  final String amount;
  final String star;
  final String service;
  final String counterType;
  final String phoneno;
  final String offer1;
  final String offer2;
  final String offer3;
  final IconData? icon;
  final String? distance;

  CounterOffer({
    required this.driverProfileUrl,
    required this.indexValue,
    required this.callback,
    required this.label,
    required this.image,
    required this.amount,
    required this.star,
    required this.service,
    required this.phoneno,
    required this.counterType,
    required this.offer1,
    required this.offer2,
    required this.offer3,
    required this.distance,
    this.icon,
    super.key,
  });

  @override
  State<CounterOffer> createState() => _CounterOfferState();
}

class _CounterOfferState extends State<CounterOffer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        if (controller.value == 0.0) {
          print("finished");
          widget.callback(widget.indexValue);
        }
        setState(() {});
      });
    controller.reverse(from: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
          ),
          Row(
            children: [
             //Image.asset(widget.image),
              
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            widget.amount,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(widget.icon,
                                    color: Colors.amber, size: 16),
                                Text(
                                  widget.star + '/5',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            Text(
                              widget.distance.toString() ,
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                        Text("Phone No : "+widget.phoneno,
                         style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey.shade500),
                        ),
                        Text(
                          "Location : "+widget.service,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey.shade500),
                        ),
                        widget.counterType == 'counter'
                            ? Text(
                                "Offer 1: " + widget.offer1,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              )
                            : Container(),
                        widget.counterType == 'counter'
                            ? Text(
                                "Offer 2: " + widget.offer2,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              )
                            : Container(),
                        widget.counterType == 'counter'
                            ? Text(
                                "Offer 3: " + widget.offer3,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    color: Colors.grey.shade500),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
             const SizedBox(width: 10),
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Container(
                    height: 80,
                    width: 80,
                    child: widget.driverProfileUrl.toString() == 'null'
                    ? Image.asset('assets/rideshare/person.jpg',
                    fit: BoxFit.cover,):
                    Image.network(widget.driverProfileUrl,
                    fit: BoxFit.cover,),
                  )),
              ),
                //
            ],
          ),
        ],
      ),
    );
  }
}

class AcceptDecline extends StatelessWidget {
  final void Function()? onpressed;
  final Color bgcolor;
  final String label;
  const AcceptDecline({
    required this.onpressed,
    required this.bgcolor,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
        ),
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
      ),
    );
  }
}
