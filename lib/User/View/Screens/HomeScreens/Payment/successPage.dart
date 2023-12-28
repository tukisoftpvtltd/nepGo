import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import '../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';

import '../Home/HomeScreensNavigation.dart';
import 'customButton.dart';

// ignore: must_be_immutable
class PaymentSucessPage extends StatefulWidget {
  dynamic total;
  dynamic type;
  PaymentSucessPage({super.key, this.total, this.type});

  @override
  State<PaymentSucessPage> createState() => _PaymentSucessPageState();
}

class _PaymentSucessPageState extends State<PaymentSucessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 26,
          ),
          onPressed: () {
            Get.offAll(BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(context),
              child: BlocProvider<HomePageBloc>(
                create: (context) => HomePageBloc(),
                child: BlocProvider(
                  create: (context) => HomeNavigationBloc(),
                  child: BlocProvider(
                    create: (context) => BasketBloc(),
                    child: HomeScreensNavigation(
                      currentIndexNumber: 0,
                      loginStatus: "true",
                      homeData: [],
                      advertisementData: [],
                    ),
                  ),
                ),
              ),
            ));
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.offAll(BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(context),
            child: BlocProvider<HomePageBloc>(
              create: (context) => HomePageBloc(),
              child: BlocProvider(
                create: (context) => HomeNavigationBloc(),
                child: BlocProvider(
                  create: (context) => BasketBloc(),
                  child: HomeScreensNavigation(
                    currentIndexNumber: 0,
                    loginStatus: "true",
                    homeData: [],
                    advertisementData: [],
                  ),
                ),
              ),
            ),
          ));
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 100,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Payment Success',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        top: 10,
                        iconData: Icons.home,
                        isIcon: true,
                        name: 'Continue Purchasing',
                        handleClicked: () {
                          Get.offAll(BlocProvider<SignInBloc>(
                            create: (context) => SignInBloc(context),
                            child: BlocProvider<HomePageBloc>(
                              create: (context) => HomePageBloc(),
                              child: BlocProvider(
                                create: (context) => HomeNavigationBloc(),
                                child: BlocProvider(
                                  create: (context) => BasketBloc(),
                                  child: HomeScreensNavigation(
                                    currentIndexNumber: 0,
                                    loginStatus: "true",
                                    homeData: [],
                                    advertisementData: [],
                                  ),
                                ),
                              ),
                            ),
                          ));
                        },
                        width: Get.width - 100,
                        height: 20,
                        fontSize: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
