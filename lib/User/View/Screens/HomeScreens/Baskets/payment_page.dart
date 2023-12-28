import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../Controller/bloc/Home/location/bloc/location_bloc.dart';
import '../../../../Controller/repositories/Payment/payment_repository.dart';
import '../../../../Controller/repositories/controlSystem/getControlSystemPlayerId.dart';
import '../../../../Controller/repositories/get_nearby_driver.dart';
import '../../../../Model/nearbyControlSystemModel.dart';
import '../../../../Model/nearby_driver_model.dart';
import '../../../constants/colors.dart';
import '../../../custome_loader.dart';
import '../../../widgets/BackButton2.dart';
import '../Home/HomeScreensNavigation.dart';
import '../Home/Location/LocationChangePage.dart';
import '../Home/Location/locationPageView.dart';
import '../Payment/Khalti/khaltiPayment.dart';
import '../Payment/e-Sewa/eSewaPayment.dart';
import '../Payment/successPage.dart';
import 'package:http/http.dart'as http;

class PaymentPage extends StatefulWidget {
  final String serviceProviderName;
  final String serviceProviderlocation;
  final String logoUrl;
  final String phoneNo;
  final String sid;
  int total_value;
  List basketItem;
   PaymentPage(
    {super.key,
    required this.serviceProviderName,
    required this.serviceProviderlocation,
    required this.logoUrl,
    required this.sid,
    required this.phoneNo,
    required this.total_value,
    required this.basketItem});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
String? tCode; 
String item1 ='';
String quantity1='';
String item2='';
String quantity2='';
String? userId ='';
TextEditingController remarks = TextEditingController();
getUserId()async{
   SharedPreferences userData = await SharedPreferences.getInstance();
  userId = userData .getString('user_id');
  tCode = tCode.toString() + userId.toString();
  print("The final tcode is");
  print(tCode);
}
  initState() {
    BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
     String randomString = randomAlphaNumeric(10);
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} ${_twoDigits(now.hour)}:${_twoDigits(now.minute)}";
 tCode = "$randomString$formattedDateTime";
 getUserId();
 print("The basket Item is");
 item1 = widget.basketItem[0].itemName??'';
quantity1 = widget.basketItem[0].quantity.toString() ??'';
 if (widget.basketItem.length > 1) {
item2 = widget.basketItem[1].itemName ?? '';
quantity2 = widget.basketItem[1].quantity.toString() ?? '';
}
 print(item1);
print(quantity1);
print(item2);
print(quantity2);
  }
    String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    } else {
      return "0$n";
    }
    
  }
  callback(){
        BlocProvider.of<LocationBloc>(context).add(OnLocationLoading());
  }

  
  String? latitude;
  String? longitude;
  String? locationName;
  String? placeName;
  int _selectedRadio = 1;
  
  bool esewa = false;
  bool cash = false;
  bool khalti = false;
  bool agreeTerms = false;
  bool greenCard1 = false;
  bool greenCard2 = false;
  bool greenCard3 = false;
  bool makeCashGreen = false;
  bool makeEsewaGreen = false;
  bool makeKhaltiGreen = false;
  bool makeTermsRed = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: BackButton2(),
            title: const Text(
              'Payment',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: Colors.white,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Delivery Address",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        BlocBuilder<LocationBloc, LocationState>(
                          
                          builder: (context, state) {
                            if(state is LocationLoadingState){
                              locationName = 'Location Name';
                              placeName ='Place Name';
                          }
                          if(state is LocationLoadedState){
                            locationName = state.LocationName;
                            placeName = state.PlaceName;
                            latitude = state.latitude;
                            longitude = state.longitude;
                            
                          }
                          else{
                            locationName = '';
                            placeName ='';
                          }
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth / 1.5,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    locationName!,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                  // Icon(
                                                  //   FontAwesomeIcons.edit,
                                                  //   size: 15,
                                                  //   color: Colours.primarygreen,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      placeName!,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  // Icon(
                                                  //   FontAwesomeIcons.trash,
                                                  //   size: 15,
                                                  //   color: Colors.red,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "+977 ${widget.phoneNo}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationChangePage(
                        fromPayment: true,
                        callback:callback,
                          currentLocation: "$locationName, $placeName",
                          position: LatLng(double.parse(latitude!), double.parse(longitude!)),)));
                                    },
                                    child: Container(
                                      width: screenWidth / 4,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            "Address",
                                            style:
                                                TextStyle(color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          color: Colors.white,
                          height: 10,
                        ),
                        Container(
                          color: Color(0xFFF3F3F3),
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Pay through different means",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal:10.0),
                               child: Container(
                                height: 120,
                                 child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                   GestureDetector(
                              onTap: () {
                              setState(() {
                               makeCashGreen = !makeCashGreen;
                               makeEsewaGreen =false;
                               makeKhaltiGreen = false;
                              });
                                },
                               child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                          border: Border.all(
                                          width: 2,
                                          color: makeCashGreen? Colours.primarygreen :
                                           Colors.grey.shade200,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: screenWidth/2.25,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text( "Cash On Delivery",
                                                      
                                                    style: TextStyle(fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    ),),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Container(
                                                      height:40,
                                                      width: 40,
                                                      child: Image.asset(
                                                       'assets/images/cash2.png'
                                                         ))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      child: Text(
                                                      'Pay in cash upon delivery',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                      child: Icon(Icons.check_circle,
                                                      color: 
                                                      makeCashGreen? Colours.primarygreen : Colors.grey.shade500,
                                                     ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                              onTap: () {
                              setState(() {
                                makeCashGreen =false;
                               makeEsewaGreen = !makeEsewaGreen;
                               makeKhaltiGreen =false;
                              });
                                },
                               child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                          border: Border.all(
                                          width: 2,
                                          color: makeEsewaGreen ? Colours.primarygreen :
                                           Colors.grey.shade200,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: screenWidth/2.25,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text( "Esewa",
                                                    style: TextStyle(fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    ),),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Container(
                                                      height:40,
                                                      width: 40,
                                                      child: Image.asset(
                                                       'assets/images/esewa-icon.png'
                                                         ))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      child: Text(
                                                      'Pay using Esewa digital wallet',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                      child: Icon(Icons.check_circle,
                                                      color: 
                                                     makeEsewaGreen ? Colours.primarygreen : Colors.grey.shade500,
                                                     ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                              onTap: () {
                              setState(() {
                                makeCashGreen =false;
                                makeEsewaGreen =false;
                               makeKhaltiGreen = !makeKhaltiGreen;
                              });
                                },
                               child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                          border: Border.all(
                                          width: 2,
                                          color: makeKhaltiGreen? Colours.primarygreen :
                                           Colors.grey.shade200,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: screenWidth/2.25,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text( "Khalti",
                                                      
                                                    style: TextStyle(fontFamily: "Poppins",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    ),),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Container(
                                                      height:40,
                                                      width: 40,
                                                      child: Image.asset(
                                                       'assets/images/khalti-icon.png'
                                                         ))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      child: Text(
                                                      'Pay using khalti digital wallet',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                      child: Icon(Icons.check_circle,
                                                      color: 
                                                      makeKhaltiGreen? Colours.primarygreen : Colors.grey.shade500,
                                                     ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    
                                  ],
                                 ),
                               ),
                             ),
                    
                    SizedBox(
                      height: 13,
                    ),
                    
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: remarks,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                              hintText:
                                  'Type Here If You Have Specific Requirement For This Delivery', // Hint text

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                      children: [
                        Checkbox(
                            value: agreeTerms,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                agreeTerms = !agreeTerms;
                              });
                            }),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Agree with Terms and Conditions',
                              style: TextStyle(color:makeTermsRed ==false? Colors.black:Colors.red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    agreeTerms = !agreeTerms;
                                  });
                                }),
                          TextSpan(
                            text: '',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            'Terms and Conditions',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        content: Text(
                                          """This contains all the terms and conditions""",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Close',
                                              ))
                                        ],
                                      );
                                    });
                              },
                          ),
                        ])),
                      ],
                    ),
                    SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                print("Hello");
                                print(_selectedRadio);
                                print(agreeTerms);
                                if(agreeTerms == false){
                                  setState(() {
                                    makeTermsRed=true;
                                  });
                                }
                                else if(makeEsewaGreen == true && agreeTerms == true){
                                  Esewa esewa = Esewa();
                                  esewa.pay(sid: widget.sid,
                                  discount:0 ,
                                  vat: 0,
                                  amount:widget.total_value,
                                  tCode:tCode!,
                                  item1:item1,
                                  quantity1:quantity1,
                                  item2:item2,
                                  quantity2:quantity2,
                                  serviceProviderName:widget.serviceProviderName,
                                  serviceProviderLocation:widget.serviceProviderlocation,
                                  logoUrl:widget.logoUrl,
                                  remarks : remarks.text
                                  );
                                
                                  
                                }
                                else if(makeKhaltiGreen ==true && agreeTerms == true){
                                  Khalti khalti = Khalti();
                                  khalti.payWithKhalti(context, 100);
                                }
                                else if(makeCashGreen ==true && agreeTerms == true){
                                  setState(() {
                                    loading = true;
                                  });
                                 
                                  AddSale payment = new AddSale();
  SharedPreferences prefs =await SharedPreferences.getInstance();
prefs.getString('isLoggedIn');
List<String> AllPlayerIds = [];
SharedPreferences _locationDetail = await SharedPreferences.getInstance();
String? latitude = _locationDetail.getString('latitude');
String? longitude = _locationDetail.getString('longitude');
String? locationName =  _locationDetail.getString('locationName');
String? placeName =  _locationDetail.getString('placeName');
 SharedPreferences userData = await SharedPreferences.getInstance();
        String? userId = userData .getString('user_id');

  payment.PostSale(
        userId: userId!,
        sid: widget.sid,
        mode_of_payment: 'cash',
        discount: "0",
        vat: "0",
        amount: "${widget.total_value}",
        paymentNote: "online payment",
        remarks: remarks.text,
        taxable: "0",
        nonTaxable: "${widget.total_value}",
        delivery_location: "$locationName,$placeName",
        lat: latitude!,
        long: longitude!,
        PaymentStatus: '1',
        payment_transaction_id: "cash",
        total:  "${widget.total_value}",
        distance: "1.5",
        delivery_charge: "0",
         payment_note: '',
         tCode:tCode!,
        );
    //     var status = await OneSignal.shared.getDeviceState();
    // String? playerId = status!.userId;
    // print("Your player id is");
    // print(playerId);
    String playerId ='';
     await FirebaseMessaging.instance.requestPermission().then((value) {
            FirebaseMessaging.instance.getToken().then((value) {
              print('Token $value');
              playerId= value.toString();
            });
          });
  NearByControlSytemRepository repo0 = NearByControlSytemRepository();
   NearByControlSytemModel model0 = await repo0.getNearByDriverData(latitude, longitude);
  AllPlayerIds.add(model0.nearestControlSystem!.playerId.toString());
  NearByDriverRepository repo = NearByDriverRepository();
  NearByDriverModel model = await repo.getNearByDriverData(latitude, longitude,'0','0');
  if(model.nearByDriverPlayerIds!= []){

  
  for(int i =0 ; i< model.nearByDriverPlayerIds!.length;i++){
  print(model.nearByDriverPlayerIds![i].playerId);
  if(model.nearByDriverPlayerIds![i].playerId != null){
    AllPlayerIds.add(model.nearByDriverPlayerIds![i].playerId!);
  }
  
  }
  
  print("All player Ids are");
  print(AllPlayerIds);
  print("the tcode sent is"+tCode!);
  List notifications =[];
  for(int i=0;i<AllPlayerIds.length;i++){
    var data = {
      'to' : AllPlayerIds[i],
      'priority': 'high',
      'data':{
        'userId': userId!,
        'sid': widget.sid,
        'serviceProviderName': widget.serviceProviderName,
        'serviceProviderLocation':widget.serviceProviderlocation,
        'logoUrl': widget.logoUrl,
        'basketItems' : '',
        'mode_of_payment': 'esewa',
        'discount': "40",
        'vat': "40",
        'amount': "${widget.total_value}",
        'paymentNote': "online payment",
        'remarks': "deliver fast",
        'taxable': "0",
        'nonTaxable': "${widget.total_value}",
        'delivery_location': "$locationName,$placeName",
        'lat': latitude!,
        'long': longitude!,
        'PaymentStatus': '1',
        'payment_transaction_id': "cash",
        'total':  "${widget.total_value}",
        'distance': "1.5",
        'delivery_charge': "40",
         'payment_note': '',
         "customerPlayerId":playerId,
         "tCode":tCode,
         "item1":item1,
         "quantity1":quantity1,
         "item2":item2,
         "quantity2":quantity2
      }
      };
      print(data);
      print("posting Data to");
       print(AllPlayerIds[i]);
      await http.post (
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'key=AAAASqAhBeo:APA91bEr_k94xZJDExRiCHH2PEhq7E1NgmF4zwldXGUt-958VG20RUECTOq0a6jYRgAbYM3uw5dkLbrPwWOk32RAszXD9xeP-8h6b4yGgfYIaaVAEPAWDpF3F--s5QnXClHZN9FPA9WO'
    }
    );
    //print("The response is $response");
  // notifications.add( OSCreateNotification(
  //     heading: 'New Order Request',
  //     playerIds: [AllPlayerIds[i]],
  //     content: "To $locationName,$placeName",
  //     additionalData: {
  //       'userId': userId!,
  //       'sid': widget.sid,
  //       'serviceProviderName': widget.serviceProviderName,
  //       'serviceProviderLocation':widget.serviceProviderlocation,
  //       'logoUrl': widget.logoUrl,
  //       'basketItems' : '',
  //       'mode_of_payment': 'esewa',
  //       'discount': "40",
  //       'vat': "40",
  //       'amount': "${widget.total_value}",
  //       'paymentNote': "online payment",
  //       'remarks': "deliver fast",
  //       'taxable': "0",
  //       'nonTaxable': "${widget.total_value}",
  //       'delivery_location': "$locationName,$placeName",
  //       'lat': latitude!,
  //       'long': longitude!,
  //       'PaymentStatus': '1',
  //       'payment_transaction_id': "cash",
  //       'total':  "${widget.total_value}",
  //       'distance': "1.5",
  //       'delivery_charge': "40",
  //        'payment_note': '',
  //        "customerPlayerId":playerId,
  //        "tCode":tCode,
  //        "item1":item1,
  //        "quantity1":quantity1,
  //        "item2":item2,
  //        "quantity2":quantity2
  //     }
  //   ));
    };
     Get.offAll(PaymentSucessPage());
    
    // var datum ={
    //     'userId': userId!,
    //     'sid': widget.sid,
    //     'mode_of_payment': 'cash',
    //     'discount': "40",
    //     'vat': "40",
    //     'amount': "${widget.total_value}",
    //     'paymentNote': "online payment",
    //     'remarks': "deliver fast",
    //     'taxable': "0",
    //     'nonTaxable': "${widget.total_value}",
    //     'delivery_location': "$locationName,$placeName",
    //     'lat': latitude!,
    //     'long': longitude!,
    //     'PaymentStatus': '1',
    //     'payment_transaction_id': "cash",
    //     'total':  "${widget.total_value}",
    //     'distance': "1.5",
    //     'delivery_charge': "40",
    //      'payment_note': '',
    //      "customerPlayerId":playerId,
    //       "tCode":tCode,
    //      "item1":item1,
    //      "quantity1":quantity1,
    //      "item2":item2,
    //      "quantity2":quantity2
    //   };
    // print(datum);
   

    //   for(int i=0;i<AllPlayerIds.length;i++){
    //     try{
    // await OneSignal.shared.postNotification(notifications[i]);
    //   }
    //   catch(e){
    //     print("The error is "+e.toString());
    //   }
    //   }
      }
 
  // setState(() {
  //                                   loading = false;
  //                                 });
                                  
  //                                 Get.offAll(
  //        BlocProvider<SignInBloc>(
  //               create: (context) => SignInBloc(context),
  //               child: BlocProvider<HomePageBloc>(
  //                 create: (context) => HomePageBloc(),
  //                 child: BlocProvider(
  //                   create: (context) => HomeNavigationBloc(),
  //                   child: HomeScreensNavigation(
  //                     currentIndexNumber: 0,
  //                     loginStatus: "true",
  //                     homeData: [],
  //                     advertisementData:[],
  //                   ),
  //                 ),
  //               ),
  //             )
  // );  
        //        Fluttertoast.showToast(
        //       msg: "Order Placed",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       backgroundColor: Colors.grey[600],
        //       textColor: Colors.white,
        //       fontSize: 16.0,
        // );                                
                                    //  sendNotificationTonearbyDrivers();
                                }
                                else{
                                   Fluttertoast.showToast(
              msg: "Select Payment Method",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey[600],
              textColor: Colors.white,
              fontSize: 16.0,
        );       
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colours.primarygreen,
                                  ),
                                  width: screenWidth - 20,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "Pay Now",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                          ],
                        ),

                      ]),
                ),
              ),
            ],
          ),
        ),
      
      loading == true ?CustomeLoader():Container()
      ],
    );
  }
}

