import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Controller/Functions/capitalize.dart';

class SearchPageLoader extends StatefulWidget {
  const SearchPageLoader({super.key});

  @override
  State<SearchPageLoader> createState() => _SearchPageLoaderState();
}

class _SearchPageLoaderState extends State<SearchPageLoader> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return  Container(
      height: 235,
      child: Padding(
          padding: const EdgeInsets.only( bottom: 10.0),
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
                height: 240,
                
              // height: screenWidth < 400 ? screenHeight / 3 : screenHeight / 3.5,
              width: screenWidth,
              
               decoration: BoxDecoration(
                
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4), // Shadow color
        spreadRadius: 3, // Spread radius of the shadow
        blurRadius: 2,   // Blur radius of the shadow
        offset: Offset(0, 3), // Offset of the shadow
      ),
    ], 
    color: Colors.white,// Shape of the container (circle for oval)
  ),
              // decoration:
              //     BoxDecoration(border: Border.all(width: 0.3, color: Colors.grey)),
              child: Column(
                children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        width: screenWidth,
                        height: 150,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for(int i=0;i<10;i++)
                              Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            height:135,
            width: screenWidth /3,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.3,
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300, // Background color of the shimmering effect
                    highlightColor: Colors.grey.shade100, 
                    child: Container(
                      width: screenWidth /3,
                      height: 85,
                       color: Colors.grey,          
                      child: Container(
                        
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.9,
                  height: 2,
                ),
                Container(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0,top:5,right: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Shimmer.fromColors(
                           baseColor: Colors.grey.shade300, // Background color of the shimmering effect
                    highlightColor: Colors.grey.shade100, 
                          child: Container(
                            width: 150,
                            height: 14,
                            color: Colors.grey,
                          )
                        ),
                         Shimmer.fromColors(
                           baseColor: Colors.grey.shade300, // Background color of the shimmering effect
                    highlightColor: Colors.grey.shade100, 
                          child: Container(
                            width: 150,
                            height: 14,
                            color: Colors.grey,
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
                            
                            ],
                          ),
                        ),
                      ),
                    ),
               
                   
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Padding(
                       padding: const EdgeInsets.fromLTRB(10,0,0,10),
                       child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Shadow color
        spreadRadius: 4, // Spread radius of the shadow
        blurRadius: 5,   // Blur radius of the shadow
        offset: Offset(0, 3), // Offset of the shadow
      ),
    ],
    shape: BoxShape.circle,),
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300, // Background color of the shimmering effect
  highlightColor: Colors.grey.shade100, 
                          child: ClipOval(
                            
                            child: Container(
                              color:Colors.red,
                            )
                          //   Image.network(
                          //   widget.logoUrl,
                          // fit: BoxFit.fill,)
                          ),
                        )),
                     ),
                      SizedBox(
                        width: 10,
                      ),
                       Container(
              width: 1, // Width of the vertical line
              height: 50, // Height of the vertical line
              color: Colors.grey, // Color of the line
            ),
            SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                                  child: Row(
                                    children: [
                                      Shimmer.fromColors(
                                         baseColor: Colors.grey.shade300, // Background color of the shimmering effect
                                      highlightColor: Colors.grey.shade100, 
                                        child: Container(
                                            width: screenWidth/1.6,
                                            height: 14,
                                            color: Colors.grey,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                                  child: Row(
                                    children: [
                                      Shimmer.fromColors(
                                         baseColor: Colors.grey.shade300, // Background color of the shimmering effect
                                      highlightColor: Colors.grey.shade100, 
                                        child: Container(
                                            width: screenWidth/1.6,
                                            height: 14,
                                            color: Colors.grey,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                               Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                                  child: Row(
                                    children: [
                                      Shimmer.fromColors(
                                         baseColor: Colors.grey.shade300, // Background color of the shimmering effect
                                      highlightColor: Colors.grey.shade100, 
                                        child: Container(
                                            width: screenWidth/1.6,
                                            height: 14,
                                            color: Colors.grey
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ],
                            ),
                              
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                  
      
                  ],
               
              ),
            ),
          ),
        ),
    );
  }
}