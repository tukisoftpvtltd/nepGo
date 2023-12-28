import 'package:flutter/material.dart';


// ignore: must_be_immutable
class NoInternetPage extends StatelessWidget {
 String? userLoginStatus;
 
   NoInternetPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 30),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/wifi.png')),
              ),
              SizedBox(
                height: 15,
              ),
              Text("No internet! Check your connection and try again",
              textAlign: TextAlign.center,
              
              ),
               SizedBox(
                height: 25,
              ),
              ElevatedButton(onPressed: (){
              },
               child: Text("REFRESH"))
               ],),
         )),
    );
  }
}