import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/button.dart';
import '../ForgetPassword/phoneVerify.dart';
import '../SignUp/signup.dart';

class Loginpage extends StatefulWidget {
  bool? singlePage;
  Loginpage({Key? key,this.singlePage}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
     bool? emailValid;
    bool? passwordValid;
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    bool obscureText = true;
 
    @override
    void initState() {
      email.text = '';
      password.text = '';
      emailValid = null;
      passwordValid = null;
      BlocProvider.of<SignInBloc>(context).add(SignInInitialEvent());
      super.initState();
    }

    @override
    void dispose() {
      super.dispose();
      BlocProvider.of<SignInBloc>(context).add(SignInInitialEvent());
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:  widget.singlePage ==true ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text("Login",
        style: TextStyle(color: Colors.black),),
      ):null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Logo(),
              const SizedBox(height: 5),
              const Text(
                'LOGIN',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colours.primarygreen),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth * 0.85,

                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    Color borderColor = Colours.primarybrown;
                    
                    if (state is EmailValidState) {
                      emailValid = true;
                    }
                    if (state is EmailInValidState) {
                      emailValid = false;
                    }
                    if (emailValid == true) {
                      borderColor = Colors.green;
                    } else if (emailValid == false) {
                      borderColor = Colors.red;
                    } else {
                      borderColor = Colours.primarybrown;
                    }
                    
                    return TextField(
                      cursorHeight: 25,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      onChanged: (value) {
                        BlocProvider.of<SignInBloc>(context)
                            .add(EmailChangedEvent(email.text));
                        // if(email.text ==''){
                        //   print("email empty");
                        //   setState(() {
                        //     emailValid = null;
                        //     print(emailValid);
                        //   });
                          
                        // }
                      },
                      onEditingComplete: () {},
                      controller: email,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        labelText: "Email*",
                        floatingLabelStyle: TextStyle(color: borderColor),
                        labelStyle: TextStyle(color: Colours.primarybrown),
                        hintText: "",
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
                        hintMaxLines: 1,
                        // hintMaxWidth: double.infinity,
                        hintStyle: TextStyle(color: Colours.primarybrown),
                        alignLabelWithHint: true,
                      ),
                      obscureText: false,
                    );
                  },
                ),
                // InputTextBox(
                //   emailController: email,
                //   passwordController: password,
                //   select: false,
                //   hinttext: 'Email*',
                //   icon: Icon(Icons.mail, color: Colours.primarygreen),
                // ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth * 0.85,
                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    Color borderColor = Colours.primarybrown;
                    if (state is PasswordValidState) {
                      passwordValid = true;
                    }
                    if (state is PasswordInValidState) {
                      passwordValid = false;
                    }
                    if (state is PasswordVisible) {
                      obscureText = true;
                    }
                    if (state is PasswordInVisible) {
                      obscureText = false;
                    }
                    if (passwordValid == true) {
                      borderColor = Colours.primarygreen;
                    } else if (passwordValid == false) {
                      borderColor = Colors.red;
                    } else {
                      borderColor = Colours.primarybrown;
                    }
                    return Container(
                      height: 50,
                      child: TextField(
                          onChanged: (value) {
                            BlocProvider.of<SignInBloc>(context)
                                .add(PasswordChangedEvent(password.text));
                          },
                          onEditingComplete: () {},
                          controller: password,
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
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: obscureText
                                      ? Colors.grey
                                      : Colours.primarygreen,
                                ),
                                onPressed: () {
                                  BlocProvider.of<SignInBloc>(context)
                                      .add(VisibiltyPressed(obscureText));
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              )),
                          obscureText: obscureText),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              // BlocBuilder<SignInBloc, SignInState>(
              //   builder: (context, state) {
              //     if (state is SignInErrorState) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 20),
              //         child: Align(
              //           alignment: Alignment.center,
              //           child: Text(
              //             state.errorMessage,
              //             style: TextStyle(color: Colors.red),
              //           ),
              //         ),
              //       );
              //     } else if (state is SignInFailedState) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 20),
              //         child: Align(
              //           alignment: Alignment.center,
              //           child: Text(
              //             state.failedMessage,
              //             style: TextStyle(color: Colors.red),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //       );
              //     }
              //     if (state is SignInSuccessState) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 20),
              //         child: Text(
              //           state.successMessage,
              //           style: TextStyle(color: Colors.green),
              //         ),
              //       );
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if (state is SignInFailedState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          state.failedMessage,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  if (state is SignInSuccessState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        state.successMessage,
                        style: TextStyle(color: Colors.green),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                width: screenWidth * 0.85,
                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    String login = 'LOG IN';
                    if (state is SignInLoadingState) {
                      login = 'loading';
                    } else if (state is SignInSuccessState) {
                    } else {
                      login = 'LOG IN';
                    }
                    return CustomButton(
                      label: login,
                      color: Colours.primarygreen,
                      onpressed: () async {
                        print(emailValid);
                        print(passwordValid);
                        if(emailValid == null || passwordValid ==null){
                          print("here");
                          setState(() {
                            emailValid =false;
                            passwordValid = false;
                            print(emailValid);
                            print(passwordValid);
                          });
                          // BlocProvider.of<SignInBloc>(context)
                          //     .add(EmailChangedEvent(email.text));
                          // BlocProvider.of<SignInBloc>(context)
                          //     .add(PasswordChangedEvent(password.text));
                          
                        }
                        else if (emailValid == false) {
                          BlocProvider.of<SignInBloc>(context)
                              .add(EmailChangedEvent(email.text));
                        }
                        else if (passwordValid == false) {
                          BlocProvider.of<SignInBloc>(context)
                              .add(PasswordChangedEvent(password.text));
                        }
                        else if (emailValid == true && passwordValid == true) {
                          BlocProvider.of<SignInBloc>(context).add(
                              SignInSubmittedEvent(email.text, password.text));
                        } else
                          () {
                            print("Something went wrong");
                          };
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),

              Container(
                width: screenWidth * 0.85,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print("phone verify");
                        Get.to(BlocProvider(
                          create: (context) => SignUpBloc(),
                          child: PhoneVerify(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colours.primarybrown),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (context) => SignUpBloc(),
                                child: SignupPage(),
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colours.primaryblue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   width: screenWidth * 0.85,
              //   child: const Text(
              //     '--------------- OR ---------------',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 14,
              //       color: Color.fromRGBO(107, 113, 108, 1),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 5),
              // Loginwith(
              //     imagepath: 'assets/images/fb.jpg',
              //     iconlabel: "Facebook",
              //     label: 'Login with Facebook'),
              // const SizedBox(height: 10),
              // Loginwith(
              //   imagepath: 'assets/images/google.jpg',
              //   iconlabel: "Google",
              //   label: 'Login with Google     ',
              // ),
              // const SizedBox(height: 10),
              // Loginwith(
              //     imagepath: 'assets/images/apple.jpg',
              //     iconlabel: "Apple",
              //     label: 'Login With Apple       '),
            ],
          ),
        ),
      ),
    );
  }
}

class Loginwith extends StatelessWidget {
  final String label;
  final String imagepath;
  final String iconlabel;

  const Loginwith({
    Key? key,
    required this.imagepath,
    required this.label,
    required this.iconlabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.85,
      height: 35,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: const BorderSide(
              width: 1,
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (iconlabel.toString() == "Facebook")
              FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              )
            else if (iconlabel.toString() == "Google")
              FaIcon(
                FontAwesomeIcons.google,
                color: Colors.green,
              )
            else if (iconlabel == "Apple")
              FaIcon(
                FontAwesomeIcons.apple,
                color: Colors.grey,
              ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colours.primarybrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//$baseUrl/api/userLogin?email=poudel.surya98@gmail.com&password=500ptpw@
//$baseUrl/api/userLogin/?email=abiral@gmail.com&password=abiral1234