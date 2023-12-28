import 'package:flutter/material.dart';

import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Model/my_order_model.dart';
// import '../../../../../Model/order_history_model.dart';
import '../../Baskets/Basket/widget/size_config.dart';
import 'view_history.dart';

class OrderListTile extends StatelessWidget {
  final String logoUrl;
  final String restaurantName;
  final String location;
  final int price;
   final int discount;
  final int deliveryCharge;
  final int total;
  final int itemQty;
  final String ratings;
  final String time;
  final String date;
  final String orderStatus;
  final String qrCode;
  final  List<BillingItems>billingItems;
  
  bool myOrder;

  OrderListTile(
      {super.key,
      required this.logoUrl,
      required this.restaurantName,
      required this.location,
      required this.price,
      required this.discount,
      required this.deliveryCharge,
      required this.total,
      required this.itemQty,
      required this.time,
      required this.date,
      required this.ratings,
      required this.orderStatus,
      required this.myOrder,
      required this.billingItems,
      required this.qrCode});


   

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ViewHistory(
                logoUrl: logoUrl,
                restaurantName: restaurantName,
                location: location,
                price: price,
                discount: discount,
                deliveryCharge: deliveryCharge,
                total: total,
                itemQty: itemQty,
                time: time,
                date: date,
                ratings: ratings,
                orderStatus: orderStatus,
                myOrder: myOrder,
                billingItems: billingItems,
                qrCode: qrCode,
              )));
        },
        child: Container(
          
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Shadow color
                        offset: Offset(0, 3), // Offset from the container
                        blurRadius: 1, // Spread radius of the shadow
                        spreadRadius: 1, // Radius of the shadow blur
                      ),
                    ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: ClipOval(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: 
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/imageLoader.png',
                      image: logoUrl,
                      fit: BoxFit.fill,
                    ),
                    // Image.network(logoUrl,
                    // fit: BoxFit.fill,),
                  ),
                ),
              ),
              Container(
                width: screenWidth-180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(
                      height: 5,
                    ),
                    Text(
                      capitalize(restaurantName),
                      style: TextStyle(
                          fontSize: SizeConfig(context).nameSize()-4,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                          size: SizeConfig(context).iconSize()-4,
                        ),
                        Container(
                          width: screenWidth/2.3,
                          child: Text(
                            capitalize(location),
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: SizeConfig(context).textSize()-3,
                                overflow: TextOverflow.ellipsis
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Placed on: $date",
                      style: TextStyle(
                          fontSize: SizeConfig(context).textSize() - 3),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs $price ($itemQty item)",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: SizeConfig(context).textSize()-3,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.fire_truck_outlined,
                              color: Colors.green,
                              size: SizeConfig(context).iconSize()-4,
                            ),
                            Text(" $orderStatus",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: SizeConfig(context).textSize()-3,
                                )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: SizeConfig(context).iconSize(),
                      ),
                      Text(
                        "$ratings/5",
                        style: TextStyle(
                            fontSize: SizeConfig(context).textSize() - 2),
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
