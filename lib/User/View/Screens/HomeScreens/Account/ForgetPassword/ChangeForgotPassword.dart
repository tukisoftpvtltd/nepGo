import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../../../../../Controller/repositories/resetPassword.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/button.dart';

class ChangeForgotPassword extends StatefulWidget {
  String uid;
  ChangeForgotPassword({super.key,required this.uid});

  @override
  State<ChangeForgotPassword> createState() => _ChangeForgotPasswordState();
}

class _ChangeForgotPasswordState extends State<ChangeForgotPassword> {
  // bool? oldPasswordValid;
  // bool? newPasswordValid;
  bool obscureText1=true;
  bool obscureText2=true;
  // TextEditingController oldPasswordController = TextEditingController();
  // TextEditingController newPasswordController= TextEditingController();
  bool loading=false;
  
  changePassword()async{
    setState(() {
      loading = true;
    });
    ResetPasswordRepository repo = new ResetPasswordRepository();
    bool response =await repo.resetPassword(widget.uid, passwordController.text);
    setState(() {
      loading = false;
    });
    Get.back();
    Get.back();
    Get.back();
    
  }

  initState(){
    
    // getUserId();
  }
  // String? userId = '';
  // getUserId()async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   userId  = prefs.getString('user_id');
  //   print("The user id is" );
  //   print(userId);
  
  // }
    bool? passwordValid;
    FocusNode? _focusNode4;
    TextEditingController passwordController = TextEditingController();
    FocusNode? _focusNode5;
    bool? confirmPasswordValid;
    TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpInitialEvent());
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
                 BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpInitialEvent());
                Navigator.pop(context);
              },
            ),
          ),
          ),
          elevation: 0,
          title: Text("Change Password",style: TextStyle(color: Colors.black),),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpPasswordValidState) {
                            passwordValid = true;
                          }
                          if (state is SignUpPasswordInValidState) {
                            passwordValid = false;
                          }
                          if (passwordValid == true) {
                            borderColor = Colours.primarygreen;
                          } else if (passwordValid == false) {
                            borderColor = Colors.red;
                          } else {
                            borderColor = Colours.primarybrown;
                          }
                          if (state is SignUpNewPasswordVisible) {
                            obscureText1 = true;
                          }
                          if (state is SignUpNewPasswordInVisible) {
                            obscureText1 = false;
                          }
                          return SizedBox(
                            width: screenWidth * 0.85,
                            child: TextField(
                                focusNode: _focusNode4,
                                onChanged: (value) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpPasswordChangedEvent(
                                          passwordController.text));
                                },
                                onEditingComplete:(){
                                FocusScope.of(context).requestFocus(_focusNode5);
                              },
                                // controller: password,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8.0),
                                  labelText: "Password*",
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
                                      BlocProvider.of<SignUpBloc>(context).add(
                                          SignUpVisibiltyPressed(obscureText1));
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                ),
                                controller: passwordController,
                                obscureText: obscureText1),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpConfirmPasswordValidState) {
                            confirmPasswordValid = true;
                          }
                          if (state is SignUpConfirmPasswordInValidState) {
                            confirmPasswordValid = false;
                          }
                          if (confirmPasswordValid == true) {
                            borderColor = Colours.primarygreen;
                          } else if (confirmPasswordValid == false) {
                            borderColor = Colors.red;
                          } else {
                            borderColor = Colours.primarybrown;
                          }
                          if (state is SignUpConfirmPasswordVisible) {
                            obscureText2 = true;
                          }
                          if (state is SignUpConfirmPasswordInVisible) {
                            obscureText2 = false;
                          }
                          return SizedBox(
                            width: screenWidth * 0.85,
                            child: TextField(
                                focusNode: _focusNode5,
                                onChanged: (value) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      ConfirmPasswordChangedEvent(
                                          passwordController.text,
                                          confirmPasswordController.text));
                                },
                                // controller: password,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8.0),
                                  labelText: "Re-Password*",
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
                                      color: obscureText2
                                          ? Colors.grey
                                          : Colours.primarygreen,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<SignUpBloc>(context).add(
                                          SignUpConfirmVisibiltyPressed(
                                              obscureText2));
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: borderColor),
                                  ),
                                ),
                                controller: confirmPasswordController,
                                obscureText: obscureText2),
                          );
                        },
                      ),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpErrorState) {
                          return Text(
                             state.errorMessage.replaceAll('[', '').replaceAll(']', ''),
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                height: 40,
                width:  screenWidth * 0.85,
                child: CustomButton(
                    label: loading == false ?'CHANGE PASSWORD':"loading",
                    color: Colours.primarygreen,
                    onpressed: () {
                      if(passwordValid == true  && confirmPasswordValid ==true){
                        changePassword();
                      }
                     
                    }),
              ),
          ]),),
    );
  }
}