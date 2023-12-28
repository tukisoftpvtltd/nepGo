import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Controller/repository/updateDriver.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../User/View/constants/Constants.dart';
import '../../../User/View/widgets/button.dart';
import '../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';

import '../../Controller/repository/uploadImage.dart';
import '../components/colors.dart';

class PersonalPage extends StatefulWidget {
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

  PersonalPage({super.key,
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
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
   bool obscureText1 = true;
  bool obscureText2 = true;
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  bool firstNameValid =true;
  bool? lastNameValid;
  bool phoneValid =true;
  bool emailValid =true;
  bool? passwordValid;
  bool? confirmPasswordValid;
   bool addressValid=true;
    bool cityValid=true;
  bool loading= false;
  //final _scrollKey = GlobalKey<ScrollableState>();
  //final _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
   final FocusNode _focusNode1 = FocusNode();

   initState(){
    firstNameController.text = widget.firstName;
    phonenumberController.text = widget.phone;
    emailController.text = widget.email;
    addressController.text = widget.address;
    cityController.text = widget.city;
    if(widget.profile != 'null'){
      ProfileImage= widget.profile;
    }
   }
     File? pickedProfileImage;
  final ImagePicker profilePicker = ImagePicker();
  String ProfileImage ='null';
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
                    onPressed: ()async {
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


CroppedFile? croppedFile;
    Future<void> _pickProfileImageFromGallary() async {
    final XFile? image = await profilePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    print("Image path is"+image.path);
   // setState(() {
    
    // = await cropImage(File(image.path));
     try {
    croppedFile = await cropImage(File(image.path));
  } catch (e) {
    // Handle any potential errors during cropping
    print("Error cropping image: $e");
  }

  // Check if croppedFile is not null before proceeding
  if (croppedFile != null) {
    print("The cropped file is ${croppedFile!.path}");
        final pickedImage = File(croppedFile!.path);

    int sizeInBytes = await pickedImage.length();
    double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

    String fileName = pickedImage.uri.pathSegments.last;
    String fileExtension = fileName.split('.').last;

    final String randomString = generateRandomString(20);

    print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
    print('Image Name: $randomString.jpg');
    setState(() {
      ProfileImage = '$randomString.$fileExtension';
    });
    print("the profile image is");
    print(ProfileImage);


    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('Image in Base64: data:image/jpeg;base64,$base64Image');
    UploadImageRepo repo = UploadImageRepo();
    repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
    
   
  } else {
    print("Image cropping failed or was canceled.");
  }
    // if(croppedFile!= null){
    //    print("The cropped file is"+croppedFile!.path);
    // }
   
      //pickedProfileImage = File(image.path);
   // });
    //final pickedImage = File(image.path);

    // int sizeInBytes = await pickedImage.length();
    // double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

    // String fileName = pickedImage.uri.pathSegments.last;
    // String fileExtension = fileName.split('.').last;

    // final String randomString = generateRandomString(20);

    // print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
    // print('Image Name: $randomString.$fileExtension');
    // setState(() {
    //   ProfileImage = '$randomString.$fileExtension';
    // });
    // print("the profile image is");
    // print(ProfileImage);


    // List<int> imageBytes = await pickedImage!.readAsBytes();
    // String base64Image = base64Encode(imageBytes);
    // print('Image in Base64: data:image/jpeg;base64,$base64Image');
    // UploadImageRepo repo = UploadImageRepo();
    // repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
  }
  }
  
      Future<void> _pickProfileImageFromCamera() async {
    final XFile? image = await profilePicker.pickImage(source: ImageSource.camera);
  if (image != null) {
    print("Image path is"+image.path);
   // setState(() {
    
    // = await cropImage(File(image.path));
     try {
    croppedFile = await cropImage(File(image.path));
  } catch (e) {
    // Handle any potential errors during cropping
    print("Error cropping image: $e");
  }

  // Check if croppedFile is not null before proceeding
  if (croppedFile != null) {
    print("The cropped file is ${croppedFile!.path}");
        final pickedImage = File(croppedFile!.path);

    int sizeInBytes = await pickedImage.length();
    double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

    String fileName = pickedImage.uri.pathSegments.last;
    String fileExtension = fileName.split('.').last;

    final String randomString = generateRandomString(20);

    print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
    print('Image Name: $randomString.jpg');
    setState(() {
      ProfileImage = '$randomString.$fileExtension';
    });
    print("the profile image is");
    print(ProfileImage);


    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('Image in Base64: data:image/jpeg;base64,$base64Image');
    UploadImageRepo repo = UploadImageRepo();
    repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
    
   
  } else {
    print("Image cropping failed or was canceled.");
  }
    // if(croppedFile!= null){
    //    print("The cropped file is"+croppedFile!.path);
    // }
   
      //pickedProfileImage = File(image.path);
   // });
    //final pickedImage = File(image.path);

    // int sizeInBytes = await pickedImage.length();
    // double sizeInMB = sizeInBytes / (1024 * 1024); // 1 MB = 1,048,576 bytes

    // String fileName = pickedImage.uri.pathSegments.last;
    // String fileExtension = fileName.split('.').last;

    // final String randomString = generateRandomString(20);

    // print('Image Size: ${sizeInMB.toStringAsFixed(2)} MB');
    // print('Image Name: $randomString.$fileExtension');
    // setState(() {
    //   ProfileImage = '$randomString.$fileExtension';
    // });
    // print("the profile image is");
    // print(ProfileImage);


    // List<int> imageBytes = await pickedImage!.readAsBytes();
    // String base64Image = base64Encode(imageBytes);
    // print('Image in Base64: data:image/jpeg;base64,$base64Image');
    // UploadImageRepo repo = UploadImageRepo();
    // repo.UploadImage('data:image/jpeg;base64,$base64Image', '$randomString.$fileExtension');
  }
  }
  
// Future<CroppedFile?> cropImage(File imageFile) async {
//   ImageCropper imageCropper = ImageCropper();
//   final croppedImage = await imageCropper.cropImage(
//     sourcePath: imageFile.path,
//     aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//     aspectRatioPresets: [CropAspectRatioPreset.square],
//     cropStyle: CropStyle.circle,
//     compressQuality: 100,
//     compressFormat: ImageCompressFormat.jpg,
//     // uiSettings:[
//     //   AndroidUiSettings(
//     //   toolbarTitle: 'Crop Image',
//     //   toolbarColor: Colors.blue,
//     //   toolbarWidgetColor: Colors.white,
//     //   initAspectRatio: CropAspectRatioPreset.square,
//     //   lockAspectRatio: true,
//     // ),
//     // IOSUiSettings(
//     //   title: 'Crop Image',
//     //   doneButtonTitle: 'Done',
//     //   cancelButtonTitle: 'Cancel',
//     // ),
//     // ] 
    
//   );
//   return croppedImage;
// }

Future<CroppedFile?> cropImage(File imageFile)async{
  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return croppedFile;
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Container(
            width: Get.width,
            height: Get.height/4.8,
            decoration: BoxDecoration(color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ClipOval(
                  child: Container(
                    height: 110,
                    width: 110,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: ClipOval(
                          child: 
                          croppedFile != null ? 
                          Image.file(
                            File(croppedFile!.path),
                            fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                            ):
                            widget.profile =='null'?
                          Image.asset('assets/rideshare/person.jpg',
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                          ):
                           Container(
              height: 100,
              width: 100,
              child:  FadeInImage.assetNetwork(
                placeholder: 'assets/images/imageLoader.png',
                image: '$baseUrl/driverimages/${widget.profile}',
                fit: BoxFit.cover,
              ),
              
            //   Image.network('$baseUrl/driverimages/${widget.citizenship}',
            //   fit: BoxFit.cover,),
             )
                          ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: CustomButton2(
                    label: 'Edit Profile',
                    color: Colours.primarygreen,
                    onpressed: () {
                    _SelectPhotoDialog();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            
          ),
          const SizedBox(height: 20),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpFirstNameValidState) {
                          firstNameValid = true;
                        }
                        if (state is SignUpFirstNameInValidState) {
                          firstNameValid = false;
                        }
                        if (firstNameValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (firstNameValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        return SizedBox(
                          width: screenWidth * 0.85,
    
                          child: TextField(
                            focusNode: _focusNode,
                            onEditingComplete: (){
                              FocusScope.of(context).requestFocus(_focusNode1);
    
                            },
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  FirstNameChangedEvent(
                                      firstNameController.text));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelText: "Full Name",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.person,
                                color: borderColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: firstNameController,
                            obscureText: false,
                          ),
                          // InputTextBox(
                          //   select: false,
                          //   hinttext: 'First Name',
                          //   icon: Icon(Icons.person, color: Colours.primarygreen),
                          // ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpPhoneValidState) {
                          phoneValid = true;
                        }
                        if (state is SignUpPhoneInValidState) {
                          phoneValid = false;
                        }
                        if (phoneValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (phoneValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        return SizedBox(
                          width: screenWidth * 0.85,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  PhoneNoChangedEvent(
                                      phonenumberController.text));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              counterText: '',
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelText: "Phone Number",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: borderColor,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: phonenumberController,
                            obscureText: false,
                            maxLength: 10,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpEmailValidState) {
                          emailValid = true;
                        }
                        if (state is SignUpEmailInValidState) {
                          emailValid = false;
                        }
                        if (emailValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (emailValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        return SizedBox(
                          width: screenWidth * 0.85,
                          child: TextField(
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpEmailChangedEvent(emailController.text));
                            },
                            // controller: email,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              labelText: "Email",
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelStyle: TextStyle(color: Colours.primarybrown),
                              hintText: "",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.mail,
                                color: borderColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            obscureText: false,
    
                            controller: emailController,
                          ),
                          // InputTextBox(
                          //   emailController: email,
                          //   passwordController: password,
                          //   select: false,
                          //   hinttext: 'Email*',
                          //   icon: Icon(Icons.mail, color: Colours.primarygreen),
                          // ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
              BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpAddressValidState) {
                          addressValid = true;
                        }
                        if (state is SignUpAddressInValidState) {
                          addressValid = false;
                        }
                        if (addressValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (addressValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        return SizedBox(
                          width: screenWidth * 0.85,
    
                          child: TextField(
                            
                            onEditingComplete: (){
                              
    
                            },
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  AddressChangedEvent(
                                      addressController.text));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelText: "Address",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.place,
                                color: borderColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: addressController,
                            obscureText: false,
                          ),
                          // InputTextBox(
                          //   select: false,
                          //   hinttext: 'First Name',
                          //   icon: Icon(Icons.person, color: Colours.primarygreen),
                          // ),
                        );
                      },
                    ),
               const SizedBox(height: 15),
              BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpCityValidState) {
                          cityValid = true;
                        }
                        if (state is SignUpCityInValidState) {
                          cityValid = false;
                        }
                        if (cityValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (cityValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        return SizedBox(
                          width: screenWidth * 0.85,
    
                          child: TextField(
                            
                            onEditingComplete: (){
                             
    
                            },
                            onChanged: (value) {
                              BlocProvider.of<SignUpBloc>(context).add(
                                  CityChangedEvent(
                                      cityController.text));
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                              floatingLabelStyle: TextStyle(color: borderColor),
                              labelText: "City",
                              hintStyle:
                                  const TextStyle(color: Colours.primarybrown),
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: borderColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                            ),
                            controller: cityController,
                            obscureText: false,
                          ),
                        );
                      },
                    ),
              
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpErrorState) {
                          return Text(
                            state.errorMessage,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpErrorState) {
                          return Text(
                            state.errorMessage,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 40,
                      width: screenWidth * 0.85,
                      child: BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          String signup = 'Update';
                          if (state is SignUpLoadingState) {
                            signup = 'loading';
                          } else {
                            signup = 'Update';
                          }
                          return CustomButton(
                            label: loading == true?'loading':'Update',
                            color: Colours.primarygreen,
                            onpressed: () async {
                              print('loading');
                                setState(() {
                                 loading=true;
                                 signup = 'loading';
                                 });
                              print(firstNameValid);
                              print(lastNameValid);
                              if (firstNameValid == true &&
                                  phoneValid == true &&
                                  emailValid == true &&
                                  addressValid ==true&&
                                  cityValid ==true) {
                                    setState(() {
                                 loading=true;
                                 });
                                UpdateDriver repo = UpdateDriver();
                                
                                repo.UpdateDriverData(
                                  firstNameController.text,
                                  emailController.text,
                                  phonenumberController.text,
                                  '0',
                                  addressController.text,
                                  cityController.text,
                                  widget.licensefilename,
                                  widget.license_date,
                                  widget.bill_book_date,
                                  widget.address_temporary,
                                  widget.citizenship,
                                  widget.vehicle_owner,
                                  ProfileImage,
                                  '1',
                                  widget.licenseNumber,
                                  widget.vehicleBrand,
                                  widget.vehicleColor,
                                  widget.vehicleNumber,
                                  widget.vehiclePhoto,
                                  widget.billbook

                                  );
                                  widget.callback(firstNameController.text,emailController.text,phonenumberController.text,);
                              setState(() {
                                 loading=false;
                                 });
                              }
                            },
                          );
                        },
                      ),
                    ),
                    
      ],),
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
String generateRandomString(int length) {
  const String charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final Random random = Random();
  StringBuffer result = StringBuffer();

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(charset.length);
    result.write(charset[randomIndex]);
  }

  return result.toString();
}