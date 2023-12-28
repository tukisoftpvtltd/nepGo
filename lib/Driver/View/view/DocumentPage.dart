// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:food_app/Driver/Controller/repository/updateDriver.dart';
// import 'package:food_app/Driver/View/components/colors.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../User/View/widgets/button.dart';
// import '../../Controller/repository/uploadImage.dart';
// import 'package:intl/intl.dart';

// import '../constants/Constants.dart';

// class DocumentPage extends StatefulWidget {
//   final String fullname;
//   final String email;
//   final String mobile_number;
//   final String vehicle_type;
//   final String address;
//   final String city;
//   final String licensefilename;
//   final String license_date;
//   final String bill_book_date;
//   final String address_temporary;
//   final String citizenship;
//   final String vehicle_owner;
//   final String profile;

//   DocumentPage({super.key,
//   required this.fullname,
//     required this.email,
//     required this.mobile_number,
//     required this.vehicle_type,
//     required this.address,
//     required this.city,
//     required this.licensefilename,
//     required this.license_date,
//     required this.bill_book_date,
//     required this.address_temporary,
//     required this.citizenship,
//     required this.vehicle_owner,
//     required this.profile
//   });

//   @override
//   State<DocumentPage> createState() => _DocumentPageState();
// }

// class _DocumentPageState extends State<DocumentPage> {
//   final DateFormat formatter = DateFormat('yyyy-MM-dd'); // Date format
//   DateTime? _licenseExpireDate;
//   DateTime? _billBookExpireDate;


  
//   Future<void> _selectLicenseExpireDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _licenseExpireDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _licenseExpireDate) {
//       setState(() {
//         _licenseExpireDate = picked;
//       });
//     }
//   }

//   Future<void> _selectBillBookExpireDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _billBookExpireDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _billBookExpireDate) {
//       setState(() {
//         _billBookExpireDate = picked;
//       });
//     }
//   }
//   bool loading =false;
//   File? pickedProfileImage;
//   final ImagePicker profilePicker = ImagePicker();
//   String ProfileImage ='null';

//     Future<void> _pickProfileImageFromGallary() async {
//     final XFile? image = await profilePicker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     setState(() {
//       pickedProfileImage = File(image.path);
//     });
//     final pickedImage = File(image.path);

//     int sizeInBytes = await pickedImage.length();
//     double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

//     String fileName = pickedImage.uri.pathSegments.last;
//     String fileExtension = fileName.split('.').last;

//     final String randomString = generateRandomString(20);

//     print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
//     print('Image Name: $randomString.$fileExtension');
//     setState(() {
//       ProfileImage = '$randomString.$fileExtension';
//     });
//     print("the profile image is");
//     print(ProfileImage);


//     List<int> imageBytes = await pickedImage!.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     print('Image in Base64: data:image/jpeg;base64,$base64Image');
//     UploadImageRepo repo = UploadImageRepo();
//     repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
//   }
//   }
//    Future<void> _pickProfileImageFromCamera() async {
//      final XFile? image = await profilePicker.pickImage(source: ImageSource.camera);
//   if (image != null) {
//     setState(() {
//       pickedProfileImage = File(image.path);
//     });
//     final pickedImage = File(image.path);

//     int sizeInBytes = await pickedImage.length();
//     double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

//     String fileName = pickedImage.uri.pathSegments.last;
//     String fileExtension = fileName.split('.').last;

//     final String randomString = generateRandomString(20);

//     print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
//     print('Image Name: $randomString.$fileExtension');
//     setState(() {
//       ProfileImage = '$randomString.$fileExtension';
//     });
//     print("the profile image is");
//     print(ProfileImage);


//     List<int> imageBytes = await pickedImage!.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     print('Image in Base64: data:image/jpeg;base64,$base64Image');
//     UploadImageRepo repo = UploadImageRepo();
//     repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
//   }
//   }

//   File? pickedCitizenImage;
//   final ImagePicker citizenPicker = ImagePicker();
//   String citizenshipName = '';

//   String generateRandomString(int length) {
//   const String charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//   final Random random = Random();
//   StringBuffer result = StringBuffer();

//   for (int i = 0; i < length; i++) {
//     int randomIndex = random.nextInt(charset.length);
//     result.write(charset[randomIndex]);
//   }

