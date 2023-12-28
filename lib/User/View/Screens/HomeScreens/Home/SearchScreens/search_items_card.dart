import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/Functions/convertMilestoKm.dart';
import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../Restaurants/screens/view_restaurant.dart';


class SearchItemsCard extends StatefulWidget {
  final String sid;
  final String restaurantName;
  final String location;
  final String ratings;
  final String logoUrl;
  final double distance;
  final String openTime;
  final String closeTime;
  final Widget row;
  const SearchItemsCard({
    super.key,
    required this.sid,
    required this.restaurantName,
    required this.location,
    required this.logoUrl,
    required this.ratings,
    required this.distance,
    required this.openTime,
    required this.closeTime,
    required this.row,
  });

  @override
  State<SearchItemsCard> createState() => _SearchItemsCardState();
}

class _SearchItemsCardState extends State<SearchItemsCard> {
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
               Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) =>  ServiceProviderDetailBloc(),
                                    child: ViewRestautant(
                                      sid: widget.sid,
                                    ),
                                  )));
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
                            children: [widget.row],
                          ),
                        ),
                      ),
                    ),
                // SizedBox(
                //   height: 10,
                // ),
                   
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
                        child: ClipOval(
                          
                          child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/imageLoader.png', // Placeholder using KTransparentImage
                  image: widget.logoUrl,
                  fit: BoxFit.cover,
                )
                        //   Image.network(
                        //   widget.logoUrl,
                        // fit: BoxFit.fill,)
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
                                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: screenWidth/1.68,
                                        child: Text(
                                          capitalize(widget.restaurantName),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: screenWidth < 400 ? 14 : 14,
                                            fontWeight: FontWeight.w600,
                                            
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.star,
                                                        color: Colors.orange,
                                                        size: screenWidth < 400 ? 18 : 18,
                                                      ),
                                                      Text(
                                                        widget.ratings.toString(),
                                                        style: TextStyle(
                                                        color: Colors.orange,
                                                          fontSize: screenWidth < 400 ? 10 : 10,
                                                        ),
                                                      ),
                                    ],
                                  ),
                                ),
                              
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0,0, 0),
                                  child: Container(
                                    width: screenWidth/1.4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              child: Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.black,
                                                size: screenWidth < 400 ? 18 : 18,
                                              ),
                                            ),
                                            Container(
                                          width: screenWidth/2.3,
                                          child: Text(
                                            capitalize(widget.location),
                                             maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      
                                            style: TextStyle(
                                              fontSize: screenWidth < 400 ? 10 : 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                            ),
                                          ),
                                        ),
                                          ],
                                        ),
                                        
                                        Container(
                                          width: 55,
                                          child: Text(
                                            milesToKilometers( widget.distance)+" Km",
                                             maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: screenWidth < 400 ? 10 : 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ,
                               Padding(
                                 padding: const EdgeInsets.fromLTRB(5,0, 0,0),
                                 child: Container(
                                          width: screenWidth/1.75,
                                        child: Text(
                                          capitalize("Delivery Time : ${widget.openTime} to ${widget.closeTime}"),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: screenWidth < 400 ? 9 : 9,
                                            fontWeight: FontWeight.w400,
                                            
                                          ),
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
                //  Container(
                //   height: 5,
                //  color: Colors.white,
                // ),
                  
      
                  ],
               
              ),
            ),
          ),
        ),
    );
  }
}
