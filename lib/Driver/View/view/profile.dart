import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Driver/Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import 'package:food_app/Driver/View/view/home_page.dart';
import 'package:food_app/Driver/View/view/driver_splashscreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/View/Screens/HomeScreens/Account/updae_profile.dart';
import '../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../Controller/bloc/Deliveries/deliveries_bloc.dart';
import '../../Controller/repository/getDriverDetails.dart';
import '../../Controller/repository/updateDriver.dart';
import '../../Controller/repository/updatePlayerId.dart';
import '../../Model/DriverDetailModel.dart';
import '../components/button.dart';
import '../components/colors.dart';
import '../constants/Constants.dart';
import 'BankDetails.dart';
import 'ChangedPassword.dart';
import 'delivery_history.dart';
import 'loginpage.dart';
import 'updateKYC.dart';

class DriverProfile extends StatefulWidget {
  Function callback;
  String fullname;
  String email;
  String phoneno;
  String driver_type;
  DriverProfile({
    super.key,
    required this.callback,
    required this.fullname,
    required this.email,
    required this.phoneno,
    required this.driver_type,
  });

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
 
  
 bool loading =true;
  DriverDetailModel? model;
  getDriverDetail()async{
    print("Getting Driver Detail");
  DriverRepository repo = DriverRepository();
   model= await repo.GetDriver();
   setState(() {
      loading= false;
    });
  }
  
  @override
  void initState() {
    //model =null;
    // TODO: implement initState
     getDriverDetail();
    // if(model == null){
    //   getDriverDetail();
    // }
    // if(model != null){
    //   print("Driver Address is"+model!.driverDetails!.address.toString());
    // }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      void _showAlertDialog(BuildContext context) {
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
                Text('Log Out',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Are you sure want to log out?',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
            ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Log out'),
                    onPressed: ()async {
                    SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('isDriverLoggedIn', 'false');
                  prefs.remove('user_thumbnail');
                  prefs.remove('isLoggedIn');
                  prefs.remove('user_id');
                  prefs.remove('latitude');
                  prefs.remove('longitude');
                  String? driverId = prefs.getString('driverId');
        UpdatePlayerIdRepository repo2 = UpdatePlayerIdRepository();
        bool isUpdated;
        isUpdated = await repo2.updatePlayerId(driverId!, 'null');
                  Fluttertoast.showToast(
                    msg: 'Logged Out',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  
                
                  Get.offAll(BlocProvider(
                  create: (context) => SignInBloc(context),
                  child: Loginpage(),
                ));
                      
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
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text(
            'My Profile',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              alignment: Alignment.topRight,
              onPressed: () async {
                _showAlertDialog(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade400,
                  ),
                  child:loading ==true || model!.driverDetails!.profileImage.toString() == "null" ? Icon(
                    Icons.person_outline,
                    size: 80,
                  ):  ClipOval(
                    child: Container(
                                height: 100,
                                width: 100,
                                child:  FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/imageLoader.png',
                                  image: '$baseUrl/driverimages/${model!.driverDetails!.profileImage}',
                                  fit: BoxFit.cover,
                                ),
                                
                              //   Image.network('$baseUrl/driverimages/${widget.citizenship}',
                              //   fit: BoxFit.cover,),
                               ),
                  )
                ),
                const SizedBox(height: 10),
                Text(
                  widget.fullname,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mail),
                    SizedBox(width: 10),
                    Text(widget.email)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Text(widget.phoneno),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 35,
                  width: 170,
                  child: CustomButton(
                    label: 'Update KYC',
                    color: Colours.primarygreen,
                    onpressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => DeliveriesBloc(),
                            child: UpdateKYC(index: 0,callback:widget.callback)
                          );
                        }),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // const RowContent(
                //   icon: Icons.heart_broken,
                //   color: Colours.primarygreen,
                //   label: 'My Favorites',
                // ),
                const SizedBox(height: 10),
                widget.driver_type =="1"?Container(): GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => DeliveriesBloc(),
                              child: DeliveryHistory(),
                            )));
                  },
                  child:  RowContent(
                    icon: Icons.history,
                    color: Colours.primarygreen,
                    label: 'My Delivery History',
                  ),
                ),
                const SizedBox(height: 0),
                GestureDetector(
                  onTap: () {
                    print("navigate");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => SignUpBloc(),
                              child: ChangePassword(),
                            )));
                  },
                  child: RowContent(
                    icon: Icons.key,
                    color: Colours.primarygreen,
                    label: 'Change Password',
                  ),
                ),
                 GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => SignUpBloc(),
                              child: BankDetails(),
                            )));
                  },
                  child: RowContent(
                    icon: Icons.account_balance,
                    color: Colours.primarygreen,
                    label: 'My Banking Details',
                  ),
                ),
                const SizedBox(height: 0),
                widget.driver_type =="1"?
                 GestureDetector(
                  onTap: () {
                    _showAlertDialog2(context,model);
                  },
                  child: RowContent(
                    backgroundColor: Colours.primarygreen,
                    icon: Icons.delivery_dining,
                    color: Colors.white,
                    label: 'Transfer to Delivery Service',
                    textColor: Colors.white,
                  ),
                )
                : GestureDetector(
                  onTap: () {
                    _switchToRideShareDialog(context,model);
                  },
                  child: RowContent(
                    backgroundColor: Colours.primarygreen,
                    icon: Icons.motorcycle,
                    color: Colors.white,
                    label: 'Transfer to Ride Share',
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
    
  }
}

class RowContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final Color? textColor;

 RowContent({
    this.color = Colors.black,
    required this.icon,
    required this.label,
    this.backgroundColor=Colors.white,
    this.textColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: ListTile(
            tileColor: backgroundColor,
            leading: Icon(
              icon,
              color: color,
            ),
            title: Text(label,style: TextStyle(color: textColor),),
            trailing: label == 'Transfer to Ride Share' || label == 'Transfer to Delivery Service' ?null:Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Divider(
            height: 2,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}

void _switchToRideShareDialog(BuildContext context,DriverDetailModel? model) {
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
                Text('Switch to Ride Share?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Your account data will be saved',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
            ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Continue'),
                    onPressed: () async{
                      UpdateDriver repo = UpdateDriver();
                                repo.UpdateDriverData(
                                  model!.driverDetails!.fullname.toString(),
                                  model!.driverDetails!.email.toString(),
                                  model!.driverDetails!.mobileNumber.toString(),
                                  '0',
                                  model!.driverDetails!.address.toString(),
                                  model!.driverDetails!.city.toString(),
                                  model!.driverDetails!.license.toString(),
                                  model!.driverDetails!.licenseExpiryDate.toString(),
                                  model!.driverDetails!.billBookExpiryDate.toString(),
                                  model!.driverDetails!.addressTemporary.toString(),
                                  model!.driverDetails!.citizenship.toString(),
                                  model!.driverDetails!.vehicleOwner.toString(),
                                  model!.driverDetails!.profileImage.toString(),
                                  '1',
                                  model!.driverDetails!.driverLicenseNumber.toString(),
                                  model!.driverDetails!.vehicleBrand.toString(),
                                  model!.driverDetails!.vehicleColor.toString(),
                                  model!.driverDetails!.vechicleNumber.toString(),
                                  model!.driverDetails!.vechiclePhotos.toString(),
                                  model!.driverDetails!.billbook.toString(),
                                  );
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('driver_type','1');
                                  Get.offAll(SplashScreen(
                                  ));
                  
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


void _showAlertDialog2(BuildContext context,DriverDetailModel? model) {
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
                Text('Switch to Delivery?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Your account data will be saved',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
            ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Continue'),
                    onPressed: () async{
                     UpdateDriver repo = UpdateDriver();
                                repo.UpdateDriverData(
                                  model!.driverDetails!.fullname.toString(),
                                  model!.driverDetails!.email.toString(),
                                  model!.driverDetails!.mobileNumber.toString(),
                                  '0',
                                  model!.driverDetails!.address.toString(),
                                  model!.driverDetails!.city.toString(),
                                  model!.driverDetails!.license.toString(),
                                  model!.driverDetails!.licenseExpiryDate.toString(),
                                  model!.driverDetails!.billBookExpiryDate.toString(),
                                  model!.driverDetails!.addressTemporary.toString(),
                                  model!.driverDetails!.citizenship.toString(),
                                  model!.driverDetails!.vehicleOwner.toString(),
                                  model!.driverDetails!.profileImage.toString(),
                                  '0',
                                  model!.driverDetails!.driverLicenseNumber.toString(),
                                  model!.driverDetails!.vehicleBrand.toString(),
                                  model!.driverDetails!.vehicleColor.toString(),
                                  model!.driverDetails!.vechicleNumber.toString(),
                                  model!.driverDetails!.vechiclePhotos.toString(),
                                  model!.driverDetails!.billbook.toString(),
                                  
                                  );
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('driver_type','0');
                                  Get.offAll(SplashScreen());
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

