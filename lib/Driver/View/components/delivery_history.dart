import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'size_config.dart';
class DeliveryHistoryContainer extends StatefulWidget {
  final String orderId;
  final String totalAmount;
  final String restaurantLocation;
  final String orderLocation;
  final String itemName;
  final String itemQuantity;
  final String orderCategory;

  const DeliveryHistoryContainer(
      {super.key,
      required this.orderCategory,
      required this.orderId,
      required this.totalAmount,
      required this.restaurantLocation,
      required this.orderLocation,
      required this.itemName,
      required this.itemQuantity});

  @override
  State<DeliveryHistoryContainer> createState() =>
      _DeliveryHistoryContainerState();
}

class _DeliveryHistoryContainerState extends State<DeliveryHistoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: SizeConfig(context).containerHeight() - 100,
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(
              width: 0.2,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 30, top: 8, bottom: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.orderCategory} Order',
                            style: TextStyle(
                                fontSize: SizeConfig(context).nameSize(),
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            width: Get.width-180,
                            child: Text(
                              "Order From:  ${widget.orderId}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: SizeConfig(context).textSize(),
                                  fontWeight: FontWeight.w100,
                                  color: const Color.fromARGB(255, 75, 74, 74)),
                            ),
                          ),
                          Text(
                            "Total Amount: Rs. ${widget.totalAmount}",
                            style: TextStyle(
                                fontSize: SizeConfig(context).textSize(),
                                fontWeight: FontWeight.w100,
                                color: const Color.fromARGB(255, 75, 74, 74)),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color.fromARGB(255, 75, 74, 74),
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  "From: ${widget.restaurantLocation}",
                                  maxLines:1,
                                  overflow:TextOverflow.ellipsis,
                                  style: TextStyle(
                                    
                                      fontSize: SizeConfig(context).textSize(),
                                      fontWeight: FontWeight.w100,
                                      color:
                                          const Color.fromARGB(255, 75, 74, 74)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.fire_truck_outlined,
                                color: Color.fromARGB(255, 75, 74, 74),
                              ),
                              Text(
                                "To: ${widget.orderLocation}",
                                style: TextStyle(
                                    fontSize: SizeConfig(context).textSize(),
                                    fontWeight: FontWeight.w100,
                                    color:
                                        const Color.fromARGB(255, 75, 74, 74)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Image(
                        image: AssetImage('assets/images/food-seeklogo3.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Items",
                  //       style: TextStyle(
                  //           color: const Color.fromARGB(255, 75, 74, 74),
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: SizeConfig(context).nameSize() - 2),
                  //     ),
                  //     Text(
                  //       "Qty",
                  //       style: TextStyle(
                  //           color: const Color.fromARGB(255, 75, 74, 74),
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: SizeConfig(context).nameSize() - 2),
                  //     ),
                  //   ],
                  // ),
                  // for (int items = 0; items < 2; items++)
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           widget.itemName,
                  //           style: TextStyle(
                  //               color: const Color.fromARGB(255, 75, 74, 74),
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: SizeConfig(context).textSize()),
                  //         ),
                  //         Text(
                  //           widget.itemQuantity.toString(),
                  //           style: TextStyle(
                  //               color: const Color.fromARGB(255, 75, 74, 74),
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: SizeConfig(context).textSize()),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
