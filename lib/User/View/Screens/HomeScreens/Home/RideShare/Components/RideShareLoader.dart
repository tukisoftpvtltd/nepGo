import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Controller/repositories/get_nearby_driver.dart';
import '../../../../../../Model/nearby_driver_model.dart';
import 'package:http/http.dart'as http;

class RideShareLoader extends StatefulWidget {
  String userId;
  Function callback;
  RideShareLoader({super.key,
  required this.userId,
  required this.callback});

  @override
  State<RideShareLoader> createState() => _RideShareLoaderState();
}

class _RideShareLoaderState extends State<RideShareLoader> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey.withOpacity(0.1), 
      body: Stack(
        children: [
            Center(child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(0),
            ),
              child: ClipRect(
                child: Image.asset(
                  'assets/images/animation1.gif',
                fit: BoxFit.fitHeight,),
              ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,45,10,0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                      sendRejectResponseToAllOtherNearByDriver('asda','1234');
                      widget.callback();
                    }
                    ,
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(0),
                        color: Colors.white,
                         //widget.callback();
                        child: Icon(Icons.cancel,size: 40,)
                      ),
                    ),
                  ),
              ),
              ),
        ],
          ),
    );
  }
}