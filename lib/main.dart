import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'User/Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import 'User/Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import 'User/Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import 'User/Controller/bloc/Home/location/bloc/location_bloc.dart';
import 'User/Controller/bloc/internet/bloc/internet_bloc_bloc.dart';
import 'User/View/scrollbehavior.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'User/View/Screens/splashscreen.dart'; // <-------- User View
//import 'Driver/View/view/driver_splashscreen.dart'; // <-------- Driver View
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart'as sql;
import 'package:audioplayers/audioplayers.dart';


void main() async{
  print("Main is Initialized");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String token ='';
  FirebaseMessaging messaging = FirebaseMessaging.instance;
 await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('Token $value');
              token = value.toString();
            });
          });
  await messaging.subscribeToTopic('meroAto_users');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitializationSetting = DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosInitializationSetting);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'Poppins',
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Builder(builder: (context) {
      return KhaltiScope(
          publicKey: 'test_public_key_31fcc2ac52e5486d8e36f522f9e099c7',
          enabledDebugging: true,
          builder: (context, navKey) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<InternetBlocBloc>(
                  create: (context) => InternetBlocBloc(),
                ),
                BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(context),
                ),
                BlocProvider<SignUpBloc>(
                  create: (context) => SignUpBloc(),
                ),
                BlocProvider<HomePageBloc>(
                  create: (context) => HomePageBloc(),
                ),
              ],
              child: GetMaterialApp(
                scrollBehavior: NoGlowScrollBehavior(),
                theme: theme,
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                navigatorKey: navKey,
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
                routes: {
                  '/': (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => ServiceProviderDetailBloc(),
                          ),
                          BlocProvider(
                            create: (context) => LocationBloc(),
                          ),
                        ],
                        child:SplashScreen1(),
                      ),
                },
              ),
            );
          });
    });
  }
}

class MyScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics(); // Customize the scroll physics
  }
}
