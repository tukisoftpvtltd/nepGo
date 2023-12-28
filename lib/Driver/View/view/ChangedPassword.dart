import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/repositories/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../User/View/widgets/button.dart';
import '../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../../Controller/repository/changeDriverPassword.dart';
import '../components/colors.dart';




class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool? oldPasswordValid;
  bool? newPasswordValid;
  bool obscureText1=true;
  bool obscureText2=true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController= TextEditingController();
  bool loading=false;
  
  changePassword()async{
    setState(() {
      loading = true;
    });
    ChangeDriverPasswordRepository repo = new ChangeDriverPasswordRepository();
    ChangeDriverPasswordResponse response =await repo.ChangeDriverPassword('',oldPasswordController.text);
    setState(() {
      loading = false;
    });
  }

  initState(){
    getUserId();
  }
  String? userId = '';
  getUserId()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId  = prefs.getString('user_id');
    print("The user id is" );
    print(userId);
  
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        // BlocProvider.of<SignUpBloc>(context).add(
        //                           SignUpInitialEvent());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Container(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                //  BlocProvider.of<SignUpBloc>(context).add(
                //                   SignUpInitialEvent());
                Navigator.pop(context);
              },
            ),
          ),
          ),
          elevation: 0,
          title: Text("Change Password",style: TextStyle(color: Colors.black),),
        ),
        body: ListView(
     
          children: [
            const SizedBox(height: 20),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        Color borderColor = Colours.primarybrown;
                        if (state is SignUpPasswordValidState) {
                          oldPasswordValid = true;
                        }
                        if (state is SignUpPasswordInValidState) {
                          oldPasswordValid = false;
                        }
                        if (oldPasswordValid == true) {
                          borderColor = Colours.primarygreen;
                        } else if (oldPasswordValid == false) {
                          borderColor = Colors.red;
                        } else {
                          borderColor = Colours.primarybrown;
                        }
                        if (state is SignUpPasswordVisible) {
                          obscureText1 = true;
                        }
                        if (state is SignUpPasswordInVisible) {
                          obscureText1 = false;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            width: screenWidth * 0.85,
                            child: TextField(
                                onChanged: (value) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpPasswordChangedEvent(
                                          oldPasswordController.text));
                                },
                                onEditingComplete:(){
                              },
                                // controller: password,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8.0),
                                  labelText: "New Password",
                                  floatingLabelStyle: TextStyle(color: borderColor),
                                  labelStyle:
                                      TextStyle(color: Colours.primarybrown),
                                  hintText: "",
                                  hintStyle:
                                      const TextStyle(color: Colours.primarybrown),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: borderColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.visibility,
                                      color: obscureText1
                                          ? Colors.grey
                                          : Colours.primarygreen,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                      obscureText1 =!obscureText1;
                                        
                                      });
                                          print(obscureText1);
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                ),
                                controller: oldPasswordController,
                                obscureText: obscureText1),
                          ),
                        );
                      },
                    ),
                  
                  //   const SizedBox(height: 10),
                  //  BlocBuilder<SignUpBloc, SignUpState>(
                  //     builder: (context, state) {
                  //       Color borderColor2 = Colours.primarybrown;
                  //       // if (state is SignUpNewPasswordValidState) {
                  //       //   newPasswordValid = true;
                  //       // }
                  //       // if (state is SignUpNewPasswordInValidState) {
                  //       //   newPasswordValid = false;
                  //       // }
                  //       // if (newPasswordValid == true) {
                  //       //   borderColor2 = Colours.primarygreen;
                  //       // } else if (newPasswordValid == false) {
                  //       //   borderColor2 = Colors.red;
                  //       // } else {
                  //       //   borderColor2 = Colours.primarybrown;
                  //       // }
                  //       // if (state is SignUpNewPasswordVisible) {
                  //       //   obscureText2 = true;
                  //       // }
                  //       // if (state is SignUpNewPasswordInVisible) {
                  //       //   obscureText2 = false;
                  //       // }
                  //       return SizedBox(
                  //         width: screenWidth * 0.85,
                  //         child: TextField(
                  //             onChanged: (value) {
                  //               // BlocProvider.of<SignUpBloc>(context).add(
                  //               //     SignUpNewPasswordChangedEvent(
                  //               //         newPasswordController.text));
                  //             },
                  //             onEditingComplete:(){
                  //           },
                  //             // controller: password,
                  //             decoration: InputDecoration(
                  //               contentPadding:
                  //                   EdgeInsets.symmetric(vertical: 8.0),
                  //               labelText: "New Password",
                  //               floatingLabelStyle: TextStyle(color: borderColor2),
                  //               labelStyle:
                  //                   TextStyle(color: Colours.primarybrown),
                  //               hintText: "",
                  //               hintStyle:
                  //                   const TextStyle(color: Colours.primarybrown),
                  //               prefixIcon: Icon(
                  //                 Icons.lock,
                  //                 color: borderColor2,
                  //               ),
                  //               suffixIcon: IconButton(
                  //                 icon: Icon(
                  //                   Icons.visibility,
                  //                   color: obscureText2
                  //                       ? Colors.grey
                  //                       : Colours.primarygreen,
                  //                 ),
                  //                 onPressed: () {
                  //                    setState(() {
                  //                   obscureText2 =!obscureText2;
                                      
                  //                   });
                  //                 },
                  //               ),
                  //               border: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: borderColor2),
                  //               ),
                  //               focusedBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(color: borderColor2),
                  //               ),
                  //             ),
                  //             controller: newPasswordController,
                  //             obscureText: obscureText2),
                  //       );
                  //     },
                  //   ),
                    
                    // BlocBuilder<SignUpBloc, SignUpState>(
                    //   builder: (context, state) {
                    //     if (state is SignUpErrorState) {
                    //       return Text(
                    //          state.errorMessage.replaceAll('[', '').replaceAll(']', ''),
                    //         style: TextStyle(
                    //             fontFamily: 'Poppins',
                    //             color: Colors.red,
                    //             fontWeight: FontWeight.w400),
                    //       );
                    //     } else {
                    //       return Container();
                    //     }
                    //   },
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15.0),
                      child: Container(
                                    height: 40,
                                    width:  screenWidth * 0.85,
                                    child: CustomButton(
                      label: loading == false ?'CHANGE PASSWORD':"loading",
                      color: Colours.primarygreen,
                      onpressed: () {
                        if(oldPasswordValid ==true){
                          changePassword();
                        }
                       
                      }),
                                  ),
                    ),
          ]),),
    );
  }
}