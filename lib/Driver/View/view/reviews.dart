import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../Controller/repository/getDriverReview.dart';
import '../../Model/reviewModel.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool loading= true;
  DriverReviewModel? model;
  int overAllRating =0;
  int totalRating =0;
  int overAllRides = 0;
  double driverRating =0;
  getData()async{
    DriverReviewRepository repo = DriverReviewRepository();
    model = await repo.GetDriverReview();
    totalRating = model!.driverReview!.length *5;
    overAllRides= model!.driverReview!.length;
    for(int i=0;i<model!.driverReview!.length;i++){
      overAllRating  += model!.driverReview![i].star!;
    }
    driverRating = overAllRating/totalRating*5;
    setState(() {
      loading = false;
    });

  }
  @override
  initState(){
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: null,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0,0,0,10),
          child: Center(
            child: Text(
              'Reviews',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        bottom: PreferredSize(
          
    preferredSize: const Size.fromHeight(1),
    child: Container(
      height: 1,
      color: Colors.grey.shade100,
    ),
  ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
        child: 
         loading ==true?
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    index ==0 ?RatingBoxShimmer():Container(),
                    IncomeShimmer(),
                  ],
                );
              }
            ):
            model!.driverReview!.length ==0?
            Center(
              child: Text("No review yet"),
            ):
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: Get.height-150,
                  child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:model!.driverReview!.length,
                  itemBuilder: (context, index) {
                  return 
                  Padding(
                    padding: index ==0? EdgeInsets.fromLTRB(0, 0,0,0):EdgeInsets.fromLTRB(0, 0,0,0),
                    child: Column(
                      children: [
                       index==0? RatingBox(
                        overAllRating: driverRating,
                        overAllRides: overAllRides,
                       ):Container(),
                        ReviewContainer(
                          reviewTitle: model!.driverReview![index].title.toString(),
                          reviewDescription: model!.driverReview![index].reviews.toString(),
                          ratings: model!.driverReview![index].star.toString(),
                        ),
                      ],
                    ),
                  );
                          },
                        ),
                ),
              ],
            ),
      ),
    );
  }
}


class RatingBox extends StatefulWidget {
  double overAllRating;
  int overAllRides;
  RatingBox({super.key,
  required this.overAllRating,
  required this.overAllRides});

  @override
  State<RatingBox> createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: Get.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Overall Rating",
                      maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: '${widget.overAllRating.toStringAsFixed(1)}',
        style: TextStyle(
          fontSize: 32, // First font size
          color: Colors.black,
          fontWeight: FontWeight.w500
        ),
      ),
      TextSpan(
        text: ' /5',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w500
        ),
      ),
    ],
  ),
),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                      initialRating:  widget.overAllRating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index){
                        int number = widget.overAllRating.toInt();
                        
                        print("The number is "+number.toString());
                        print("The overAllRating is ${widget.overAllRating}");
                        double remainder = widget.overAllRating % number;
                        print("The remainder is"+remainder.toString());
                        
                        if(index == widget.overAllRating.toInt() && remainder<0.5){
                            return const Icon(
                        Icons.star_half_outlined,
                        color: Color(0xFFFF9900),
                      );
                        }
                        else{
                            return const Icon(
                        Icons.star,
                        color: Color(0xFFFF9900),
                      );
                        }
                        
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          // rate = rating.toInt();
                        });
                      },
                    ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      width: Get.width/2-10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(child: Text('Based on ${widget.overAllRides} Reviews')),
                      ),
                    )
                    ],
                  ),
                );
  }
}


class RatingBoxShimmer extends StatelessWidget {
  const RatingBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  width: Get.width,
                  height: 200,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                        child: Text("Overall Rating",
                        maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                      child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '0.0',
                            style: TextStyle(
                              fontSize: 32, // First font size
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: ' /5',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                          child: RatingBar.builder(
                                              initialRating:  1,
                                              minRating: 0,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemSize: 30,
                                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, index){
                              return const Icon(
                          Icons.star,
                          color: Color(0xFFFF9900),
                                              );
                          
                          
                                              },
                                              onRatingUpdate: (rating) {
                                              
                                              },
                                            ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      width: Get.width/2-10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Text('Based on 0 Reviews'))),
                      ),
                    )
                    ],
                  ),
                );
  }
}

class ReviewContainer extends StatefulWidget {
  String reviewTitle;
  String reviewDescription;
  String ratings;
  ReviewContainer({super.key,
  required this.reviewTitle,
  required this.reviewDescription,
  required this.ratings,
  });
 

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(children: [
            SizedBox(
              width: 20,
            ),
            ClipOval(
                child: Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'assets/rideshare/person.jpg',
                      fit: BoxFit.cover,
                    ))),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width*0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.reviewTitle}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  
                  Text(
                    "${widget.reviewDescription}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14,
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
           
            Container(
              width: Get.width*0.15,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.ratings}/5",
                    style: TextStyle(
                        color: Color(0xFFFF9900),),
                  ),
                  Icon(Icons.star,
                  color: Color(0xFFFF9900),
                  ),
                ],
              ),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
            
          ),
        ],
      ),
    );
  
  }
}


class IncomeShimmer extends StatelessWidget {
  const IncomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(children: [
            SizedBox(
              width: 20,
            ),
            Shimmer.fromColors(
               baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
              child: ClipOval(
                  child: Container(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        'assets/rideshare/person.jpg',
                        fit: BoxFit.cover,
                      ))),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width*0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width:Get.width*1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width:Get.width*1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width:Get.width*1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
           
            
          ]),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
            
          ),
        ],
      ),
    );
  ;
  }
}