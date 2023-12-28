import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';


class VerifyOTP extends StatefulWidget {
  const VerifyOTP ({Key? key}) : super(key: key);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP > {
  int min =1;
  int second=59;
  void startTimer(){
    const onSec = Duration(seconds: 1 );
    Timer timer = Timer.periodic(onSec, (timer) {
      if(min==0 && second == 0){
        setState(() {
          timer.cancel();
        });
      }
      else{
        setState(() {
          if(second == 0){
            min--;
            second=60;
          }
          else {
            second--;
          }
        });
      }
    });
  }

  bool _passwordVisible = false ;
  @override
  // ignore: must_call_super
  void initState() {
    setState(() {
      min=1;
      second=59;
    });

    startTimer();

  }
  final _userPasswordController = TextEditingController();
  bool boxColor1 = false;
  bool boxColor2 = false;
  bool boxColor3 = false;
  bool boxColor4 = false;
  bool boxColor5 = false;

  @override
  Widget build(BuildContext context) {




    _goToSignUpSetPassword() async{
     
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:  [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 100 , 0, 0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text("Please enter the OTP you recieved on 98******93",
                  
              ),
            ),
          ),
          Form(
              child:
              Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,15,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: boxColor1 ? Colors.green : Colors.grey ,width: 1.4 ) ,borderRadius: BorderRadius.circular(10) ),
                          height: 55,
                          width: 55,
                          child: TextFormField(

                            onChanged: (value){
                              if(value.length ==1 ){
                                FocusScope.of(context).nextFocus();
                                setState(() {
                                  boxColor1=true;
                                });
                              }
                              if(value.length == 0){
                                setState(() {
                                  boxColor1= false;
                                });
                              }

                            },

                            onSaved: (pin1){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,

                            style: Theme.of(context).textTheme.headline6 ,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: boxColor2 ? Colors.green : Colors.grey ,width: 1.4 ) ,borderRadius: BorderRadius.circular(10) ),
                          height: 55,
                          width: 55,
                          child: TextFormField(

                            onChanged: (value){
                              if(value.length ==1 ){
                                FocusScope.of(context).nextFocus();
                                setState(() {
                                  boxColor2 = true;
                                });
                              }
                              if(value.length ==0 ){

                                FocusScope.of(context).previousFocus();
                                setState(() {
                                  boxColor2 = false;
                                });
                              }
                            },

                            onSaved: (pin1){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,

                            style: Theme.of(context).textTheme.headline6 ,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: boxColor3 ? Colors.green : Colors.grey ,width: 1.4 ) ,borderRadius: BorderRadius.circular(10) ),
                          height: 55,
                          width: 55,
                          child: TextFormField(

                            onChanged: (value){
                              if(value.length ==1 ){
                                FocusScope.of(context).nextFocus();
                                setState(() {
                                  boxColor3 = true;
                                });
                              }
                              if(value.length ==0 ){

                                FocusScope.of(context).previousFocus();
                                setState(() {
                                  boxColor3 = false;
                                });
                              }
                            },

                            onSaved: (pin1){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,

                            style: Theme.of(context).textTheme.headline6 ,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: boxColor4 ? Colors.green : Colors.grey ,width: 1.4 ) ,borderRadius: BorderRadius.circular(10) ),
                          height: 55,
                          width: 55,
                          child: TextFormField(

                            onChanged: (value){
                              if(value.length ==1 ){
                                FocusScope.of(context).nextFocus();
                                setState(() {
                                  boxColor4 = true;
                                });
                              }
                              if(value.length ==0 ){

                                FocusScope.of(context).previousFocus();

                                setState(() {
                                  boxColor4 = false;
                                });
                              }
                            },

                            onSaved: (pin1){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,

                            style: Theme.of(context).textTheme.headline6 ,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: boxColor5 ? Colors.green : Colors.grey ,width: 1.4 ) ,borderRadius: BorderRadius.circular(10) ),
                          height: 55,
                          width: 55,
                          child: TextFormField(

                            onChanged: (value){
                              if(value.length ==1 ){
                                setState(() {
                                  boxColor5 = true;
                                });

                              }
                              if(value.length ==0 ){

                                FocusScope.of(context).previousFocus();
                                setState(() {
                                  boxColor5 = false;
                                });
                              }
                            },

                            onSaved: (pin1){},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,

                            style: Theme.of(context).textTheme.headline6 ,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),



                      ],
                    ),
                  )
                 ,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,25,15,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Expires in ',
                            
                        ),
                        Text("$min: $second",
                          
                        ),

                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap : (){_goToSignUpSetPassword();},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB (15,20,15,10),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: boxColor1 && boxColor2 && boxColor3 && boxColor4 && boxColor5 ? Colors.green : Color(0xFF19D17A ).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,0,0),
                          child: Container(
                            child: Center(
                              child: Text("Confirm OTP",
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       min=1;
                       second=59;
                     });
                   },
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(0,15,0,0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        
                         Text("  Resend again",
                             ),
                       ],
                     ),
                   ),
                 )
                ],
              )
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,250,0,30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Help"),
                  Text("Support"),
                ],
              ),
            ),
          ),

        ],
      ),

    );
  }
}