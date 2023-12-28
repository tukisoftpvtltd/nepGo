import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/NoInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Controller/Functions/UserStatus.dart';
import '../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../Controller/bloc/internet/bloc/internet_bloc_bloc.dart';
import '../../../constants/colors.dart';
import '../Account/LogIn/loginpage.dart';
import '../Account/profile.dart';
import '../Baskets/Basket/BasketScreen.dart';
import '../Menu/MenuScreen.dart';
import 'HomePageAppBar.dart';

// ignore: must_be_immutable
class HomeScreensNavigation extends StatefulWidget {
  int currentIndexNumber;
  String loginStatus;
  var homeData;
  var advertisementData;
  HomeScreensNavigation({
    Key? key,
    required this.currentIndexNumber,
    required this.loginStatus,
    required this.homeData,
    required this.advertisementData,
  }) : super(key: key);

  @override
  _HomeScreensNavigationState createState() => _HomeScreensNavigationState();
}

class _HomeScreensNavigationState extends State<HomeScreensNavigation>
    with TickerProviderStateMixin {
  int currentIndex = 0;


  @override
  void initState() {
    currentIndex = widget.currentIndexNumber;
    userLoginStatus = widget.loginStatus;
    BlocProvider.of<BasketBloc>(context).add(getBasketCounter());
    getUserStatus();
    getUserDatas();
    getBasketCount();
    // TODO: implement initState
    super.initState();
  }

  int basketCount = 0;
  getUserStatus() async {
    userLoginStatus = await isUserLoggedIn();
  }

  String fname = '';
  String lname = '';
  String email = '';
  String phoneno = '';
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
      phoneno = userData.getString('phoneno') == null
          ? ''
          : userData.getString('phoneno')!;
    });
  }

  callback(){
    print("Basket Call back");
        BlocProvider.of<BasketBloc>(context).add(getBasketCounter());
       
    
  }
  callback2(){
       BlocProvider.of<HomeNavigationBloc>(context).add(onHomeIndexChanged(2));
  }
  getBasketCount() async {}
  int countValue = 0;
  String? userLoginStatus;
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
                Text('Alert!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Are you sure want to exit MeroAto?',style: TextStyle(fontSize: 14),),
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
                    child: Text('Ok'),
                    onPressed: ()async {
                      exit(0);
                //     SharedPreferences prefs =
                //       await SharedPreferences.getInstance();
                //   prefs.setString('isDriverLoggedIn', 'false');
                //   prefs.remove('isLoggedIn');
                //   prefs.remove('user_id');
                //   prefs.remove('latitude');
                //   prefs.remove('longitude');
                //   Fluttertoast.showToast(
                //     msg: 'Logged Out',
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.BOTTOM,
                //     backgroundColor: Colors.black54,
                //     textColor: Colors.white,
                //     fontSize: 16.0,
                //   );
                  
                
                //   Get.offAll(BlocProvider(
                //   create: (context) => SignInBloc(context),
                //   child: Loginpage(),
                // ));
                      
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
  @override
  Widget build(BuildContext context) {
    Future<void> doNothing() async {}
    return WillPopScope(
      onWillPop: ()async{
        print('Will Pop Scope');
        _showAlertDialog(context);
        return false;
      },
      child: BlocBuilder<InternetBlocBloc, InternetBlocState>(
        builder: (context, state) {
          return BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              final screens = [
                BlocProvider(
                  create: (context) => LocationBloc(),
                  child: HomePageAppBar(
                    callback:callback,
                    callback2:callback2,
                    homeData: widget.homeData,
                    advertisementData: widget.advertisementData,
                  ),
                ),
                userLoginStatus == "true"
                    ? BlocProvider(
                        create: (context) => BasketBloc(),
                        child: BasketScreen(
                          callback:callback
                        ),
                      )
                    : BlocProvider(
                        create: (context) => SignInBloc(context),
                        child: Loginpage(),
                      ),
                userLoginStatus == "true"
                    ? Profile(
                        name: fname + " " + lname,
                        email: email,
                        phoneno: phoneno,
                      )
                    : BlocProvider(
                        create: (context) => SignInBloc(context),
                        child: Loginpage(),
                      ),
                const MenuScreen(),
              ];
              return Scaffold(
              
                backgroundColor: Color(0XFFF3F3F3),
                body: BlocBuilder<InternetBlocBloc, InternetBlocState>(
                  builder: (context, state) {
                    if (state is InternetGainedState) {
                      return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
                        builder: (context, state) {
                          if (state is FirstPageState) {
                            currentIndex = 0;
                          } else if (state is SecondPageState) {
                            currentIndex = 1;
                          } else if (state is ThirdPageState) {
                            currentIndex = 2;
                          } else if (state is FourthPageState) {
                            currentIndex = 3;
                          }
    
                          return screens[currentIndex];
                        },
                      );
                    } else if (state is InternetLostState) {
                      return NoInternetPage();
                    } else {
                      return NoInternetPage();
                    }
                  },
                ),
                bottomNavigationBar:
                    BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
                  builder: (context, state) {
                    if (state is FirstPageState) {
                      currentIndex = 0;
                    } else if (state is SecondPageState) {
                      currentIndex = 1;
                    } else if (state is ThirdPageState) {
                      currentIndex = 2;
                    } else if (state is FourthPageState) {
                      currentIndex = 3;
                    }
                    return BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if(state is BasketCounterLoaded){
                          countValue= state.count;
                      }
                        return BottomNavigationBar(
                            onTap: (index) {
                              BlocProvider.of<HomeNavigationBloc>(context)
                                  .add(onHomeIndexChanged(
                                index,
                              ));
                            },
                            type: BottomNavigationBarType.fixed,
                            backgroundColor: Colors.white,
                            currentIndex: currentIndex,
                            selectedItemColor: Colors.green,
                            unselectedItemColor: Colors.grey,
                            items: [
                              const BottomNavigationBarItem(
                                icon: Icon(Icons.home, size: 26,),
                                label: 'Home',
                                backgroundColor: Colors.white,
                              ),
                              BottomNavigationBarItem(
                                label: "Baskets",
                                backgroundColor: Colors.pink,
                                icon: countValue > 0
                                    ? Stack(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 5, 25, 0),
                                            child: Icon(
                                              Icons.shopping_cart,
                                              size: 25,
                                            ),
                                          ),
                                          Positioned(
                                            right: 10,
                                            left: 20,
                                            top: 0,
                                            bottom: 10,
                                            child: Container(
                                              height: 5,
                                              width: 5,
                                              padding: EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                // border: Border.all(
                                                //     color: Colors.white),
                                              ),
                                              child: Text(
                                                countValue.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Icon(
                                        Icons.shopping_cart,
                                        size: 25,
                                      ),
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.account_circle_rounded, size: 25,),
                                label: 'Account',
                                backgroundColor: Colors.blue,
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(
                                  Icons.menu, size: 25,
                                ),
                                label: 'More',
                                backgroundColor: Colors.red,
                              ),
                            ]);
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