//   return result.toString();
// }

// Future<void> _pickCitizenImageFromGallery() async {
//   final XFile? image = await citizenPicker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     setState(() {
//       pickedCitizenImage = File(image.path);
//     });
//     final pickedImage = File(image.path);

//     int sizeInBytes = await pickedImage.length();
//     double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

//     String fileName = pickedImage.uri.pathSegments.last;
//     String fileExtension = fileName.split('.').last;

//     final String randomString = generateRandomString(20);

//     print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
//     print('Image Name: $randomString.$fileExtension');
//     setState(() {
//       citizenshipName = '$randomString.$fileExtension';
//     });


//     List<int> imageBytes = await pickedImage!.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     print('Image in Base64: data:image/jpeg;base64,$base64Image');
//     UploadImageRepo repo = UploadImageRepo();
//     repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
//   }
// }

//    Future<void> _pickCitizenImageFromCamera() async {
//     final XFile? image = await citizenPicker.pickImage(source: ImageSource.camera);
//   if (image != null) {
//     setState(() {
//       pickedCitizenImage = File(image.path);
//     });
//     final pickedImage = File(image.path);

//     int sizeInBytes = await pickedImage.length();
//     double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

//     String fileName = pickedImage.uri.pathSegments.last;
//     String fileExtension = fileName.split('.').last;

//     final String randomString = generateRandomString(20);

//     print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
//     print('Image Name: $randomString.$fileExtension');
//     setState(() {
//       citizenshipName = '$randomString.$fileExtension';
//     });


//     List<int> imageBytes = await pickedImage!.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     print('Image in Base64: data:image/jpeg;base64,$base64Image');
//     UploadImageRepo repo = UploadImageRepo();
//     repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
//   }
//   }

//    File? pickedLicenseImage;
//   final ImagePicker licensePicker = ImagePicker();
//   String? LicenseFileName;

//     Future<void> _pickLicenseImageFromGallary() async {
//     final XFile? image = await licensePicker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     setState(() {
//       pickedLicenseImage = File(image.path);
//     });
//     final pickedImage = File(image.path);

//     int sizeInBytes = await pickedImage.length();
//     double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

//     String fileName = pickedImage.uri.pathSegments.last;
//     String fileExtension = fileName.split('.').last;

//     final String randomString = generateRandomString(20);

//     print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
//     print('Image Name: $randomString.$fileExtension');
//     setState(() {
//       LicenseFileName = '$randomString.$fileExtension';
//     });


//     List<int> imageBytes = await pickedImage!.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     print('Image in Base64: data:image/jpeg;base64,$base64Image');
//     UploadImageRepo repo = UploadImageRepo();
//     repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
//   }
//   }
//    Future<void> _pickLicenseImageFromCamera() async {
//     final XFile? image = await licensePicker.pickImage(source: ImageSource.camera);
//   if (image != null) {
//     setState(() {
//       pickedLicenseImage = File(image.path);
//     });
//     final pickedImage = File(image.path);

//     int sizeInBytes = await pickedImage.length();
//     double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

//     String fileName = pickedImage.uri.pathSegments.last;
//     String fileExtension = fileName.split('.').last;

//     final String randomString = generateRandomString(20);

//     print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
//     print('Image Name: $randomString.$fileExtension');
//     setState(() {
//       LicenseFileName = '$randomString.$fileExtension';
//     });


//     List<int> imageBytes = await pickedImage!.readAsBytes();
//     String base64Image = base64Encode(imageBytes);
//     print('Image in Base64: data:image/jpeg;base64,$base64Image');
//     UploadImageRepo repo = UploadImageRepo();
//     repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
//   }
//   }
//   updateCitizenship(){
//     UpdateDriver repo = UpdateDriver();
//     repo.UpdateDriverData
//     (widget.fullname,
//      widget.email,
//       widget.mobile_number,
//        widget.vehicle_type,
//         widget.address, widget.city,
//          LicenseFileName!,
//           formatDate(_licenseExpireDate).toString(),
//            formatDate( _billBookExpireDate).toString(),
//         widget.address_temporary, 
//         citizenshipName,
//          widget.vehicle_owner,
//          ProfileImage,
//          '1',
//          ''
//          );
//   }

