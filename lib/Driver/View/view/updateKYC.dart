import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Controller/Function/capitalize.dart';
import 'package:food_app/Driver/Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import 'package:food_app/Driver/Controller/repository/getDriverDetails.dart';
import 'package:food_app/Driver/View/view/KYC/DocumentKYC.dart';
import 'package:food_app/Driver/View/view/PersonalPage.dart';
import 'package:food_app/User/View/constants/colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/bloc/Deliveries/deliveries_bloc.dart';
import '../../Model/DriverDetailModel.dart';
import '../components/delivery_container.dart';
import '../components/size_config.dart';
import '../components/transfer_container.dart';
// import 'DocumentPage.dart';

class UpdateKYC extends StatefulWidget {
  int index;
  Function callback;
  //index 0 means pending deliverires
  //index 1 means delivered
  //index 2 means transfer
  UpdateKYC({super.key, required this.index,required this.callback});

  @override
  State<UpdateKYC> createState() => _UpdateKYCState();
}

class _UpdateKYCState extends State<UpdateKYC> {
  String? did = '';
  getDriverId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    did = await prefs.getString('driverId');
    print("the driver id is");
    print(did);
    
  }
  bool loading =true;
  DriverDetailModel? model;
  getDriverDetail()async{
   
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   setState(() {
      loading= false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getDriverDetail();
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Update KYC",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "Personal",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig(context).textSize()),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Document",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig(context).textSize()),
                        ),
                      ),
                    ],
                  ),
                  loading == true?
                  Expanded(
                    child: Center(
                      child: Container(
                       height: 50,
                       width: 50,
                       child: CircularProgressIndicator(),),
                    ),
                  )
                  :
                  Expanded(
                          child: Container(
                            width: Get.width,
                            
                            child: TabBarView(
                              children: [
                                BlocProvider(
                                  create: (context) => SignUpBloc(),
                                  child: PersonalPage(
                                  callback:widget.callback,
                                  firstName:model!.driverDetails!.fullname.toString(),
                                  email:model!.driverDetails!.email.toString(), 
                                  phone:model!.driverDetails!.mobileNumber.toString(), 
                                  vehicle_type:model!.driverDetails!.vehicleType.toString(), 
                                  address:model!.driverDetails!.address.toString(),
                                  city:model!.driverDetails!.city.toString(),
                                  licensefilename:model!.driverDetails!.license.toString(),
                                  license_date:model!.driverDetails!.licenseExpiryDate.toString(),
                                  bill_book_date:model!.driverDetails!.billBookExpiryDate.toString(),
                                  address_temporary:model!.driverDetails!.address.toString(),
                                  citizenship:model!.driverDetails!.citizenship.toString(),
                                  vehicle_owner:model!.driverDetails!.vehicleOwner.toString(),
                                  profile:model!.driverDetails!.profileImage.toString(),
                                  driver_type: model!.driverDetails!.driverType.toString(),
                                  licenseNumber: model!.driverDetails!.driverLicenseNumber.toString(),
                                  vehicleBrand: model!.driverDetails!.vehicleBrand.toString(),
                                  vehicleColor: model!.driverDetails!.vehicleColor.toString(),
                                  vehicleNumber: model!.driverDetails!.vechicleNumber.toString(),
                                  vehiclePhoto: model!.driverDetails!.vechiclePhotos.toString(),
                                  billbook: model!.driverDetails!.billbook.toString(),
                                  ),
                                ),
                                DocumentKYC(
                                  callback:widget.callback,
                                  firstName:model!.driverDetails!.fullname.toString(),
                                  email:model!.driverDetails!.email.toString(), 
                                  phone:model!.driverDetails!.mobileNumber.toString(), 
                                  vehicle_type:model!.driverDetails!.vehicleType.toString(), 
                                  address:model!.driverDetails!.address.toString(),
                                  city:model!.driverDetails!.city.toString(),
                                  licensefilename:model!.driverDetails!.license.toString(),
                                  license_date:model!.driverDetails!.licenseExpiryDate.toString(),
                                  bill_book_date:model!.driverDetails!.billBookExpiryDate.toString(),
                                  address_temporary:model!.driverDetails!.address.toString(),
                                  citizenship:model!.driverDetails!.citizenship.toString(),
                                  vehicle_owner:model!.driverDetails!.vehicleOwner.toString(),
                                  profile:model!.driverDetails!.profileImage.toString(),
                                    driver_type: model!.driverDetails!.driverType.toString(),
                                  licenseNumber: model!.driverDetails!.driverLicenseNumber.toString(),
                                  vehicleBrand: model!.driverDetails!.vehicleBrand.toString(),
                                  vehicleColor: model!.driverDetails!.vehicleColor.toString(),
                                  vehicleNumber: model!.driverDetails!.vechicleNumber.toString(),
                                  vehiclePhoto: model!.driverDetails!.vechiclePhotos.toString(),
                                  billbook: model!.driverDetails!.billbook.toString(),
                                )
                              ],
                            ),
                          ),
                        ),
                  // BlocBuilder<DeliveriesBloc, DeliveriesState>(
                  //   builder: (context, state) {
                  //     if (state is DeliveriesLoadingState) {
                  //       return Expanded(
                  //         child: Container(
                  //           child: Center(
                  //             child: Container(
                  //               height: 50,
                  //               width: 50,
                  //               child: CircularProgressIndicator(
                  //                 color: Colours.primarygreen,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     if (state is DeliveriesLoadedState) {
                  //       return Expanded(
                  //         child: Container(
                  //           width: Get.width,
                  //           child: TabBarView(
                  //             children: [
                  //               BlocProvider(
                  //                 create: (context) => SignUpBloc(),
                  //                 child: PersonalPage(),
                  //               ),
                  //               DocumentPage()
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       return Center(
                  //         child: CircularProgressIndicator(
                  //           color: Colours.primarygreen,
                  //         ),
                  //       );
                  //     }
                  //   },
                  // )
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
