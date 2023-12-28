import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Driver/View/components/colors.dart';

class ProductLoader extends StatelessWidget {
  const ProductLoader({super.key});

  @override
  Widget build(BuildContext context) {
    double miles = double.parse('1.5');
    double kilometers = miles * 1.60934;
    double roundedKilometers = double.parse(kilometers.toStringAsFixed(3));

    return Container(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
        return
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Color of the shadow
              spreadRadius: 3, // How much the shadow should spread
              blurRadius: 2, // How blurry the shadow should be
              offset: Offset(0, 2), // Offset of the shadow
            ),
          ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 190,
                  width: 162,
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: 162,
                        child:ClipRRect(
                          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
      ),
                            child: Image.asset('assets/images/imageLoader.png',fit: BoxFit.fill,),
                          
                        )
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                 baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 20,
                                  color: Colors.yellow,
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),

                              Shimmer.fromColors(
                                
                                 baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 12,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Rs. ",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          )),
                                      Text(
                                        "Rs.",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            decoration: TextDecoration.lineThrough,
                                            decorationColor: Colors.grey,
                                            decorationThickness: 2,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              //Divider(),
                               Shimmer.fromColors(
                                 baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                                 child: Container(
                                  height: 22,
                                  color: Colors.white,
                                   child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '132',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '$roundedKilometers Km',
                                            style: TextStyle(
                                                color: Colours.primarygreen,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                 ),
                               ),
                                 
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
          
      ),
    );
  }
}
//  class ProductLoader extends StatelessWidget {
//   const ProductLoader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//                                 height: 200,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount:5,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return GestureDetector(
//                                         onTap: () {
//                                         },
//                                         child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//            decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.1), // Color of the shadow
//         spreadRadius: 3, // How much the shadow should spread
//         blurRadius: 2, // How blurry the shadow should be
//         offset: Offset(0, 2), // Offset of the shadow
//       ),
//     ],
//         ),
//         child: Container(
          
//           height: 190,
//             width: 162,
            
//           child: Column(
//             children: [
//               Container(
//                 height: 120,
//                   width: 162,
//                 child:
//                 Image.asset(
//                   'assets/images/no-image2.png',
//                      fit:BoxFit.fill,
//                      )
//               ),
//               SizedBox(
//                 height: 6,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Container(
//                   height: 60,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Shimmer.fromColors(
//                          baseColor:
//                         Colors.grey.shade300, // Color of the skeleton loader
//                     highlightColor: Colors
//                         .grey.shade100,
//                         child: Container(
//                           height: 20,
//                            decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(0),
//                         color: Colors.yellow,
//                       ),
//                           child: Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 '',
//                                 textAlign: TextAlign.left,
//                               )),
//                         ),
//                       ),
//                       // SizedBox(
//                       //   height: 4,
//                       // ),

//                       // Container(
//                       //    decoration: BoxDecoration(
//                       //   borderRadius: BorderRadius.circular(0),
//                       // ),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     children: [
//                       //       Align(
//                       //           alignment: Alignment.topLeft,
//                       //           child: Text(
//                       //             "",
//                       //             style: TextStyle(
//                       //                 color: Colors.grey,
//                       //                 fontSize: 12,
//                       //                 fontWeight: FontWeight.w400),
//                       //           )),
//                       //       Text(
//                       //         "",
//                       //         style: TextStyle(
//                       //             color: Colors.grey,
//                       //             fontSize: 12,
//                       //             decoration: TextDecoration.lineThrough,
//                       //             decorationColor: Colors.grey,
//                       //             decorationThickness: 2,
//                       //             fontWeight: FontWeight.w400),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       SizedBox(height: 10,),
//                       Shimmer.fromColors(
//                         baseColor:
//                         Colors.grey.shade300, // Color of the skeleton loader
//                     highlightColor: Colors
//                         .grey.shade100,
//                         child: Container(
//                            decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(0),
//                             color: Colors.yellow,
//                           ),
                          
//                           child: Align(
//                               alignment: Alignment.topLeft,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '',
//                                     style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                   Text(
//                                     ' ',
//                                     style: TextStyle(
//                                         color: Colours.primarygreen,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//                                         );
//                                   },
//                                 ),
//                               );
//   }
// }