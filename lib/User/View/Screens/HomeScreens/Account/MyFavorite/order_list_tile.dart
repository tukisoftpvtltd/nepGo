import 'package:flutter/material.dart';
import '../../Baskets/Basket/widget/size_config.dart';
import '../OrderHistory/view_history.dart';

class OrderListTile extends StatelessWidget {
  final String logoUrl;
  final String restaurantName;
  final String location;
  final double price;
  final int itemQty;
  final double ratings;
  final String time;
  final String date;
  final String orderStatus;
  final String? qrCode;

  const OrderListTile(
      {super.key,
      required this.logoUrl,
      required this.restaurantName,
      required this.location,
      required this.price,
      required this.itemQty,
      required this.time,
      required this.date,
      required this.ratings,
      required this.orderStatus,
      this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
        
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 50,
                child: Image.asset(logoUrl),
              ),
              Container(
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: TextStyle(
                          fontSize: SizeConfig(context).nameSize(),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey.shade500,
                          size: SizeConfig(context).iconSize(),
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              fontSize: SizeConfig(context).textSize()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Placed on: $date, $time",
                      style: TextStyle(
                          fontSize: SizeConfig(context).textSize() - 1),
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
                            fontSize: SizeConfig(context).textSize(),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.fire_truck_outlined,
                              color: Colors.green,
                            ),
                            Text(" $orderStatus",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: SizeConfig(context).textSize(),
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
              Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