//   initState(){
//     citizenshipName = widget.citizenship;
//     LicenseFileName = widget.licensefilename;
//     if(widget.license_date != 'null' && widget.bill_book_date!= 'null' ){
//        _licenseExpireDate =  DateTime.parse(widget.license_date);
//     _billBookExpireDate = DateTime.parse(widget.bill_book_date);
//     }
//     else{
//       _licenseExpireDate =  DateTime.now();
//     _billBookExpireDate = DateTime.now();
//     }
   
//   }
//   String formatDate(DateTime? date) {
//     if (date == null) return 'Select a date';
//     final formatter = DateFormat('yyyy-MM-dd');
//     return formatter.format(date);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Text("Profile Picture"),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 width: double.infinity,
//                 height: 320,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                            _pickProfileImageFromGallary();
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Image.asset(
//                                     'assets/images/gallary.png',
//                                     height: 40,
//                                     width: 40,)),
//                               ),
//                               Text('Select a image'),
//                             ],
//                           ),
//                         ),
                        
//                         GestureDetector(
//                           onTap: (){
//                                 _pickProfileImageFromCamera();
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Image.asset('assets/images/camera.png',
//                                   fit: BoxFit.cover)),
//                               ),
//                               Text('Open Camera'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10,),
//                   pickedProfileImage != null
//             ? Container(
//               height:200,
//               width: 200,
//               child: Image.file(pickedProfileImage!,
//               fit: BoxFit.cover,))
//             :ProfileImage == 'null'? Container(
//               height: 200,
//               width: 200,
//               child: Image.asset('assets/images/imageLoader.png',
//               fit: BoxFit.cover,),
//             ):Container(
//               height: 200,
//               width: 200,
//               child: FadeInImage.assetNetwork(
//                 placeholder: 'assets/images/imageLoader.png',
//                 image: '$baseUrl/driverimages/${ProfileImage}',
//                 fit: BoxFit.cover,
//               ),
//             )

//                   ],
//                 ),
//               )
//            ,
//            SizedBox(height: 10,),
//            Text("Citizenship"),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 width: double.infinity,
//                 height: 320,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                            _pickCitizenImageFromGallery();
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Image.asset(
//                                     'assets/images/gallary.png',
//                                     height: 40,
//                                     width: 40,)
//                                     ),
//                               ),
//                               Text('Select a image'),
//                             ],
//                           ),
//                         ),
                        
//                         GestureDetector(
//                           onTap: (){
//                                 _pickCitizenImageFromCamera();
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Image.asset('assets/images/camera.png',
//                                   fit: BoxFit.cover)),
//                               ),
//                               Text('Open Camera'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10,),
                    
//                   pickedCitizenImage != null
//             ? Container(
//               height:200,
//               width: 200,
//               child: Image.file(pickedCitizenImage!,
//               fit: BoxFit.cover,))
//             : 
//             widget.citizenship =="null" ? Container(
//               height: 200,
//               width: 200,
//               child: Image.asset('assets/images/imageLoader.png',
//               fit: BoxFit.cover,)):
//               Container(
//               height: 200,
//               width: 200,
//               child:  FadeInImage.assetNetwork(
//                 placeholder: 'assets/images/imageLoader.png',
//                 image: '$baseUrl/driverimages/${widget.citizenship}',
//                 fit: BoxFit.cover,
//               ),
              
//             //   Image.network('$baseUrl/driverimages/${widget.citizenship}',
//             //   fit: BoxFit.cover,),
//              )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10,),
//            Text("License"),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//                 width: double.infinity,
//                 height: 320,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                            _pickLicenseImageFromGallary();
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Image.asset(
//                                     'assets/images/gallary.png',
//                                     height: 40,
//                                     width: 40,)),
//                               ),
//                               Text('Select a image'),
//                             ],
//                           ),
//                         ),
                        
//                         GestureDetector(
//                           onTap: (){
//                                 _pickLicenseImageFromCamera();
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Container(
//                                   width: 30,
//                                   height: 30,
//                                   child: Image.asset('assets/images/camera.png',
//                                   fit: BoxFit.cover)),
//                               ),
//                               Text('Open Camera'),
//                             ],
//                           ),
//                         ),
//                    ],
//                     ),
//                     SizedBox(height: 10,),
//                   pickedLicenseImage != null
//             ? Container(
//               height:200,
//               width: 200,
//               child: Image.file(pickedLicenseImage!,
//               fit: BoxFit.cover,))
//             : widget.licensefilename =="null" ?Container(
//               height: 200,
//               width: 200,
//               child: Image.asset('assets/images/imageLoader.png',
//               fit: BoxFit.cover,)):Container(
//               height: 200,
//               width: 200,
//               child: FadeInImage.assetNetwork(
//                 placeholder: 'assets/images/imageLoader.png',
//                 image: '$baseUrl/driverimages/${widget.licensefilename}',
//                 fit: BoxFit.cover,
//               ),
//               // Image.network('$baseUrl/driverimages/${widget.licensefilename}',
//               // fit: BoxFit.cover,),
//             ),
                    
            
//                   ],
//                 ),
//               ),
//               TextFormField(
//               readOnly: true,
//               controller: TextEditingController(
//                 text: formatter.format(_licenseExpireDate!), // Format the date
//               ),
//               decoration: InputDecoration(
//                 labelText: 'License Expire Date',
//               ),
//               onTap: () => _selectLicenseExpireDate(context),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               readOnly: true,
//               controller: TextEditingController(
//                 text: formatter.format(_billBookExpireDate!), // Format the date
//               ),
//               decoration: InputDecoration(
//                 labelText: 'Bill Book Expiry Date',
//               ),
//               onTap: () => _selectBillBookExpireDate(context),
//             ),
                
          
//           ],
//         ),
//       ),
//     bottomNavigationBar: CustomButton(
//           label: loading == false ?"Update":"loading",
//           color: Colours.primarygreen,
//           onpressed: (){
//             setState(() {
//               loading=true;
//             });
//             //if(citizenshipName != 'null' || LicenseFileName != 'null'){
//               updateCitizenship();
//               setState(() {
//               loading=false;
//             });
//             //}
            
//           },
//         ),
//     );
// }
// }

// // class UpdatePhoto extends StatefulWidget {
// //   late final File pickedImage;
// //   final ImagePicker picker;
// //   UpdatePhoto({super.key,required this.pickedImage,required this.picker});

// //   @override
// //   State<UpdatePhoto> createState() => _UpdatePhotoState();
// // }

// // // class _UpdatePhotoState extends State<UpdatePhoto> {
// //   Future<void> _pickImageFromGallary() async {
// //     final XFile? image = await widget.picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       setState(() {
// //         widget.pickedImage = File(image.path);
// //       });
// //     }
// //   }
// //   Future<void> _pickImageFromCamera() async {
// //     final XFile? image = await widget.picker.pickImage(source: ImageSource.camera);
// //     if (image != null) {
// //       setState(() {
// //         widget.pickedImage = File(image.path);
// //       });
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //          Text("Profile Picture"),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           Container(
// //               width: double.infinity,
// //               height: 320,
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: Colors.black),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       GestureDetector(
// //                         onTap: (){
// //                           _pickImageFromGallary();
// //                         },
// //                         child: Column(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(15.0),
// //                               child: Container(
// //                                 width: 30,
// //                                 height: 30,
// //                                 child: Image.asset(
// //                                   'assets/images/gallary.png',
// //                                   height: 40,
// //                                   width: 40,)),
// //                             ),
// //                             Text('Select a image'),
// //                           ],
// //                         ),
// //                       ),
                      
// //                       GestureDetector(
// //                         onTap: (){
// //                               _pickImageFromCamera();
// //                         },
// //                         child: Column(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(15.0),
// //                               child: Container(
// //                                 width: 30,
// //                                 height: 30,
// //                                 child: Image.asset('assets/images/camera.png',
// //                                 fit: BoxFit.cover)),
// //                             ),
// //                             Text('Open Camera'),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 10,),
// //                 widget.pickedImage != null
// //           ? Container(
// //             height:200,
// //             width: 200,
// //             child: Image.file(widget.pickedImage!,
// //             fit: BoxFit.cover,))
// //           : Container(
// //             height: 200,
// //             width: 200,
// //             child: Image.asset('assets/images/imageLoader.png',
// //             fit: BoxFit.cover,),
// //           )
// //                 ],
// //               ),
// //             )
        
// //       ],
// //     );
// //   }
// // }