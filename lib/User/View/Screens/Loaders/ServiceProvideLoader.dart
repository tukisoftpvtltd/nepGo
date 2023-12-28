// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// ignore: must_be_immutable
class ServiceProviderLoader extends StatelessWidget {
   ServiceProviderLoader({super.key});
  double boxWidth = 280;
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(height: 210,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                            },
                                            child: Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
      child: Stack(
        children: [
          Container(
              width: boxWidth,
              decoration: BoxDecoration(
                // color: Color(0xffF6F2F2),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              border: Border.all(
    color: Color(0xffE0E2E4), // Replace with the desired border color
    width: 0.5,          // Replace with the desired border width
  ),
              boxShadow: [
          BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Color of the shadow
        spreadRadius: 1, // How much the shadow should spread
        blurRadius: 2, // How blurry the shadow should be
        offset: Offset(0, 5), // Offset of the shadow
      ),
    ],
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    width: boxWidth,
                    child:
                    Image.asset('assets/images/imageLoader.png',
                    fit: BoxFit.cover,),
                  ),
                  
                  Container(
                      height: 70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(65, 5, 0, 0),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300, // The color of the shimmering effect when not active
                                                    highlightColor: Colors.grey.shade100, 
                                                    child: Container(
                                                      width: boxWidth/1.5,
                                                      height: 18,
                                                      color: Colors.white,
                                                      
                                                    ),
                                                  ),
                                                  
                                                   Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300, // The color of the shimmering effect when not active
                                                    highlightColor: Colors.grey.shade100, 
                                                    child: Container(
                                                      width: boxWidth/1.5,
                                                      height: 18,
                                                      color: Colors.white,
                                                      
                                                    ),
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300, // The color of the shimmering effect when not active
                                                    highlightColor: Colors.grey.shade100, 
                                                    child: Container(
                                                      width: boxWidth/1.5,
                                                      height: 18,
                                                      color: Colors.white,
                                                      
                                                    ),
                                                  ),  SizedBox(height: 5,),
                                                  
                                                ],
                                              ),
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
                ],
              )),
              
        Padding(
          padding: const EdgeInsets.fromLTRB(10,115,0,0),
          child: Container(height: 60,
                                width: 60,
                                 decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4), // Color of the shadow
        spreadRadius: 0, // How much the shadow should spread
        blurRadius: 3, // How blurry the shadow should be
        offset: Offset(0, 8), // Offset of the shadow
      ),
    ],
        ),
                                child:
                                 Image.asset('assets/images/imageLoader.png',
                                 fit: BoxFit.cover,),
                              ),
        ),
        ],
      ),
    )
  
                                            );
                                      },
                                    ),
                                  );
                                }
}
