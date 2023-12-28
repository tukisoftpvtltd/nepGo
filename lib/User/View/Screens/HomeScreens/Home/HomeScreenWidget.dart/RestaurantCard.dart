import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../constants/Constants.dart';
import '../../../../constants/colors.dart';

class HomeRestaurantCard extends StatelessWidget {
  String name;
  String address;
  String logo;
  String banner;
  String distance;
  String averageRating;
  String openingTime;
  String closingTime;
  HomeRestaurantCard({
    super.key,
    required this.name,
    required this.address,
    required this.logo,
    required this.banner,
    required this.distance,
    required this.averageRating,
    required this.openingTime,
    required this.closingTime
  });

  @override
  Widget build(BuildContext context) {
    double boxWidth = 280;
    double miles = double.parse(distance);
    double kilometers = miles * 1.60934;
    double roundedKilometers = double.parse(kilometers.toStringAsFixed(2));
    final width = MediaQuery.of(context).size.width;
    return Padding(
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
                    // FadeInImage.memoryNetwork(
                    //   placeholder: kTransparentImage,
                    //  image:  
                    //       banner =='null'? "$baseUrl/serviceproviderprofile/"+'1687762334597.jpg':"$baseUrl/serviceproviderprofile/"+banner,
                    //  fit:BoxFit.cover,
                    //  )
                    banner == 'null'?
                    Image.asset('assets/images/imageLoader.png',
                          fit: BoxFit.cover,):
                     FadeInImage(
                            placeholder: AssetImage('assets/images/imageLoader.png'), // A transparent placeholder image
                            image: NetworkImage("$baseUrl/serviceproviderprofile/"+banner),
                          fit: BoxFit.cover,
                          )
                          ,
                    //  GradientImage(
                    //          imageUrl: banner =='null'? "$baseUrl/serviceproviderprofile/"+'1687762334597.jpg':"$baseUrl/serviceproviderprofile/"+banner,
                     
                    // ),
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
                                            padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: boxWidth/1.8,
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        textAlign: TextAlign.left,
                                                        name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                   Container(
                                                    width: 194,
                                                     child: Align(
                                                      alignment: Alignment.topLeft,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.location_on_outlined,
                                                              size: 12,
                                                                color: Colors.grey.shade800,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: boxWidth/2.2,
                                                                    child: Align(
                                                                      alignment: Alignment.topLeft,
                                                                      child: Text(
                                                                        textAlign: TextAlign.left,
                                                                        capitalize(address),
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          color: Colors.grey.shade800,
                                                                            fontSize: 10,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                   Container(
                                                       width: boxWidth/5.5,
                                                       child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                         children: [
                                                          Icon(Icons.star,
                                                          size: 20,
                                                          color: Colors.orange,),
                                                           Text(
                                                            averageRating,
                                                            maxLines: 1,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                            color: Colors.orange,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400),),
                                                         ],
                                                       ),
                                                     ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                      ),
                                                   ),
                                                    Container(
                                                      width: boxWidth/1.45,
                                                      child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                               Container(
                                                                                                width: boxWidth/2,
                                                                                                 child: Text(
                                                                                                      'Delivery: ${openingTime.replaceAll('00:00','00')} to ${closingTime.replaceAll('00:00','00')}',
                                                                                                      maxLines: 1,
                                                                                                      textAlign: TextAlign.start,
                                                                                                      style: TextStyle(color: Colors.black,
                                                                                                                       fontSize: 10,
                                                                                                                       fontWeight: FontWeight.w400),
                                                                                                    ),
                                                                                               ),
                                                                                              Container(
                                                                                                width: boxWidth/5.5,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                                                  child: Align(
                                                                                                    alignment: Alignment.centerRight,
                                                                                                    child: Text(
                                                                                                      '$roundedKilometers Km',
                                                                                                      maxLines: 1,
                                                                                                      textAlign: TextAlign.end,
                                                                                                      style: TextStyle(color: Colours.primarygreen,
                                                                                                                       fontSize: 10,
                                                                                                                       fontWeight: FontWeight.w400),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                    ),
                                                    SizedBox(height: 5,),
                                                  
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //      Text(
                                      //           'Delivery Time : 1:00 AM to 9:00 PM',
                                      //           maxLines: 1,
                                      //           textAlign: TextAlign.end,
                                      //           style: TextStyle(
                                      //               color: Colours.primarygreen,
                                      //               fontSize: 12,
                                      //               fontWeight: FontWeight.w400),
                                      //         ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                                      //       child: Align(
                                      //         alignment: Alignment.centerRight,
                                      //         child: Text(
                                      //           '$roundedKilometers Km',
                                      //           maxLines: 1,
                                      //           textAlign: TextAlign.end,
                                      //           style: TextStyle(
                                      //               color: Colours.primarygreen,
                                      //               fontSize: 12,
                                      //               fontWeight: FontWeight.w400),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
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
                               
                                // FadeInImage.memoryNetwork(
                                //   placeholder: kTransparentImage,
                                //  image:
                                //  fit:BoxFit.fill,
                                //  )
                                
                                 FadeInImage(
                            placeholder: AssetImage('assets/images/imageLoader.png'), // A transparent placeholder image
                            image: NetworkImage(
                               "$baseUrl/serviceproviderprofile/" +
                                      logo,),
                          fit: BoxFit.fill,
                          ),
                                //  Image.network(
                                //   "$baseUrl/serviceproviderprofile/" +
                                //       logo,
                                //   fit: BoxFit.fill,
                                // ),
                              ),
        ),
        ],
      ),
    );
  }
}
// class GradientImage extends StatelessWidget {
//   final String imageUrl;

//   GradientImage({required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background Image
//         Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity),

//         // Black Gradient Overlay
//         // Container(
//         //   decoration: BoxDecoration(
//         //     gradient: LinearGradient(
//         //       begin: Alignment.bottomCenter,
//         //       end: Alignment.topCenter,
//         //       //  stops: [0.4,0.5 ,0.8],
//         //         stops: [0.2,0.7,1.0],
//         //       colors: [
//         //         Colors.black.withOpacity(0.5), 
//         //         Colors.red.withOpacity(0.1),
//         //         Colors.transparent,
                
//         //         // You can adjust the opacity here
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
// class ColoredShadowImage extends StatelessWidget {
//   final String imageUrl;
//   final Color shadowColor;

//   ColoredShadowImage({required this.imageUrl, required this.shadowColor});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background Image
//         Image.network(imageUrl, fit: BoxFit.cover),

//         // Colored Shadow Overlay
//         ColorFiltered(
//           colorFilter: ColorFilter.mode(
//             Colors.red.withOpacity(0.7), // You can adjust the opacity here
//             BlendMode.srcATop,
//           ),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur strength
//             child: Container(
//               color: Colors.transparent,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
