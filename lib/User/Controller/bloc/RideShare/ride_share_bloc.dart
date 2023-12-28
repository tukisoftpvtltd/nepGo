import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/RideShare/Components/MainBottomSheet.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/nearby_driver_model.dart';
import '../../../View/Screens/HomeScreens/Home/RideShare/Views/RideShareDriverPage.dart';
import '../../repositories/get_nearby_driver.dart';
import 'package:http/http.dart' as http;
part 'ride_share_event.dart';
part 'ride_share_state.dart';

bool canProcessMessages1 = true;

class RideShareBloc extends Bloc<RideShareEvent, RideShareState> {
  RideShareBloc() : super(RideShareInitial()) {
    String category;
    String yourLocation;
    String destinationLocation;
    String fare;
    String comment;
    double sourceLatitude;
    double sourceLongitude;
    double destinationLatitude;
    double destinationLongitude;
    List notifications = [];
    BuildContext blocContext;
    
    on<RideShareEvent>((event, emit) {
      // TODO: implement event handler
    });
    // on<driverFound>((event, emit) {
    //   emit(diverFoundState());
    // });
    on<findRideShareDriver>((event, emit) async{
      category = event.category;
      yourLocation = event.yourLocation;
      destinationLocation = event.destinationLocation;
      fare = event.fare;
      comment = event.comment;
      sourceLatitude = event.sourceLat;
      sourceLongitude = event.sourceLong;
      destinationLatitude = event.destinationLat;
      destinationLongitude = event.destinationLong;
      blocContext = event.context;
      if (yourLocation == '') {
        print("location Error");
        emit(yourlocationError());
      } else if (destinationLocation == '') {
            print("Destination Error");
        emit(destinationlocationError());
      } else if (fare == '') {
        print("Fare Error");
        emit(fareError());
      }
      else {
        emit(searchingForDriver());
        List AllPlayerIds = [];

        sendNotificationToNearByRideShareDrivers() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String username = await prefs.getString('fname')!;
          String phoneNo = await prefs.getString('phoneno')!;
           String? token ='';
//    if (Platform.isIOS) {
//     FirebaseMessaging.instance.getAPNSToken().then((tokenValue) {
//   if (token != null) {
//     token = tokenValue;
//   } else {
//     token = tokenValue;
//   }

// });
//   } 
//   else{
await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('TOken$value');
              token = value;
            });
          });
  //}
          print("the token is");
          print(token);
          NearByDriverRepository repo = NearByDriverRepository();
          NearByDriverModel model =
              await repo.getNearByDriverData('28.105', '83.8659', '1','0');
          if (model.nearByDriverPlayerIds != []) {
            for (int i = 0; i < model.nearByDriverPlayerIds!.length; i++) {
              print(model.nearByDriverPlayerIds![i].playerId);
              AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
            }
            try {
              for (int i = 0; i < AllPlayerIds.length; i++) {
                var data = {
                  'to': AllPlayerIds[i],
                  'priority': 'high',
                  'data': {
                    "passengerName": username,
                    "phoneNo": phoneNo,
                    "category": category,
                    "amount": fare,
                    "fromLocation": yourLocation.toString(),
                    "tolocation": destinationLocation.toString(),
                    "distance": '1.13 KM',
                    "customerPlayerId": token,
                    'sourceLatitude': sourceLatitude.toString(),
                    'sourceLongitude': sourceLongitude.toString(),
                    'destinationLatitude': destinationLatitude.toString(),
                    'destinationLongitude': destinationLongitude.toString()
                  }
                };
                print(data);
                print("posting Data to");
                print(AllPlayerIds[i]);
                print(AllPlayerIds);
                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
                    });
              }
            } catch (e) {
              print("Error Occured");
            }
          }
        }

        sendNotificationToNearByRideShareDrivers();
          
           emit(searchingForDriver());
      StreamSubscription<RemoteMessage> messageSubscription;
       callback() {
          notifications = [];
          notifications.length = 0;
          print(notifications);
          print(notifications.length);
          print("cleared notification");
          canProcessMessages1 = true;
         // messageSubscription.cancel();
        }
        Map<String,dynamic> firstData ={};   
        bool firstMessageReceived = false;
         
            await FirebaseMessaging.onMessage.listen((RemoteMessage message){
            print(canProcessMessages1);
            if (canProcessMessages1 == true) {
              print("Message received 111");
              print("Data is in new page 111");
              print(message.data);
              firstData= message.data;
              notifications.add(message.data);
              print("the notification length is");
              print(notifications.length);
              if (notifications.length == 1) {
                canProcessMessages1 = false;
                emit(firstDriverFound(firstData));
              }
            }
            canProcessMessages1 = false;
          });
          

        //}
      
             
    
        // callback() {
        //   notifications = [];
        //   notifications.length = 0;
        //   print(notifications);
        //   print(notifications.length);
        //   print("cleared notification");
        //   canProcessMessages = true;
        //  // messageSubscription.cancel();
        // }
//          final player = AudioPlayer();

//  playNotification(){
//   player.play(AssetSource('notification.wav'));
//  }   
       
       
        
      }
    });
  }
}
 