import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideShareLoader extends StatefulWidget {
  Function callback;
  RideShareLoader({super.key,required this.callback});

  @override
  State<RideShareLoader> createState() => _RideShareLoaderState();
}

class _RideShareLoaderState extends State<RideShareLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey.withOpacity(0.1), 
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0,45,10,0),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: GestureDetector(
              //       onTap: (){
              //         widget.callback();
              //      // Get.back();
              //       }
              //       ,
              //       child: ClipOval(
              //         child: Container(
              //           padding: EdgeInsets.all(0),
              //           color: Colors.white,
              //            //widget.callback();
              //           child: Icon(Icons.cancel,size: 40,)
              //         ),
              //       ),
              //     ),
              // ),
              // ),
        ],
          ),
    );
  }
}