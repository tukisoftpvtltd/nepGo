import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Controller/repository/getDriverDetails.dart';
import '../../../Controller/repository/updateDriver.dart';
import '../../../Controller/repository/uploadImage.dart';
import '../../../Model/DriverDetailModel.dart';
import '../../components/colors.dart';
import '../../constants/Constants.dart';
import '../PersonalPage.dart';

class LicenseForm extends StatefulWidget {
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
  LicenseForm({super.key,
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
  State<LicenseForm> createState() => _LicenseFormState();
}

class _LicenseFormState extends State<LicenseForm> {
  DriverDetailModel? model;
    getDriverDetail()async{
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   if(model!.driverDetails!.driverLicenseNumber.toString() !="null"){
     licenseNumberController.text  =model!.driverDetails!.driverLicenseNumber.toString() ;
   }
   if(model!.driverDetails!.license.toString() !="null"){
    setState(() {
     licenseImage = model!.driverDetails!.license.toString();
    });
     print("the license image name is"+licenseImage.toString());
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
   void _SelectPhotoDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Column(
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen,) // Change the color here
            ),
                    
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        SizedBox(width: 40,),
                        Text('Upload Via Camera'),
                      ],
                    ),
                    onPressed: () {
                      _pickProfileImageFromCamera();
                      Get.back();
                    },
              ),
              SizedBox(
                height: 10,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Row(
                      children: [
                        Icon(Icons.photo_album),
                        SizedBox(width: 40,),
                        Text('Upload Via Gallary'),
                      ],
                    ),
                    onPressed: (){
                      _pickProfileImageFromGallary();
                      Get.back();
                    },
              ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
       
      );
    },
  );
}



   File? pickedProfileImage;
  final ImagePicker profilePicker = ImagePicker();
  String licenseImage="null";
 //CroppedFile? croppedFile;
 XFile? image;
     Future<void> _pickProfileImageFromCamera() async {
    image = await profilePicker.pickImage(source: ImageSource.camera);
  if (image != null) {
    print("The file is ${image!.path}");
        final pickedImage = File(image!.path);

    int sizeInBytes = await pickedImage.length();
    double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

    String fileName = pickedImage.uri.pathSegments.last;
    String fileExtension = fileName.split('.').last;

    final String randomString = generateRandomString(20);

    print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
    print('Image Name: $randomString.$fileExtension');
    setState(() {
      licenseImage = '$randomString.jpg';
    });
    print("the profile image is");
    print(licenseImage);


    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('Image in Base64: data:image/jpeg;base64,$base64Image');
    UploadImageRepo repo = UploadImageRepo();
    repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.jpg');
    
   
  } else {
    print("Image cropping failed or was canceled.");
  }
  }
  
  
   
    Future<void> _pickProfileImageFromGallary() async {
    image = await profilePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print("The file is ${image!.path}");
        final pickedImage = File(image!.path);

    int sizeInBytes = await pickedImage.length();
    double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

    String fileName = pickedImage.uri.pathSegments.last;
    String fileExtension = fileName.split('.').last;

    final String randomString = generateRandomString(20);

    print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
    print('Image Name: $randomString.jpg');
    setState(() {
      licenseImage = '$randomString.jpg';
    });
    print("the profile image is");
    print(licenseImage);
    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('Image in Base64: data:image/jpeg;base64,$base64Image');
    UploadImageRepo repo = UploadImageRepo();
    repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.jpg');
    
   
  } else {
    print("Image cropping failed or was canceled.");
  }
  }
  
  
  TextEditingController licenseNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Driver License",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          shrinkWrap: true,
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
                    Text('Driver License number',
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
                            controller: licenseNumberController,
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
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Text('The front of driver’s license',
                    style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    image != null?
                    Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          width: Get.width-80,
                    height: 250,
                            )
                    :
                     licenseImage == 'null' ?
                    Image.asset('assets/images/imageLoader.png',
                    width: Get.width-80,
                    height: 250,)
                    :
                    Container(
                    width: Get.width-80,
                    height: 250,
                                child:  FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/imageLoader.png',
                                  image: '$baseUrl/driverimages/${licenseImage}',
                                  fit: BoxFit.cover,
                                ),
                                
                              //   Image.network('$baseUrl/driverimages/${widget.citizenship}',
                              //   fit: BoxFit.cover,),
                               ),
                    SizedBox(height: 5,),
                    CustomButton2(
                      label: 'Add Photo',
                      color: Colours.primarygreen,
                      onpressed: (){
                        _SelectPhotoDialog();
                        },
                    ),
                    SizedBox(height: 10,)
                  ],
                )),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Container(
              //   color: Colors.white,
              //   child: Column(
              //     children: [
              //       SizedBox(height: 15,),
              //       Text('The front of driver’s license',
              //       style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              //       SizedBox(height: 10,),
              //       Image.asset('assets/images/imageLoader.png',
              //       width: Get.width-80,
              //       height: 250,),
              //       SizedBox(height: 5,),
              //       CustomButton2(
              //         label: 'Add Photo',
              //         color: Colours.primarygreen,
              //         onpressed: (){_pickProfileImageFromGallary();},
              //       ),
              //       SizedBox(height: 10,)
              //     ],
              //   )),
              // ),
        
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
                                  licenseImage,
                                  widget.license_date,
                                  widget.bill_book_date,
                                  widget.address_temporary,
                                  widget.citizenship,
                                  widget.vehicle_owner,
                                  widget.profile,
                                  '1',
                                  licenseNumberController.text,
                                  widget.vehicleBrand,
                                  widget.vehicleColor,
                                  widget.vehicleNumber,
                                  widget.vehiclePhoto,
                                  widget.billbook
                                  );
                                  Get.back();
                                  // Get.back();
                                  // widget.callback(firstNameController.text,emailController.text,phonenumberController.text,);
                              // setState(() {
                              //    loading=false;
                              //    });
            },
          ),
        ),
        ]),
      
    );
  }
}
class CustomButton2 extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onpressed;

  const CustomButton2({
    super.key,
    required this.label,
    required this.color,
    required this.onpressed,
  });
  
  @override
  Widget build(BuildContext context) {
    
  
    return ElevatedButton(
        onPressed: onpressed,
        
        style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colours.primarygreen),
            ),
        child: label.toString() == "loading"
            ? Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ));
  }
}