import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/repository/getDriverDetails.dart';
import '../../../../Controller/repository/updateDriver.dart';
import '../../../../Model/DriverDetailModel.dart';
import '../../../constants/colors.dart';
import '../LicenseForm.dart';

class UpdateNumberPlate extends StatefulWidget {
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
   UpdateNumberPlate({super.key,
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
  State<UpdateNumberPlate> createState() => _UpdateNumberPlateState();
}

class _UpdateNumberPlateState extends State<UpdateNumberPlate> {
  TextEditingController numberPlateController = TextEditingController();
  DriverDetailModel? model;
    getDriverDetail()async{
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   if(model!.driverDetails!.vechicleNumber.toString() !="null"){
     numberPlateController.text  = model!.driverDetails!.vechicleNumber.toString();
   }
  }

  @override
  void initState() {
   getDriverDetail();
    // TODO: implement initState
    super.initState();
  }
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Number Plate",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
          
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text('Enter your number plate',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 50,
                              width: Get.width-100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xff8C8C8C)),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: numberPlateController,
                                    decoration: null,
                                  ),
                                ),
                              )
                              ),
                          ),
                            SizedBox(
                            height: 15,
                          ),
                           Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton2(
            label: 'Submit',
            color: Colours.primarygreen,
            onpressed: (){
              UpdateDriver repo = UpdateDriver();
                                
                                repo.UpdateDriverData(
                                  widget.firstName,
                                  widget.email,
                                  widget.phone,
                                  '0',
                                  widget.address,
                                  widget.city,
                                  widget.licensefilename,
                                  widget.license_date,
                                  widget.bill_book_date,
                                  widget.address_temporary,
                                  widget.citizenship,
                                  widget.vehicle_owner,
                                  widget.profile,
                                  '1',
                                  widget.licenseNumber,
                                  widget.vehicleBrand,
                                  widget.vehicleColor,
                                  numberPlateController.text,
                                  widget.vehiclePhoto,
                                  widget.billbook
                                  );
                                  Get.back();
                                  // Get.back();
                                 // widget.callback(firstNameController.text,emailController.text,phonenumberController.text,);
                              setState(() {
                                 loading=false;
                                 });
            },
          ),
        ),
                        ],
                      )),
                  ),
          ),
        ],
      ),
    );
  }
}