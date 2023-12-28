import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../Driver/View/components/size_config.dart';
import '../components/restaurant_card.dart';

class AllRestroLoader extends StatefulWidget {
  const AllRestroLoader({super.key});

  @override
  State<AllRestroLoader> createState() => _AllRestroLoaderState();
}

class _AllRestroLoaderState extends State<AllRestroLoader> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
                          width: screenWidth,
                          height: screenHeight-150,
                          child: TabBarView(
                            
                            children: [
                             
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Divider(
                      thickness: 0.5,
                      height: 1,
                    ),
                                      Column(
                                        children: [
                                          Container(
                                            color: Color(0XFFF3F3F3),
                                            height:  screenHeight-150,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: 10,
                                              itemBuilder:
                                                  (context, index) {
                                                return 
                                                Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,0),
      child: InkWell(
        onTap: (){},
        child: Container(
          height:265,
          width: double.infinity,
         // height: screenHeight < 800 ? screenHeight / 3 : screenHeight / 3.8,
          // height: SizeConfig(context).containerHeight() - 50,
          decoration: BoxDecoration(
             color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 0.1,
            ),
            borderRadius: BorderRadius.circular(0), // Adjust the radius as per your requirement
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.2),
              //     spreadRadius: 1,
              //     blurRadius: 0.5,
              //     offset: Offset(0, 2), // changes the position of the shadow
              //   ),
              // ],

          ),
          child: Column(
            children: [
               Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,  // Color when not shimmering
                       highlightColor: Colors.grey.shade100, 
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                   bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,  // Color when not shimmering
                       highlightColor: Colors.grey.shade100, 
                        child: Container(
                          height: 80,
                          width: 80,
                          child: ClipOval(
                            child: Container(
                              color: Colors.amber,
                            )
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 2,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2,10,0,0),
                                child: Container(
                                  width: screenWidth/1.45,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,  // Color when not shimmering
                       highlightColor: Colors.grey.shade100, 
                                        child: Container(
                                          width: screenWidth/2,
                                          color: Colors.white,
                                          child: Text(
                                             "Hotel Middlepoint",
                                             overflow: TextOverflow.ellipsis, 
                                             maxLines: 1,
                                            style: TextStyle(
                                              fontSize:14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Color(0XFFFFC806),
                                                // size: screenWidth < 400 ? 20 : 25,
                                                size: SizeConfig(context).iconSize()),
                                             Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,  // Color when not shimmering
                       highlightColor: Colors.grey.shade100, 
                                              child: Text(
                                                "0.0",
                                                style: TextStyle(
                                                  color: Color(0XFFFFC806),
                                                  fontSize: screenWidth < 400 ? 14 : 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               Container(
                                 color: Colors.white,
                                     width: screenWidth/1.5,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       children: [
                                              Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,  // Color when not shimmering
                       highlightColor: Colors.grey.shade100, 
                                               child: Container(
                                                color: Colors.white,
                                                 width: screenWidth/2.2,
                                                                                    child: Text(
                                                                                      "Birouta,Pokhara",
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis, 
                                                                                      style: TextStyle(
                                                                                        fontSize: SizeConfig(context).textSize()-2,
                                                                                        fontWeight: FontWeight.w100,
                                                                                        color: Colors.grey.shade600
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                             ),
                                       ],
                                     ),
                                     
                                      Shimmer.fromColors(
                                                   baseColor: Colors.grey.shade300,  // Color when not shimmering
                                                    highlightColor: Colors.grey.shade100, 
                                       child: Text(
                                         "0.0 KM",
                                         maxLines: 1,
                                         style: TextStyle(
                                           color: Colors.green,
                                           fontSize: SizeConfig(context).textSize()-2,
                                             fontWeight: FontWeight.w100,
                                         ),
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                              SizedBox(
                                height: 2,
                              ),
                              
                               Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,  // Color when not shimmering
                       highlightColor: Colors.grey.shade100, 
                                child: Container(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Delivery hours: ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, 
                                      style: TextStyle(
                                        fontSize: SizeConfig(context).textSize() - 2,
                                        fontWeight: FontWeight.w400,
                                         color: Colors.grey.shade700
                                  
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
  }
}