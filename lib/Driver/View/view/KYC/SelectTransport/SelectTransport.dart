import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/repository/getDriverDetails.dart';
import '../../../../Model/DriverDetailModel.dart';
import '../../../components/colors.dart';
import 'ChooseBrand.dart';

class SelectTransport extends StatefulWidget {
   Function callback;
  String firstName;
  String phone;
  String email;
  String vehicle_type;
  String address;
  String city;
  String licensefilename;
  String license_date;
  String bill_book_date;
  String address_temporary;
  String citizenship;
  String vehicle_owner;
  String profile;
  String driver_type;
  String licenseNumber;
  String vehicleBrand;
  String vehicleColor;
  String vehicleNumber;
  String vehiclePhoto;
  String billbook;
  SelectTransport({super.key,
  required this.callback,
  required this.firstName,
  required this.phone,
  required this.email,
  required this.vehicle_type,
  required this.address,
  required this.city,
  required this.licensefilename,
  required this.license_date,
  required this.bill_book_date,
  required this.address_temporary,
  required this.citizenship,
  required this.vehicle_owner,
  required this.profile,
    required this.driver_type,
  required this.licenseNumber,
  required this.vehicleBrand,
  required this.vehicleColor,
  required this.vehicleNumber,
  required this.vehiclePhoto,
  required this.billbook,
  });

  @override
  State<SelectTransport> createState() => _SelectTransportState();
}

class _SelectTransportState extends State<SelectTransport> {
  bool motorbike =false;
  bool taxi =false;
  bool scooter =false;
  bool auto =false;

  DriverDetailModel? model;
   getDriverDetail()async{
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   print("The vehicle type is"+model!.driverDetails!.vehicleType.toString());
   if(model!.driverDetails!.vehicleType.toString() =="0"){
    print('none');
     setState(() {
      motorbike =true;
      taxi =true;
      scooter =true;
      auto =true;
     });
   }
   if(model!.driverDetails!.vehicleType.toString() =="1"){
    print('bike');
     setState(() {
      motorbike =true;
      taxi =false;
      scooter =false;
      auto =false;
     });
   }
   if(model!.driverDetails!.vehicleType.toString() =="2"){
    print('taxi');
     setState(() {
      motorbike =false;
      taxi =true;
      scooter =false;
      auto =false;
     });
   }
   if(model!.driverDetails!.vehicleType.toString() =="3"){
    print('scooter');
     setState(() {
      motorbike =false;
      taxi =false;
      scooter =true;
      auto =false;
     });
   }
   if(model!.driverDetails!.vehicleType.toString() =="4"){
    print('auto');
     setState(() {
      motorbike =false;
      taxi =false;
      scooter =false;
      auto =true;
     });
   }

  
  }
   @override
  initState(){
    getDriverDetail();
    // if(widget.licenseNumber.toString() != 'null'){
      
    // licenseNumberController.text = widget.licenseNumber;
    // }
    // if(widget.licensefilename.toString() != 'null'){
      
    // licenseImage = widget.licensefilename;
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Choose Transport",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
               motorbike ==true?
                Get.to(ChooseBrand(
                  label:'Motorbike',
                   callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:"1",
   address: widget.address,
   city: widget.city,
   licensefilename : widget.licensefilename,
   license_date : widget.license_date,
   bill_book_date : widget.bill_book_date,
   address_temporary : widget.address_temporary,
   citizenship : widget.citizenship,
   vehicle_owner : widget.vehicle_owner,
   profile : widget.profile,
   driver_type: widget.driver_type,
   licenseNumber: widget.licenseNumber,
   vehicleBrand: widget.vehicleBrand,
   vehicleColor: widget.vehicleColor,
   vehicleNumber: widget.vehicleNumber,
   vehiclePhoto: widget.vehiclePhoto,
   billbook: widget.billbook,
                )
               ):(){};
              },
              child: SelectCard(imagePath: 'assets/rideshare/motorbike_choice.png',
               label: 'Motorbike',
               enable: motorbike,)),

            GestureDetector(
              onTap: (){
                taxi == true?
                Get.to(ChooseBrand(label:'Taxi',
                callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:"2",
   address: widget.address,
   city: widget.city,
   licensefilename : widget.licensefilename,
   license_date : widget.license_date,
   bill_book_date : widget.bill_book_date,
   address_temporary : widget.address_temporary,
   citizenship : widget.citizenship,
   vehicle_owner : widget.vehicle_owner,
   profile : widget.profile,
   driver_type: widget.driver_type,
   licenseNumber: widget.licenseNumber,
   vehicleBrand: widget.vehicleBrand,
   vehicleColor: widget.vehicleColor,
   vehicleNumber: widget.vehicleNumber,
   vehiclePhoto: widget.vehiclePhoto,
   billbook: widget.billbook,)):(){};
              },
              child: SelectCard(imagePath: 'assets/rideshare/car_choice.png', label: 'Taxi',enable: taxi,)),

            GestureDetector(
              onTap: (){
                scooter ==true?
                Get.to(ChooseBrand(label:'Scooter',
                callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:"3",
   address: widget.address,
   city: widget.city,
   licensefilename : widget.licensefilename,
   license_date : widget.license_date,
   bill_book_date : widget.bill_book_date,
   address_temporary : widget.address_temporary,
   citizenship : widget.citizenship,
   vehicle_owner : widget.vehicle_owner,
   profile : widget.profile,
   driver_type: widget.driver_type,
   licenseNumber: widget.licenseNumber,
   vehicleBrand: widget.vehicleBrand,
   vehicleColor: widget.vehicleColor,
   vehicleNumber: widget.vehicleNumber,
   vehiclePhoto: widget.vehiclePhoto,
   billbook: widget.billbook,)
  ):(){};
              },
              child: SelectCard(
                imagePath: 'assets/rideshare/scooter_choice.png',
                 label: 'Scooter',
                 enable: scooter,)),
            
            GestureDetector(
              onTap: (){
                auto ==true?
                Get.to(
                  ChooseBrand(label:'Auto',
                callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:"4",
   address: widget.address,
   city: widget.city,
   licensefilename : widget.licensefilename,
   license_date : widget.license_date,
   bill_book_date : widget.bill_book_date,
   address_temporary : widget.address_temporary,
   citizenship : widget.citizenship,
   vehicle_owner : widget.vehicle_owner,
   profile : widget.profile,
   driver_type: widget.driver_type,
   licenseNumber: widget.licenseNumber,
   vehicleBrand: widget.vehicleBrand,
   vehicleColor: widget.vehicleColor,
   vehicleNumber: widget.vehicleNumber,
   vehiclePhoto: widget.vehiclePhoto,
   billbook: widget.billbook,)
   ):(){};
              },
              child: SelectCard(
                imagePath: 'assets/rideshare/auto_choice.png',
                 label: 'Auto',
                 enable: auto,)),
          ],
        ),
      ),
    );
  }
}
class SelectCard extends StatefulWidget {
  String imagePath;
  String label;
  bool enable;
  SelectCard({super.key,required this.imagePath,required this.label,required this.enable});

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: widget.enable ==true ?Colours.primarygreen:Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Container(
                    width: Get.width/4,
                     child: Image.asset(
                      widget.imagePath
                      ,width: 30,height: 30,),
                   ),
                   Container(
                    width: Get.width/2.2,
                    child: Text(widget.label,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                  Container(
                    width: Get.width/5,
                    child: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
    );
  }
}