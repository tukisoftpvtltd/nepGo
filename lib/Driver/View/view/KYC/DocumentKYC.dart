import 'package:flutter/material.dart';
import 'package:food_app/Driver/View/view/KYC/VehicleInfo.dart';
import 'package:get/get.dart';

import 'LicenseForm.dart';

class DocumentKYC extends StatefulWidget {
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
  DocumentKYC({super.key,
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
  State<DocumentKYC> createState() => _DocumentKYCState();
}

class _DocumentKYCState extends State<DocumentKYC> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Column(
        children: [
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){Get.to(LicenseForm(
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

            ));},
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
                    'assets/rideshare/driver_license.png'
                    ,width: 30,height: 30,),
                 ),
                 Container(
                  width: Get.width/2.5,
                  child: Text('Driver License',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                Container(
                  width: Get.width/4,
                  child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
           SizedBox(height: 20,),
          GestureDetector(
             onTap: (){
              Get.to(VehicleInfo(
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
                    'assets/rideshare/driver_car.png'
                    ,width: 30,height: 30,),
                 ),
                 Container(
                  width: Get.width/2.5,
                  child: Text('Vehicle Information',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                Container(
                  width: Get.width/4,
                  child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}