class PayCard extends StatefulWidget {
  final int cardNumber; int cardTapped;
   PayCard({super.key,required this.cardNumber,required  this.cardTapped});

  @override
  State<PayCard> createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> {
  bool onCashTapped =false;
  bool onEsewaTapped =false;
  bool onKhalitTapped =false;
  int count =0;

  @override
  Widget build(BuildContext context) {
  
    double screenWidth = MediaQuery.of(context).size.width;
    return
    //  GestureDetector(
    //   onTap: (){
    //     if(widget.cardNumber ==1)
    //     {setState(() {
    //       if(count ==0){
    //       onCashTapped = true;
    //       onEsewaTapped = false;
    //       onKhalitTapped = false;
    //       count++;
    //       }
    //       else{
    //       onCashTapped = false;
    //       onEsewaTapped = false;
    //       onKhalitTapped = false;
    //       count--;
    //       }
          
    //       });
    //     }
    //     if(widget.cardNumber ==2)
    //     {setState(() {
    //       onCashTapped = false;
    //       onEsewaTapped = true;
    //       onKhalitTapped = false;
    //       });
    //     }
    //     if(widget.cardNumber ==3)
    //     {setState(() {
    //       onCashTapped = false;
    //       onEsewaTapped = false;
    //       onKhalitTapped = true;
    //       });
    //     }
    //   },
    //   child: 
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                      border: Border.all(
                                      width: 2,
                                      color: (onCashTapped && (widget.cardNumber ==1))? Colours.primarygreen :
                                      (onEsewaTapped && (widget.cardNumber ==2))? Colours.primarygreen :
                                      (onKhalitTapped && (widget.cardNumber ==3))? Colours.primarygreen 
                                      : Colors.grey.shade200,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: screenWidth/2.25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  widget.cardNumber == 1? "Cash On Delivery":
                                                  widget.cardNumber ==2?"Esewa":
                                                  widget.cardNumber ==3 ?"Khalti":
                                                  "",
                                                style: TextStyle(fontFamily: "Poppins",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                ),),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Container(
                                                  height:40,
                                                  width: 40,
                                                  child: Image.asset(
                                                    widget.cardNumber ==1?'assets/images/cash2.png':
                                                    widget.cardNumber ==2?'assets/images/esewa-icon.png':
                                                    widget.cardNumber ==3?"assets/images/khalti-icon.png":
                                                    "assets/images/khalti-icon.png"
                                                     ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  child: Text(
                                                  widget.cardNumber ==1?'Pay in cash upon delivery':
                                                  widget.cardNumber ==2?'Pay using E-sewa digital wallet':
                                                  widget.cardNumber ==3?'Pay using khalti digital wallet':
                                                  ''
                                                  ,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal:5.0),
                                                  child: Icon(Icons.check_circle,
                                                  color: 
                                                  (onCashTapped && (widget.cardNumber ==1))? Colours.primarygreen :
                                      (onEsewaTapped && (widget.cardNumber ==2))? Colours.primarygreen :
                                      (onKhalitTapped && (widget.cardNumber ==3))? Colours.primarygreen 
                                      : Colors.grey.shade500,
                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
   // );
  }
}

sendNotificationToDriver(){
  
}