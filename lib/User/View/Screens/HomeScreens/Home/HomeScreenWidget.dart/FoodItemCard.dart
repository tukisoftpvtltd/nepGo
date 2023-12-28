import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../constants/colors.dart';

// class FoodItemCard extends StatelessWidget {
//   String imageUrl = '';
//   String foodName = '';
//   String sellingRate = '';
//   String normalRate = '';
//   String restaurantName = '';
//   String distance = '';
//   FoodItemCard({
//     super.key,
//     required this.imageUrl,
//     required this.foodName,
//     required this.sellingRate,
//     required this.normalRate,
//     required this.restaurantName,
//     required this.distance,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double miles = double.parse(distance);
//     double kilometers = miles * 1.60934;
//     double roundedKilometers = double.parse(kilometers.toStringAsFixed(3));

//     return Padding(
//       padding: EdgeInsets.fromLTRB(10,5,0,0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(0.0)),
//     //       boxShadow: [
//     //   BoxShadow(
//     //     color: Colors.grey.withOpacity(0.1), // Color of the shadow
//     //     spreadRadius: 3, // How much the shadow should spread
//     //     blurRadius: 2, // How blurry the shadow should be
//     //     offset: Offset(0, 2), // Offset of the shadow
//     //   ),
//     // ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(0),
//           child: Container(
//             height: 180,
//             width: 220,
//             child: Column(
//               children: [
//               ClipRRect(
//                     borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight:  Radius.circular(20),
//                     bottomLeft:  Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                     ),
//                       child:
//                       Container(
//                         height: 115,
//                         width: 220,
//                         child: FadeInImage(
//                             placeholder: AssetImage('assets/images/imageLoader.png'), // A transparent placeholder image
//                             image: NetworkImage('https://meroato.tukisoft.com.np/uploads/$imageUrl'),
//                           fit: BoxFit.cover,
//                           ),
//                       ),
//                       // MyImageWidget(
//                       //   imageUrl: 'https://meroato.tukisoft.com.np/uploads/$imageUrl',
//                       // placeholderImage: 'assets/images/image-gallery.png',), 
                      
//                       // FadeInImage(
//                       //       placeholder:AssetImage('assets/images/image-gallery.png',) ,
//                       //      image: NetworkImage('https://meroato.tukisoft.com.np/uploads/$imageUrl'),
//                       //      fit:BoxFit.fill,
//                       //      ),
                    
//                   ),
//                 SizedBox(
//                   height: 3,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Container(
//                     height: 70,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               foodName,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500
//                               ),
//                             )),
//                         // SizedBox(
//                         //   height: 4,
//                         // ),
        
//                         Container(
//                           height: 15,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     "Rs. $sellingRate",
//                                     style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w400),
//                                   )),
//                               // Text(
//                               //   "Rs. $normalRate",
//                               //   style: TextStyle(
//                               //       color: Colors.grey,
//                               //       fontSize: 11,
//                               //       decoration: TextDecoration.lineThrough,
//                               //       decorationColor: Colors.grey,
//                               //       decorationThickness: 2,
//                               //       fontWeight: FontWeight.w400),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         //Divider(),
//                          Container(
//                           height: 25,
//                            child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     restaurantName,
//                                     style: TextStyle(
//                                         color: Color(0XFF414040),
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   // Text(
//                                   //   '$roundedKilometers Km',
//                                   //   style: TextStyle(
//                                   //       color: Colors.black,
//                                   //       fontSize: 10,
//                                   //       fontWeight: FontWeight.w500),
//                                   // ),
//                                 ],
//                               ),
//                          ),
                           
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class FoodItemCard extends StatelessWidget {
  String imageUrl = '';
  String foodName = '';
  String sellingRate = '';
  String normalRate = '';
  String restaurantName = '';
  String distance = '';
  FoodItemCard({
    super.key,
    required this.imageUrl,
    required this.foodName,
    required this.sellingRate,
    required this.normalRate,
    required this.restaurantName,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    double miles = double.parse(distance);
    double kilometers = miles * 1.60934;
    double roundedKilometers = double.parse(kilometers.toStringAsFixed(1));

    return Padding(
      padding: EdgeInsets.fromLTRB(10,10,5,10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Color of the shadow
        spreadRadius: 2, // How much the shadow should spread
        blurRadius: 5, // How blurry the shadow should be
        offset: Offset(0, 1), // Offset of the shadow
      ),
    ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 190,
            width: 160,
            child: Column(
              children: [
              ClipRRect(
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight:  Radius.circular(10),
                    bottomLeft:  Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    ),
                      child:
                      Container(
                        height: 125,
                        width: 220,
                        child: FadeInImage(
                            placeholder: AssetImage('assets/images/imageLoader.png'), // A transparent placeholder image
                            image: NetworkImage('https://meroato.tukisoft.com.np/uploads/$imageUrl'),
                          fit: BoxFit.cover,
                          ),
                      ),
                      // MyImageWidget(
                      //   imageUrl: 'https://meroato.tukisoft.com.np/uploads/$imageUrl',
                      // placeholderImage: 'assets/images/image-gallery.png',), 
                      
                      // FadeInImage(
                      //       placeholder:AssetImage('assets/images/image-gallery.png',) ,
                      //      image: NetworkImage('https://meroato.tukisoft.com.np/uploads/$imageUrl'),
                      //      fit:BoxFit.fill,
                      //      ),
                    
                  ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              foodName,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500
                              ),
                            )),
                        // SizedBox(
                        //   height: 4,
                        // ),
        
                        Container(
                          height: 18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Rs. $normalRate",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w500),
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                              Text(
                                "Rs. $sellingRate",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    decorationColor: Colors.black,
                                    decorationThickness: 2,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        //Divider(),
                         Container(
                          height: 20,
                           child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      restaurantName,
                                       maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
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
}

class MyImageWidget extends StatelessWidget {
  final String imageUrl;
  final String placeholderImage;

  MyImageWidget({required this.imageUrl, required this.placeholderImage});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          // Image is fully loaded
          return Container(
            height: 120,
            width: 162,
            child: child,
          );
        } else {
          // While the image is loading, show a fading placeholder
          return Container(
            height: 120,
            width: 162,
            child: AnimatedOpacity(
              opacity: loadingProgress.expectedTotalBytes == null
                  ? 0.5
                  : loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(placeholderImage,
                fit: BoxFit.contain,),
              ),
            ),
          );
        }
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        // If there's an error loading the image, show an error placeholder
        return Container(
          width: 80,
              height: 80,
          child: Image.asset(placeholderImage));
      },
    );
  }
}
