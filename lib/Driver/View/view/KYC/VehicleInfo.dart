import 'package:flutter/material.dart';
import 'package:food_app/Driver/View/view/KYC/BillBook/updateBillbookPhoto.dart';
import 'package:food_app/Driver/View/view/KYC/NumberPlate/updateNumberPlate.dart';
import 'package:food_app/Driver/View/view/KYC/SelectTransport/SelectTransport.dart';
import 'package:food_app/Driver/View/view/KYC/VehiclePhoto/updateVehiclePhoto.dart';
import 'package:get/get.dart';

import '../../../Controller/repository/getDriverDetails.dart';
import '../../../Model/DriverDetailModel.dart';

class VehicleInfo extends StatefulWidget {
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
  VehicleInfo({super.key,
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
  required this.billbook,});

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  String vehicleBrand ='';
  String vehicleColor ='';

  DriverDetailModel? model;
   getDriverDetail()async{
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   
   if(model!.driverDetails!.vehicleBrand.toString() !="null"){
    setState(() {
      vehicleBrand =model!.driverDetails!.vehicleBrand.toString();
    });
     
   }
   if(model!.driverDetails!.vehicleColor.toString() !="null"){
    setState(() {
      vehicleColor =model!.driverDetails!.vehicleColor.toString();
    });
     
   }
   }
   @override
  void initState() {
    getDriverDetail();
    // TODO: implement initState
    super.initState();
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
            "Vehicle Information",
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
                Get.to(SelectTransport(
                           callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:widget.vehicle_type,
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
                ));
              },
              child: InforCard2(imagePath: 'assets/rideshare/driver_car.png',
               label: 'Choose transport',
               sublabel : vehicleBrand + ' , '+ vehicleColor)),
            
            GestureDetector(
              onTap: (){
                Get.to(UpdateNumberPlate(
                          callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:widget.vehicle_type,
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
                ));
              },
              child: InforCard(imagePath: 'assets/rideshare/license_plate.png', label: 'Number plate')),
            
            GestureDetector(
               onTap: (){
                Get.to(UpdateVehiclePhoto(
                          callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:widget.vehicle_type,
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
                ));
              },
              child: InforCard(imagePath: 'assets/rideshare/photo.png', label: 'Photo of your vehicle')),
            
            GestureDetector(
                onTap: (){
                Get.to(UpdateBillBookPhoto(
                          callback:widget.callback,
   firstName:widget.firstName,
   phone:widget.phone,
   email:widget.email,
   vehicle_type:widget.vehicle_type,
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
                ));
              },
              child: InforCard(imagePath: 'assets/rideshare/billbook.png', label: 'Billbook')),
          ],
        ),
      ),
    );
  }
}



class InforCard2 extends StatefulWidget {
  String imagePath;
  String label;
  String sublabel;
  InforCard2({super.key,
  required this.imagePath,
  required this.label,
  required this.sublabel});

  @override
  State<InforCard2> createState() => _InforCard2State();
}

class _InforCard2State extends State<InforCard2> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                width: Get.width,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF8C8C8C)),
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
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0,10,0,0),
                         child: Container(
                          width: Get.width/2.2,
                          child: Text(widget.label,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                       ),
                         Container(
                        width: Get.width/2.2,
                        child: Text(widget.sublabel,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),)),
                     ],
                   ),
                  Container(
                    width: Get.width/5,
                    child: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
    );
  }
}

class InforCard extends StatefulWidget {
  String imagePath;
  String label;
  InforCard({super.key,required this.imagePath,required this.label});

  @override
  State<InforCard> createState() => _InforCardState();
}

class _InforCardState extends State<InforCard> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                width: Get.width,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF8C8C8C)),
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