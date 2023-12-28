import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../View/Screens/HomeScreens/Account/LogIn/loginpage.dart';
import '../../View/constants/colors.dart';
import '../bloc/Account/sign_in/bloc/sign_in_bloc.dart';

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alert!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Please log in to add to cart',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
            ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Login'),
                    onPressed: () {
                     Navigator.of(context).pop();
                      Get.to( BlocProvider(
                      create: (context) => SignInBloc(context),
                      child: Loginpage(
                        singlePage:true
                      ),
                    ),);
                    },
              ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
       
      );
    },
  );
}