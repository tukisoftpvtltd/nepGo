import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../Baskets/Basket/widget/size_config.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String location;
  final String time;
  final String imageUrl;
  final String distance;
  final String rating;
  final String logoUrl;
  
  final void Function() handleClicked;

  const RestaurantCard({
    super.key,
    required this.logoUrl,
    required this.handleClicked,
    required this.imageUrl,
    required this.distance,
    required this.location,
    required this.name,
    required this.rating,
    required this.time,
  });
  String toTitleCase(String text) {
  if (text == null || text.isEmpty) return '';

  // Split the text into words using spaces as delimiters
  List<String> words = text.toLowerCase().split(' ');

  // Capitalize the first letter of each word
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }

  // Join the words back together with spaces
  String result = words.join(' ');

  // Capitalize the first letter of the whole string
  return result[0].toUpperCase() + result.substring(1);
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,0),
      child: InkWell(
        onTap: handleClicked,
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
              Container(
                height: 150,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                 bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              
                  // image: DecorationImage(
                  //   image:NetworkImage(imageUrl),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/imageLoader2.png', // Placeholder using KTransparentImage
                  image: imageUrl,
                  fit: BoxFit.cover,
                ),
                // Image.network(imageUrl,
                // fit: BoxFit.cover,),
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
                      Container(
                        height: 80,
                        width: 80,
                        child: ClipOval(
                          child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/imageLoader.png', // Placeholder using KTransparentImage
                  image: logoUrl,
                  fit: BoxFit.cover,
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
                                padding: const EdgeInsets.fromLTRB(4,10,0,0),
                                child: Container(
                                  width: screenWidth/1.45,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: screenWidth/2,
                                        child: Text(
                                           toTitleCase(name),
                                           overflow: TextOverflow.ellipsis, 
                                           maxLines: 1,
                                          style: TextStyle(
                                            fontSize:14,
                                            fontWeight: FontWeight.w500,
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
                                            Text(
                                              rating,
                                              style: TextStyle(
                                                color: Color(0XFFFFC806),
                                                fontSize: screenWidth < 400 ? 14 : 14,
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
                                    width: screenWidth/1.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                        color: Colors.grey.shade600,
                                            size: SizeConfig(context).iconSize() - 7),
                                            Container(
                                              width: screenWidth/2.2,
                                      child: Text(
                                        toTitleCase(location),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis, 
                                        style: TextStyle(
                                          fontSize: SizeConfig(context).textSize()-2,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.grey.shade600
                                        ),
                                      ),
                                    ),
                                      ],
                                    ),
                                    
                                    Text(
                                      distance+"KM",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: SizeConfig(context).textSize()-2,
                                          fontWeight: FontWeight.w100,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Delivery hours: $time',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis, 
                                  style: TextStyle(
                                    fontSize: SizeConfig(context).textSize() - 2,
                                    fontWeight: FontWeight.w400,
                                     color: Colors.grey.shade700
                              
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
  }
}