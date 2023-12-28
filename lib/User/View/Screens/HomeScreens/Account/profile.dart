import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/Driver/View/view/home_page.dart';
import 'package:food_app/User/Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Account/My%20Order/MyOrders.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Driver/View/components/button.dart';
import '../../../../../Driver/View/view/home.dart';
import '../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../constants/colors.dart';
import '../Home/HomeScreensNavigation.dart';
import '../Home/Location/LocationChangePage.dart';
import '../Home/Location/locationPageView.dart';
import 'ChangedPassword.dart';
import 'ForgetPassword/ChangeForgotPassword.dart';
import 'MyFavorite/my_favorite_screen.dart';
import 'OrderHistory/order_history.dart';
import 'updae_profile.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;
  String phoneno;
  Profile(
      {super.key,
      required this.name,
      required this.email,
      required this.phoneno});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String profileUrl ='null';
  getUserProfile()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userthumbnail =prefs.getString('user_thumbnail');
     print("The user thumbnail is"+userthumbnail.toString());
     if(userthumbnail.toString() == "null" || userthumbnail.toString() =='https://www.meroato.tukisoft.com.np/userprofile/null'){
      
     }
     else{
      setState(() {
        profileUrl = userthumbnail.toString();
      });
     }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
    getUserDatas();
    getUserProfile();
  }

  String? locationName = '';
  String? placeName = '';
  String? lat = '';
  String? long = '';

  String fname = '';
  String lname = '';
  String email = '';
  getUserDatas() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    //final userId = userData .getString('user_id');
    setState(() {
      fname = userData.getString('fname') == null
          ? ''
          : userData.getString('fname')!;
      lname = userData.getString('lname') == null
          ? ''
          : userData.getString('lname')!;
      email = userData.getString('email') == null
          ? ''
          : userData.getString('email')!;
    });
  }

  callBack(String fnameValue, String lnameValue, String phonenoValue) {
    setState(() {
      fname = fnameValue;
      lname = lnameValue;
      widget.phoneno = phonenoValue;
    });
  }

  getLocationData() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    locationName = userData.getString('locationName') == null
        ? ''
        : userData.getString('locationName')!;
    placeName = userData.getString('placeName') == null
        ? ''
        : userData.getString('placeName')!;
    lat = userData.getString('latitude') == null
        ? ''
        : userData.getString('latitude')!;
    long = userData.getString('longitude') == null
        ? ''
        : userData.getString('longitude')!;
  }
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
                  prefs.remove('isLoggedIn');
                  prefs.remove('user_id');
                  prefs.remove('latitude');
                  prefs.remove('longitude');
                  Fluttertoast.showToast(
                    msg: 'Logged Out',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Get.offAll(BlocProvider(
                    create: (context) => HomePageBloc(),
                    child: BlocProvider(
                      create: (context) => HomeNavigationBloc(),
                      child: BlocProvider(
                        create: (context) => BasketBloc(),
                        child: HomeScreensNavigation(
                          currentIndexNumber: 0,
                          loginStatus: "false",
                          homeData: [],
                          advertisementData: [],
                        ),
                      ),
                    ),
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
//   void _showAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Log Out',style: TextStyle(fontSize: 18),),
//         content: Text('Are you sure want to log out?',style: TextStyle(fontSize: 14)),
//         actions: <Widget>[
//           ElevatedButton(
//                   style: ButtonStyle(
//     backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Change the color here
//   ),
            
//             onPressed: (){
//               Get.back();
//             }, child: Text('  No  ')),
//           ElevatedButton(
//             style: ButtonStyle(
//     backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
//   ),
//             child: Text('Log out',
//             ),
//             onPressed: () async{
//               SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   prefs.remove('isLoggedIn');
//                   prefs.remove('user_id');
//                   prefs.remove('latitude');
//                   prefs.remove('longitude');
//                   Fluttertoast.showToast(
//                     msg: 'Logged Out',
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                     backgroundColor: Colors.black54,
//                     textColor: Colors.white,
//                     fontSize: 16.0,
//                   );
//                   Get.offAll(BlocProvider(
//                     create: (context) => HomePageBloc(),
//                     child: BlocProvider(
//                       create: (context) => HomeNavigationBloc(),
//                       child: BlocProvider(
//                         create: (context) => BasketBloc(),
//                         child: HomeScreensNavigation(
//                           currentIndexNumber: 0,
//                           loginStatus: "false",
//                           homeData: [],
//                           advertisementData: [],
//                         ),
//                       ),
//                     ),
//                   )); // Close the alert dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          title: const Text(
            'My Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              alignment: Alignment.topRight,
              onPressed: () {},
              icon: GestureDetector(
                onTap: () async {
                  _showAlertDialog(context);
                },
                child: Semantics(
                  label: "logout",
                  child: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(),
                   profileUrl =="null" ?Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 90,
                    ),
                  ):ClipOval(
                    child: Container(
                      width: 100,
                      height: 100,
                      child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/imageLoader.png',
                  image: profileUrl,
                  fit: BoxFit.cover,
                ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    fname + " " + lname,
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
                    height: 30,
                    width: 170,
                    child: CustomButton(
                      label: 'EDIT PROFILE',
                      color: Colours.primarygreen,
                      onpressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return UpateProfile(
                              fname: fname,
                              lname: lname,
                              phoneno: widget.phoneno,
                              callBack: callBack,
                              getUserProfile:getUserProfile
                            );
                          }),
                        );
                      },
                    ),
                  ),
                 
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const MyFavoriteScreen();
                        }),
                      );
                    },
                    child: const RowContent(
                      icon: Icons.favorite,
                      color: Colours.primarygreen,
                      label: 'My Favorites',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const MyOrders();
                        }),
                      );
                    },
                    child: const RowContent(
                      icon: Icons.shop_outlined,
                      color: Colours.primarygreen,
                      label: 'My Orders',
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return OrderHistory();
                        }),
                      );
                    },
                    child: const RowContent(
                      icon: Icons.book_online,
                      color: Colours.primarygreen,
                      label: 'Order History',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationChangePage(
                        callback:(){},
                          currentLocation: "$locationName, $placeName",
                          position: LatLng(double.parse(lat!), double.parse(long!)),)));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => BlocProvider(
                      //           create: (context) => LocationBloc(),
                      //           child: LocationPageView(),
                      //         )));
                    },
                    child: const RowContent(
                      icon: Icons.location_on_outlined,
                      color: Colours.primarygreen,
                      label: 'Manage Delivery Address',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return ChangePassword();
                        }),
                      );
                    },
                    child: const RowContent(
                      icon: Icons.key,
                      color: Colours.primarygreen,
                      label: 'Change Password',
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(HomePage());
                  //   },
                  //   child: const RowContent(
                  //     icon: Icons.drive_eta,
                  //     color: Colours.primarygreen,
                  //     label: 'Driver View',
                  //   ),
                  // ),
                ],
              ),
            ),
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

  const RowContent({
    this.color = Colors.black,
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          icon,
                          color: color,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Icon(size: 20, Icons.arrow_forward_ios),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
