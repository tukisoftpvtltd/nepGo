import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/User/Controller/repositories/update_profile.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Driver/Controller/repository/uploadImage.dart';
import '../../../../../Driver/View/view/PersonalPage.dart';
import '../../../../Controller/repositories/uploadUserImage.dart';
import '../../../constants/Constants.dart';
import '../../../constants/colors.dart';
import '../../../widgets/button.dart';
import 'profile.dart';

class UpateProfile extends StatefulWidget {
  String fname;
  String lname;
  String phoneno;
  Function callBack;
  Function getUserProfile;
  UpateProfile({super.key,
  required this.fname,
  required this.lname,
  required this.phoneno,
  required this.callBack,
  required this.getUserProfile});

  @override
  State<UpateProfile> createState() => _UpateProfileState();
}

class _UpateProfileState extends State<UpateProfile> {
  getUserProfile()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userthumbnail =prefs.getString('user_thumbnail');
     print("The user thumbnail is"+userthumbnail.toString());
     if(userthumbnail.toString() == "null" || userthumbnail.toString() =='https://www.meroato.tukisoft.com.np/userprofile/null'){
      
     }
     else{
      setState(() {
        profile = userthumbnail.toString();
      });
     }
   //  widget.getUserProfile();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getUserProfile();
    fname.text = widget.fname;
    lname.text = widget.lname;
    phone.text = widget.phoneno;
    // f1.addListener(_scrollToFocusedTextField);
  }
  // void _scrollToFocusedTextField() {
  //   if (f1.hasFocus) {
  //     Future.delayed(Duration(milliseconds: 200), () {
  //       _scrollController.animateTo(
  //         100,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeOut,
  //       );
  //     });
  //   }
  //   }
  String userId = '';
  getUserId()async{
    
    SharedPreferences userData = await SharedPreferences.getInstance();
    userId = userData.getString('user_id').toString();
    print("the user id is");
    print(userId);
  }
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  bool loading=false;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  updateData()async{
    setState(() {
      loading=true;
    });
    UpdateProfileRepository repo = UpdateProfileRepository();
    await repo.update(userId, fname.text, lname.text, phone.text,profile);
    setState(() {
      loading=false;
    });
    widget.callBack(fname.text,lname.text,phone.text);

  }
  bool? fnameValid ;
  bool? lnameValid;
  bool? phonenoValid;
  
  fnameChecker(){
    setState(() {
      if(fname.text.length >3 ){
      fnameValid = true;
    }
    else{
      fnameValid =false;
    }
    });
  }
  lnameChecker(){
    setState(() {
      if(lname.text.length >3 ){
      lnameValid = true;
    }
    else{
      lnameValid =false;
    }
    });
  }
   phoneChecker(){
    setState(() {
      if(phone.text.length ==10 ){
      phonenoValid = true;
    }
    else{
      phonenoValid =false;
    }
    });
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
  Future<CroppedFile?> cropImage(File imageFile)async{
  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square
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
  String profile ='null'; 
     File? pickedProfileImage;
  final ImagePicker profilePicker = ImagePicker();
final ScrollController _scrollController = ScrollController();
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
      profile = '$randomString.jpg';
    });
    print("the profile image is");
    print(profile);


    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('Image in Base64: data:image/jpeg;base64,$base64Image');
    UploadUserImageRepo repo = UploadUserImageRepo();
    repo.UploadUserImage('data:image/jpeg;base64,$base64Image', '$randomString.jpg');
    
   
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
      profile = '$randomString.jpg';
    });
    print("the profile image is");
    print(profile);


    List<int> imageBytes = await pickedImage!.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print('Image in Base64: data:image/jpeg;base64,$base64Image');
    UploadUserImageRepo repo = UploadUserImageRepo();
    repo.UploadUserImage('data:image/jpeg;base64,$base64Image', '$randomString.jpg');
    
   
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
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        widget.getUserProfile();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              widget.getUserProfile();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text('Update Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
           controller:  _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
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
                              profile =='null'?
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
                    image: profile,
                    fit: BoxFit.cover,
                  ),
                  
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 365,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: 
                   TextField(
        focusNode: f1,
        controller: fname,
        onChanged: (value) {
          fnameChecker();
        },
        onSubmitted: (val){
          FocusScope.of(context).requestFocus(f2);
        },
        keyboardType: TextInputType.name,
        textCapitalization:  TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'First Name',
          hintText: 'First Name',
          hintStyle: const TextStyle(color: Colours.primarybrown),
          labelStyle: TextStyle(color: fnameValid ==true? Colours.primarygreen:
            fnameValid == false ?Colors.red : Colours.primarybrown),
          border: const OutlineInputBorder(),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: fnameValid==true? Colours.primarygreen:
            fnameValid == false ?Colors.red : Colours.primarybrown),
          ),
        ),
        obscureText: false,
      )),
              Container(
                  width: 365,
                  height: 50,
                   margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: 
                   TextField(
        focusNode: f2,
        controller: lname,
        onChanged: (value) {
          lnameChecker();
        },
        onSubmitted: (val){
          FocusScope.of(context).requestFocus(f3);
        },
        keyboardType: TextInputType.name,
        textCapitalization:  TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Last Name',
          hintText: 'Last Name',
          labelStyle: TextStyle(color: lnameValid==true? Colours.primarygreen:
            lnameValid == false ?Colors.red : Colours.primarybrown),
          hintStyle: const TextStyle(color: Colours.primarybrown),
          border: const OutlineInputBorder(),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: lnameValid==true? Colours.primarygreen:
            lnameValid == false ?Colors.red : Colours.primarybrown),
          ),
        ),
        obscureText: false,
      )),
              Container(
                width: 365,
                height: 50,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: 
                TextField(
        focusNode: f3,
        controller: phone,
        onChanged: (value) {phoneChecker();},
        onSubmitted: (val){
        },
        keyboardType: TextInputType.number,
        textCapitalization:  TextCapitalization.sentences,
        inputFormatters: [
                LengthLimitingTextInputFormatter(10), // Limit to 10 digits
              ],
        decoration: InputDecoration(
          labelText: 'Phone No.',
          hintText: 'Phone No.',
          labelStyle: TextStyle(color: phonenoValid==true? Colours.primarygreen:
            phonenoValid == false ?Colors.red : Colours.primarybrown),
          hintStyle: const TextStyle(color: Colours.primarybrown),
          border: const OutlineInputBorder(),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: phonenoValid==true? Colours.primarygreen:
            phonenoValid == false ?Colors.red : Colours.primarybrown),
          ),
        ),
        obscureText: false,
      )
             
              ),
              // Container(
              //   width: 365,
              //   height: 50,
              //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              //   child:  InputTextBox(
              //     labeltext: 'Email',
              //     controller: email,
              //     hinttext: 'Email',
              //     type:  TextInputType.emailAddress,
              //     select: false,
              //   ),
              // ),
              
              // Container(
              //   width: 365,
              //   margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Contact',
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              
              // Container(
              //   width: 365,
              //   margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         'Address',
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 15),
              // const ReuseableDropdownMenu(),
              // const SizedBox(height: 15),
              // const ReuseableDropdownMenu(),
              // const SizedBox(height: 15),
              // Container(
              //   width: 365,
              //   height: 55,
              //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              //   child: const InputTextBox(
              //     hinttext: 'City',
              //     select: false,
              //     icon: null,
              //   ),
              // ),
              // const SizedBox(
              //   width: 365,
              //   height: 55,
              //   child: InputTextBox(
              //     hinttext: 'Street',
              //     select: false,
              //     icon: null,
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              Container(
                height: 40,
                width: 365,
                child: CustomButton(
                    label: loading == false ?'UPDATE':"loading",
                    color: Colours.primarygreen,
                    onpressed: () {
      if(fnameValid ==false || lnameValid ==false || phonenoValid ==false){
       Fluttertoast.showToast(
        msg: "Invalid Data",
        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // positioning of the toast
        timeInSecForIosWeb: 1, // only for iOS
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      }
      else{
                      updateData();
                      }
                     
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputTextBox extends StatelessWidget {
  final FocusNode? focus;
  final TextEditingController? controller;
  final String? hinttext;
  final String? labeltext;
  final Color? color;
  final Icon? icon;
  final bool select;
  final TextInputType? type;

   InputTextBox({
    super.key,
    this.focus,
    this.controller,
    this.type,
    this.labeltext,
    required this.select,
    this.hinttext,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focus,
      controller: controller,
      onChanged: (value) {},
      onSubmitted: (val){},
      keyboardType: type,
      textCapitalization: hinttext =="First Name" ?TextCapitalization.sentences:
      hinttext =="Last Name" ? TextCapitalization.sentences:TextCapitalization.none,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colours.primarybrown),
        prefixIcon: icon,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colours.primarygreen),
        ),
      ),
      obscureText: select,
    );
  }
}
