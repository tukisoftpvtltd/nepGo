import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../User/Controller/repositories/otp/forgotPasswordOTP.dart';
import '../../../User/View/widgets/BackButton2.dart';
import '../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../components/button.dart';
import '../constants/colors.dart';


class PhoneVerifyDriver extends StatefulWidget {
  const PhoneVerifyDriver({super.key});

  @override
  State<PhoneVerifyDriver> createState() => _PhoneVerifyDriverState();
}

class _PhoneVerifyDriverState extends State<PhoneVerifyDriver> {
   TextEditingController phone = TextEditingController();
  bool loading =false;

  sendNewForgotPasswordOTPTOPhoneNumber(){
    setState(() {
      loading = true;
    });
    SendForgotPasswordOTP repo = SendForgotPasswordOTP();
    repo.resendForgotPasswordOTP(phone.text);
    setState(() {
      loading = false;
    });
    
  }
  bool? phoneValid;

  initState(){
    print(loading);

  }

  @override
  Widget build(BuildContext context) {
 
  double screenWidth = MediaQuery.of(context).size.width;
  
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton2(),
        title: Text("Forget Password ?",style: TextStyle(color: Colors.black),),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const SizedBox(height: 20),
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
                              //  focusNode: _focusNode2,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    PhoneNoChangedEvent(
                                        phone.text));
                              },
                              onEditingComplete:(){
                                // FocusScope.of(context).requestFocus(_focusNode3);
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
                                    borderSide: BorderSide(color: borderColor)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                 enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                              ),
                                
                              ),
                              controller:  phone,
                              obscureText: false,
                              maxLength: 10,
                            ),
                          );
                        },
                      ),
           const SizedBox(height: 10),
           SizedBox(height: 40,
                          width: screenWidth * 0.85,
                          child: CustomButton(
                            label: loading == false ?'CONTINUE':'loading',
                            color: Colours.primarygreen,
                            onpressed: () async {
                              print(phoneValid);
                              if(phoneValid == true){
                                  sendNewForgotPasswordOTPTOPhoneNumber();
                              }
                              else if(phoneValid == null){
                                setState(() {
                                  phoneValid = false;
                                });
                              }
                            },
                          ),
                        ),            
          ],
        ),
      ),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final String label;
//   final Color color;
//   final VoidCallback onpressed;

//   const CustomButton({
//     super.key,
//     required this.label,
//     required this.color,
//     required this.onpressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: onpressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//         ),
//         child: label =="loading"
//         ?CircularProgressIndicator(
//           color: Colours.primarygreen,

//         ) 
//         :Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ));
//   }
// }