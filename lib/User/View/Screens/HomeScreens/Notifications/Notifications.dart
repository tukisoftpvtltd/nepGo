
import 'package:flutter/material.dart';


class Notifications extends StatefulWidget {
  
   Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    double width =  MediaQuery.of(context).size.width;
    double height =  MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            leading: BackButton(color: Colors.black),
            
            ),
        
      body: Container(
        height: height-130,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
            color: Colors.grey.shade300, // Border color
            width: 2.0,         // Border width
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 5),
                  child: Text("June 11 at 15:00",
                   style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Colors.black,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 5),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Binayak Pokhrel",
                      style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),),
                      Text("Rs : 200.00",
                      style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("From Baglun Bus Park",
                      style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),),
                      Text("Status : Accepted",
                      style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.green,
                    ),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                // Divider(
                //   thickness: 1,
                // )
              ]),
            ),
          );
        }),
      ),
    );
  }
}