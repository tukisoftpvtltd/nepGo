import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/colors.dart';
import 'components/menu_expansion.dart';
import 'components/ratings.dart';
import 'components/review_card.dart';

class ViewRestaurantLoader extends StatefulWidget {
  const ViewRestaurantLoader({super.key});

  @override
  State<ViewRestaurantLoader> createState() => _ViewRestaurantLoaderState();
}

class _ViewRestaurantLoaderState extends State<ViewRestaurantLoader> {
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
            length: 3,
            child: Scaffold(
                body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 3.1,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                            child: Container(
                                height: screenHeight / 4,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(20)),
                                ),
                                child: Container(
                                  width: screenWidth,

                                        color: Colors.green,
                                )),
                          ),
                          Positioned(
                            top: 5,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 25,
                            left: 50,
                            child: Shimmer.fromColors(
                                baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF6F6),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipOval(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF6F6),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Colours.primarygreen),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Image.asset(
                                      'assets/images/food-seeklogo3.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: screenWidth / 8,
                                  height: screenHeight / 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E4E4),
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //   width: 0.5,
                                    // ),
                                  ),
                                  child: IconButton(
                                      icon: Icon(
                                        
                                             Icons.favorite_border_rounded,
                                            
                                        color: const Color.fromARGB(
                                                  255, 70, 69, 69),
                                            
                                        size: screenWidth < 400 ? 28 : 32,
                                      ),
                                      onPressed: () {
                                      
                                      }),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: screenWidth / 8,
                                  height: screenHeight / 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E4E4),
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //   width: 0.5,
                                    // ),
                                  ),
                                  child: IconButton(
                                    icon: Center(
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: const Color.fromARGB(
                                            255, 70, 69, 69),
                                        size: screenWidth < 400 ? 28 : 32,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width: screenWidth / 8,
                                  height: screenHeight / 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E4E4),
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //   width: 0.5,
                                    // ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.location_on_outlined,
                                      color: const Color.fromARGB(
                                          255, 70, 69, 69),
                                      size: screenWidth < 400 ? 28 : 32,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                                height: 5,
                              ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: screenWidth * 1,
                          
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                 baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  width: screenWidth * 0.8,
                                  child: Text(
                                    "Name",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Shimmer.fromColors(
                                 baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                        
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  
                                  width: screenWidth * 0.8,
                                  child: Text(
                                    maxLines: 1,
                                    "Address",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.star,
                                  color: const Color(0xFFFF7F09),
                                  size: screenWidth < 400 ? 26 : 32,
                                ),
                              ),
                              Shimmer.fromColors(
                                  baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                                child: Text(
                                  '0/5',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 132, 131, 131),
                                      fontSize: screenWidth < 400 ? 12 : 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.location_on_outlined,
                                  size: screenWidth < 400 ? 26 : 32,
                                ),
                                onPressed: () {},
                              ),
                              Shimmer.fromColors(
                                 baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Location",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: screenWidth < 400 ? 11 : 12,
                                    ),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                                child: Text(
                                  '(Approx: 2.5km)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: screenWidth < 400 ? 11 : 12),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                
                                },
                                icon: Icon(
                                  Icons.watch_later_outlined,
                                  size: screenWidth < 400 ? 26 : 32,
                                ),
                              ),
                              Shimmer.fromColors(
                                  baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                                child: Text(
                                  '10:00 - 10:00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth < 400 ? 11 : 12,
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                                child: Text(
                                  'Open',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: screenWidth < 400 ? 11 : 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'MENU',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth < 400 ? 12 : 13),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'REVIEWS (0)',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth < 400 ? 12 : 13),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'INFO',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth < 400 ? 12 : 13),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Shimmer.fromColors(
                                     baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, 
                                     child: Container(
                                      decoration: BoxDecoration(
                                      color: const Color(0xFFFFF6F6),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Colours.primarygreen),
                                      borderRadius: BorderRadius.circular(10),
                                      
                                    ),

                                       child: MenuExpansion(
                                            dishName: 'Hello',
                                            menuItems: [],
                                          ),
                                     ),
                                   ),
                                   
                                  
                                  // MenuExpansion(
                                  //   dishName: 'Chowmein',
                                  // ),
                                  // MenuExpansion(dishName: 'Pizza')
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Overall Rating',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: screenWidth < 400
                                                      ? 15
                                                      : 18),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '4.5',
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFFFF7F09),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          screenWidth < 400
                                                              ? 16
                                                              : 22),
                                                ),
                                                IgnorePointer(
                                                    ignoring: true,
                                                    child: CustomRatings(
                                                      initialRatings: 4,
                                                      itemSize:
                                                          screenWidth < 400
                                                              ? 22
                                                              : 28,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF0DAD6A)),
                                          child: Text(
                                            'Write a review',
                                            style: TextStyle(
                                                fontSize: screenWidth < 400
                                                    ? 15
                                                    : 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  for (int i = 0; i < 5; i++)
                                    const ReviewCard(
                                      name: 'Ramesh',
                                      date: '2023/06/10',
                                      rating: 4.5,
                                      reviewTitle: 'Good Food',
                                      reviewText: 'haha',
                                    ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0,
                                        left: 25,
                                        right: 25,
                                        bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/Vector-3.png'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/Vector-4.png'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/Vector-5.png'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/Vector-6.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Restaurant Info',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: screenWidth < 400
                                                  ? 13
                                                  : 15),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip Duis aute irure d. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                          style: TextStyle(
                                              fontSize: screenWidth < 400
                                                  ? 13
                                                  : 15),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: Divider(
                                            thickness: 1.5,
                                          ),
                                        ),
                                        const Text(
                                          "Restaurant Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerci sse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                        ),
                                      ],
                                    ),
                                  )
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
            )),
          );
  }
}