import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/repository/getDriverDetails.dart';
import '../../../../Controller/repository/updateDriver.dart';
import '../../../../Model/DriverDetailModel.dart';
import '../../../constants/colors.dart';
import '../LicenseForm.dart';

class ChooseBrand extends StatefulWidget {
  String label;
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
  ChooseBrand({super.key,required this.label,
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
  State<ChooseBrand> createState() => _ChooseBrandState();
}

class _ChooseBrandState extends State<ChooseBrand> {
  DriverDetailModel? model;
  getDriverDetail()async{
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   if(model!.driverDetails!.vehicleBrand.toString() !="null"){
     vehicleBrand.text = model!.driverDetails!.vehicleBrand.toString() ;
   }
   if(model!.driverDetails!.vehicleColor.toString() !="null"){
     vehicleColor.text = model!.driverDetails!.vehicleColor.toString() ;
   }
  }
  
  @override
  initState(){
    getDriverDetail();
    
  }

  // TextEditingController vehicleOwner =TextEditingController();
  
  TextEditingController vehicleBrand =TextEditingController();
  
  TextEditingController vehicleColor =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            widget.label,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
           
           Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text('Enter Vehicle Brand Name:',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                            controller: vehicleBrand,
                            decoration: null,
                          ),
                        ),
                      )
                      ),
                      SizedBox(
                      height: 15,
                    ),
                  ],
                )),
            ),
          
           Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text('Enter Vehicle Color Name:',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                            controller: vehicleColor,
                            decoration: null,
                          ),
                        ),
                      )
                      ),
                      SizedBox(
                      height: 15,
                    ),
                  ],
                )),
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
                                  widget.vehicle_type,
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
                                  vehicleBrand.text,
                                  vehicleColor.text,
                                  widget.vehicleNumber,
                                  widget.vehiclePhoto,
                                  widget.billbook
                                  );
                                  Get.back();
                                  Get.back();
                                  Get.back();
                                  // widget.callback(firstNameController.text,emailController.text,phonenumberController.text,);
                              // setState(() {
                              //    loading=false;
                              //    });
            },
          ),
        ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'choosebrandModel/colors.dart';

// class SelectMotorcyclesPage extends StatefulWidget {
//   const SelectMotorcyclesPage({super.key});

//   @override
//   State<SelectMotorcyclesPage> createState() => _SelectMotorcyclesPageState();
// }

// class _SelectMotorcyclesPageState extends State<SelectMotorcyclesPage> {
//   List<String> bikes = [
//     'Honda',
//     'Yamaha',
//     'Suzuki',
//     'Kawasaki',
//     'Harley-Davidson',
//     'Ducati',
//     'BMW Motorrad',
//     'KTM',
//     'Triumph',
//     'Royal Enfield',
//     'Bajaj',
//     'Aprilia',
//     'MV Agusta',
//     'Husqvarna',
//     'Indian Motorcycle',
//     'Moto Guzzi',
//     'Benelli',
//     'Zero Motorcycles',
//     'Kymco',
//     'Piaggio',
//   ];
//   List<bool> indexBool = [];
//   bool _customTileExpanded = false;
//   Map<int, bool> selectedColor = {};

//   List<Color> colorsList = MyColors.colorList;

//   @override
//   void initState() {
//     for (int i = 0; i < colorsList.length; i++) {
//       selectedColor.addAll({i: false});
//     }
//     log(selectedColor.toString());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//           elevation: 0,
//           leading: BackButton(
//             color: Colors.black,
//           ),
//           title: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
//               child: Container(
//                 height: 40,
//                 child: TextFormField(
//                   onChanged: (val) {
//                   },
//                   onFieldSubmitted: (val) {
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Search Brand',
//                     hintStyle: TextStyle(fontSize: 12),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(23)),
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                     suffixIconConstraints:
//                         BoxConstraints(minHeight: 20, minWidth: 30),
//                     suffixIcon: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                              GestureDetector(
//                                 onTap: () {
                                 
//                                 },
//                                 child: Icon(
//                                   Icons.clear,
//                                   color: Colors.grey,
//                                   size: 20,
//                                 ),
//                               ),
//                         SizedBox(width: 5),
//                         GestureDetector(
//                           onTap: () {
//                             FocusScope.of(context).unfocus();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(width: 0.1),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Icon(
//                                     // _showClearIcon
//                                     //     ? Icons.clear
//                                     //:
//                                     Icons.search_outlined,
//                                     color: Colors.black,
//                                     size: 20,
//                                   ),
//                                 )),
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                       ],
//                     ),
//                     //  GestureDetector(
//                     //   onTap: () {
//                     //     // if (_showClearIcon == true && TabIndex == 0) {
//                     //     //   setState(() {
//                     //     //     restaurantSearchKey.text = '';
//                     //     //     _showClearIcon = false;
//                     //     //     //SearchForTheKey('');
//                     //     //   });
//                     //     // }
//                     //     // if (_showClearIcon == true && TabIndex == 1) {
//                     //     //   setState(() {
//                     //     //     grocerySearchKey.text = '';
//                     //     //     _showClearIcon = false;
//                     //     //     //SearchForTheKey('');
//                     //     //   });
//                     //     // }
//                     //   },
//                     //   child:
//                     //   Opacity(
//                     //     opacity: 1,
//                     //     child:
//                     //     Icon(Icons.clear)
//                     //     //  Container(
//                     //     //     width: 0,
//                     //     //     decoration: BoxDecoration(
//                     //     //       shape: BoxShape.circle,
//                     //     //       border: Border.all(width: 0.3),
//                     //     //     ),
//                     //     //     child: Padding(
//                     //     //       padding: const EdgeInsets.all(8.0),
//                     //     //       child: Icon(
//                     //     //         // _showClearIcon
//                     //     //         //     ? Icons.clear
//                     //     //             //:
//                     //     //              Icons.search_outlined,
//                     //     //         color: Colors.black,
//                     //     //         size: 20,
//                     //     //       ),
//                     //     //     )),
//                     //   ),
//                     // ),
//                   ),
//                 ),
//               ),
//             ),
            
//           backgroundColor: Colors.white,
//         ),
//       body: ListView.builder(
//         itemCount: bikes.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
//             child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(15))),
//                 child: ExpansionTile(
//                   title: Text(
//                     bikes[index],
//                   ),
//                   children: [
//                     Column(
//                       children: [
//                         Text("AB motors"),
//                         Text('pick color'),
//                         GridView.builder(
//                           shrinkWrap: true,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 4),
//                           itemCount: colorsList.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: Get.width * 0.04,
//                                   vertical: Get.height * 0.035),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   log(selectedColor[index].toString());
//                                   //make everything else false
//                                   selectedColor
//                                       .updateAll((key, value) => false);

//                                   //change current selected color
//                                   selectedColor[index] = true;
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 1,
//                                           color: selectedColor[index]!
//                                               ? Colors.green
//                                               : Colors.grey),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Container(
//                                         height: 15,
//                                         width: 15,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(width: 1),
//                                             shape: BoxShape.circle,
//                                             color: colorsList[index]),
//                                       ),
//                                       Text("Teal")
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           child: Text("Pick this transporation"),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: colorsList[2]),
//                         )
//                       ],
//                     )
//                   ],
//                   onExpansionChanged: (bool expanded) {},
//                 )),
//           );
//         },
//       ),
//     );
//   }
// }