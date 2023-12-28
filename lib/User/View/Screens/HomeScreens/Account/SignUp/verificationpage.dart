import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../Driver/View/view/signup.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/button.dart';
import '../LogIn/loginpage.dart';

class Verfication extends StatelessWidget {
  const Verfication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Column(
              children: [
                const SizedBox(height: 75),
                const Logo(),
                const SizedBox(height: 10),
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colours.primarygreen,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                    'Enter the verification code sent to your Email Address'),
                const SizedBox(height: 20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Codebox(),
                      Codebox(),
                      Codebox(),
                      Codebox(),
                      Codebox(),
                      Codebox(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: RichText(
                    text: const TextSpan(
                        text: "Didn't receive OTP?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "  Resend OTP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colours.primaryblue,
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                  // child: Checkbox(
                  //   value: null,
                  //   onChanged: null,
                  // ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: 45,
                  width: 365,
                  child: CustomButton(
                    label: 'SIGN UP',
                    color: Colours.primarygreen,
                    onpressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return  Loginpage();
                          },
                        ),
                      );
                    },
                  ),
                ),
                const AlreadyHaveAccount(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class Codebox extends StatelessWidget {
  const Codebox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 49,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            width: 2,
          )),
        ),
      ),
    );
  }
}
