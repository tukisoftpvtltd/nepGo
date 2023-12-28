import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Account/SignUp/OTPPage.dart';
import 'package:get/get.dart';
import '../../../../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../../../../widgets/BackButton2.dart';
import '../LogIn/loginpage.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/button.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();

  bool? firstNameValid;
  bool? lastNameValid;
  bool? phoneValid;
  bool? emailValid;
  bool? passwordValid;
  bool? confirmPasswordValid;
  //final _scrollKey = GlobalKey<ScrollableState>();
  //final _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNodeend = FocusNode();
  @override
  void initState() {
    // FocusScope.of(context).requestFocus(_focusNode);
    _focusNode.addListener(_scrollToFocusedTextField);
     _focusNode1.addListener(_scrollToFocusedTextField);
      _focusNode2.addListener(_scrollToFocusedTextField);
       _focusNode3.addListener(_scrollToFocusedTextField);
        _focusNode4.addListener(_scrollToFocusedTextField);
         _focusNode5.addListener(_scrollToFocusedTextField);
         _focusNodeend.addListener(_scrollToFocusedTextField);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // _textFieldFocus.dispose();
    super.dispose();
  }

  void _scrollToFocusedTextField() {
    if (_focusNode.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          150,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    if (_focusNode1.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          170,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    if (_focusNode2.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          190,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    if (_focusNode3.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          200,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    if (_focusNode4.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          210,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    if (_focusNode5.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          250,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    if (_focusNodeend.hasFocus) {
      print("hello");
      Future.delayed(Duration(milliseconds: 200), () {
        _scrollController.animateTo(
          270,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
  
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.white,
        leading: BackButton2(),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(100,0,0,0),
          child: Text("Sign Up",style: TextStyle(color: Colors.black),),
        ),
      ),
        body: ListView(
          shrinkWrap: true,
          controller:  _scrollController,
          children: [
            SafeArea(
              child: Container(
                height: screenHeight,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Logo(),
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colours.primarygreen,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Sign up to start ordering your food and groceries',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpFirstNameValidState) {
                            firstNameValid = true;
                          }
                          if (state is SignUpFirstNameInValidState) {
                            firstNameValid = false;
                          }
                          if (firstNameValid == true) {
                            borderColor = Colours.primarygreen;
                          } else if (firstNameValid == false) {
                            borderColor = Colors.red;
                          } else {
                            borderColor = Colours.primarybrown;
                          }
                          return SizedBox(
                            width: screenWidth * 0.85,
              
                            child: TextField(
                              focusNode: _focusNode,
                              textCapitalization:  TextCapitalization.sentences,
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(_focusNode1);
                              },
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    FirstNameChangedEvent(
                                        firstNameController.text));
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                                floatingLabelStyle: TextStyle(color: borderColor),
                                labelText: "First Name",
                                
                                hintStyle:
                                    const TextStyle(color: Colours.primarybrown),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: borderColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                              ),
                              controller: firstNameController,
                              obscureText: false,
                            ),
                            // InputTextBox(
                            //   select: false,
                            //   hinttext: 'First Name',
                            //   icon: Icon(Icons.person, color: Colours.primarygreen),
                            // ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpSecondNameValidState) {
                            lastNameValid = true;
                          }
                          if (state is SignUpSecondNameInValidState) {
                            lastNameValid = false;
                          }
                          if (lastNameValid == true) {
                            borderColor = Colours.primarygreen;
                          } else if (lastNameValid == false) {
                            borderColor = Colors.red;
                          } else {
                            borderColor = Colours.primarybrown;
                          }
                          return SizedBox(
                            width: screenWidth * 0.85,
                            child: TextField(
                              focusNode: _focusNode1,
                              textCapitalization:  TextCapitalization.sentences,
                              onEditingComplete:(){
                                FocusScope.of(context).requestFocus(_focusNode2);
                              },
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SecondNameChangedEvent(
                                        lastNameController.text));
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                                floatingLabelStyle: TextStyle(color: borderColor),
                                
                                labelText: "Last Name",
                                hintStyle:
                                    const TextStyle(color: Colours.primarybrown),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: borderColor,
                                ),
                               border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                              ),
                              controller: lastNameController,
                              obscureText: false,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpPhoneValidState) {
                            phoneValid = true;
                          }
                          if (state is SignUpPhoneInValidState) {
                            phoneValid = false;
                          }
                          if (phoneValid == true) {
                            borderColor = Colours.primarygreen;
                          } else if (phoneValid == false) {
                            borderColor = Colors.red;
                          } else {
                            borderColor = Colours.primarybrown;
                          }
                          return SizedBox(
                            width: screenWidth * 0.85,
                            child: TextField(
                               focusNode: _focusNode2,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    PhoneNoChangedEvent(
                                        phonenumberController.text));
                              },
                              onEditingComplete:(){
                                FocusScope.of(context).requestFocus(_focusNode3);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                                counterText: '',
                                floatingLabelStyle: TextStyle(color: borderColor),
                                labelText: "Phone Number",
                                hintStyle:
                                    const TextStyle(color: Colours.primarybrown),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: borderColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                              ),
                              controller: phonenumberController,
                              obscureText: false,
                              maxLength: 10,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          Color borderColor = Colours.primarybrown;
                          if (state is SignUpEmailValidState) {
                            emailValid = true;
                          }
                          if (state is SignUpEmailInValidState) {
                            emailValid = false;
                          }
                          if (emailValid == true) {
                            borderColor = Colours.primarygreen;
                          } else if (emailValid == false) {
                            borderColor = Colors.red;
                          } else {
                            borderColor = Colours.primarybrown;
                          }
                          return SizedBox(
                            width: screenWidth * 0.85,
                            child: TextField(
                               focusNode: _focusNode3,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpEmailChangedEvent(emailController.text));
                              },
                              onEditingComplete:(){
                                FocusScope.of(context).requestFocus(_focusNode4);
                              },
                              // controller: email,
                              decoration: InputDecoration(
                                
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                                labelText: "Email",
                                floatingLabelStyle: TextStyle(color: borderColor),
                                labelStyle: TextStyle(color: Colours.primarybrown),
                                hintText: "",
                                hintStyle:
                                    const TextStyle(color: Colours.primarybrown),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: borderColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                              ),
                              obscureText: false,
              
                              controller: emailController,
                            ),
                            // InputTextBox(
                            //   emailController: email,
                            //   passwordController: password,
                            //   select: false,
                            //   hinttext: 'Email*',
                            //   icon: Icon(Icons.mail, color: Colours.primarygreen),
                            // ),
                          );
                        },
                      ),
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
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor),
                        ),
                                ),
                                controller: passwordController,
                                obscureText: obscureText1),
                          );
                        },
                      ),
                      //const SizedBox(height: 10),
                      // BlocBuilder<SignUpBloc, SignUpState>(
                      //   builder: (context, state) {
                      //     Color borderColor = Colours.primarybrown;
                      //     if (state is SignUpConfirmPasswordValidState) {
                      //       confirmPasswordValid = true;
                      //     }
                      //     if (state is SignUpConfirmPasswordInValidState) {
                      //       confirmPasswordValid = false;
                      //     }
                      //     if (confirmPasswordValid == true) {
                      //       borderColor = Colours.primarygreen;
                      //     } else if (confirmPasswordValid == false) {
                      //       borderColor = Colors.red;
                      //     } else {
                      //       borderColor = Colours.primarybrown;
                      //     }
                      //     if (state is SignUpConfirmPasswordVisible) {
                      //       obscureText2 = true;
                      //     }
                      //     if (state is SignUpConfirmPasswordInVisible) {
                      //       obscureText2 = false;
                      //     }
                      //     return SizedBox(
                      //       width: screenWidth * 0.85,
                      //       child: TextField(
                      //           focusNode: _focusNode5,
                      //           onChanged: (value) {
                      //             BlocProvider.of<SignUpBloc>(context).add(
                      //                 ConfirmPasswordChangedEvent(
                      //                     passwordController.text,
                      //                     confirmPasswordController.text));
                      //           },
                      //           // controller: password,
                      //           decoration: InputDecoration(
                      //             contentPadding:
                      //                 EdgeInsets.symmetric(vertical: 8.0),
                      //             labelText: "Re-Password*",
                      //             floatingLabelStyle: TextStyle(color: borderColor),
                      //             labelStyle:
                      //                 TextStyle(color: Colours.primarybrown),
                      //             hintText: "",
                      //             hintStyle:
                      //                 const TextStyle(color: Colours.primarybrown),
                      //             prefixIcon: Icon(
                      //               Icons.lock,
                      //               color: borderColor,
                      //             ),
                      //             suffixIcon: IconButton(
                      //               icon: Icon(
                      //                 Icons.visibility,
                      //                 color: obscureText2
                      //                     ? Colors.grey
                      //                     : Colours.primarygreen,
                      //               ),
                      //               onPressed: () {
                      //                 BlocProvider.of<SignUpBloc>(context).add(
                      //                     SignUpConfirmVisibiltyPressed(
                      //                         obscureText2));
                      //               },
                      //             ),
                      //             border: OutlineInputBorder(
                      //               borderSide: BorderSide(color: borderColor),
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(color: borderColor),
                      //             ),
                      //           ),
                      //           controller: confirmPasswordController,
                      //           obscureText: obscureText2),
                      //     );
                      //   },
                      // ),
                      
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
                      
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                        width: screenWidth * 0.85,
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String signup = 'CONTINUE';
                            if (state is SignUpLoadingState) {
                              signup = 'loading';
                            } else {
                              signup = 'Sign Up';
                            }
                            return CustomButton(
                              label: signup,
                              color: Colours.primarygreen,
                              onpressed: () async {
                                print(firstNameValid);
                                print(lastNameValid); 
                                print(phoneValid);
                                print(emailValid); 
                                print(passwordValid); 
                               
                                if (firstNameValid == true &&
                                    lastNameValid == true &&
                                    phoneValid == true &&
                                    emailValid == true &&
                                    passwordValid == true 
                                    ) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpSubmittedEvent(
                                          firstNameController.text,
                                          lastNameController.text,
                                          emailController.text,
                                          phonenumberController.text,
                                          passwordController.text,
                                          confirmPasswordController.text));
                                }
                                else if(
                                  firstNameValid == null ||
                                    lastNameValid == null ||
                                    phoneValid == null ||
                                    emailValid == null ||
                                    passwordValid == null ||
                                    confirmPasswordValid == null
                                ){
                                    setState(() {
                                     firstNameValid = false;
                                  lastNameValid = false;
                                    phoneValid = false ;
                                    emailValid = false;
                                    passwordValid = false ;
                                    confirmPasswordValid = false;
                                  });
                                }
                                // else{
                                
                                 
                                // }
                              },
                            );
                          },
                        ),
                      ),
                      const AlreadyHaveAccount(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      Get.back();
        
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      child: RichText(
        text: const TextSpan(
            text: "Already Have an Account?",
            style: TextStyle(
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "  LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryblue,
                ),
              ),
            ]),
      ),
    );
  }
}
