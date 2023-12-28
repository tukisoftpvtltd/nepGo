import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../User/Controller/repositories/controlSystem/getControlSystemPlayerId.dart';
import '../../../User/Model/nearbyControlSystemModel.dart';
import '../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../Controller/repository/updateDelivery.dart';
import 'home_page.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  int count =0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? barcode; 
  bool loading =false;
  String? did='';
  bool isScanned = false;
   getDriverId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    did = prefs.getString('driverId');
   }

  @override
  void initState() {
    getDriverId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          Scaffold(
            body: QRView(
              key: qrKey,
              onQRViewCreated:_onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderLength: 30,
                borderRadius: 10,
                borderWidth: 5,
                borderColor: Colors.white,
                cutOutSize: Get.width *0.8,
              ),
            ),
          ),
           
          loading ?
          Center(child: Container(
            height: 50,
            width: 50,
          child: CircularProgressIndicator())):Container(),
        ],
      ),
    );
  }
  String driver_type = '0';
  getDriverType()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    driver_type = prefs.getString('driver_type')??'0';
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    barcode ==null ?
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        loading =true;
        isScanned =true;
        barcode = scanData;
      });
      print("The data is");
      print(barcode?.code.toString());
      String? tCode = barcode?.code.toString();
      
      if(count ==0){
        UpdateDeliveriesRepository repo = UpdateDeliveriesRepository();
      repo.UpdateDeliveries(tCode!, did!, '1');
      sendNotifications();
      setState(() {
        loading =false;
      });
      getDriverType();
      Get.offAll(
        BlocProvider(
        create: (context) => SignInBloc(context),
        child: HomePage(
          driver_type: driver_type,
        ),
      )
      );
      count++;
      } 
      
    }):(){
      print("Already Scanned");
    };
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
sendNotifications()async{
  List notifications=[];
  String PlayerId ='';
          var status = await OneSignal.shared.getDeviceState();
    String? playerId = status!.userId;
    print("Your player id is");
    print(playerId);
  NearByControlSytemRepository repo0 = NearByControlSytemRepository();
   NearByControlSytemModel model0 = await repo0.getNearByDriverData('28.105', '83.8659');
  PlayerId = model0.nearestControlSystem!.playerId.toString();
  notifications.add( OSCreateNotification(
      heading: 'Order Completed',
      playerIds: [PlayerId] ,
      content: "The order was completed",
      
      
    ));
     try{
    await OneSignal.shared.postNotification(notifications[0]);
      }
      catch(e){
        print("The error is "+e.toString());
      }
}