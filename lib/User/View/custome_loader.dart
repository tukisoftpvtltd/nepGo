import 'package:flutter/material.dart';

class CustomeLoader extends StatefulWidget {
  const CustomeLoader({super.key});

  @override
  State<CustomeLoader> createState() => _CustomeLoaderState();
}

class _CustomeLoaderState extends State<CustomeLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white.withOpacity(0.1), 
      body: Stack(
        children: [
         
            Center(child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(0),
            ),
              child: ClipRect(
                child: Image.asset(
                  'assets/images/animation1.gif',
                fit: BoxFit.fitHeight,),
              ))),
             
        ],
          ),
    );
  }
}