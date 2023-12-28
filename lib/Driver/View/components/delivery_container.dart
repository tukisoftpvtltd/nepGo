import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Controller/repository/updateDelivery.dart';
import 'size_config.dart';
class DeliveryContainer extends StatefulWidget {
  final String orderId;
  final String totalAmount;
  final String restaurantLocation;
  final String orderLocation;
  final String itemName;
  final String itemQuantity;
  final String orderCategory;
  final String restroLat;
  final String restroLong;
  final String orderLat;
  final String orderLong;
  final String tCode;
  final String did;

  const DeliveryContainer(
      {super.key,
      required this.orderCategory,
      required this.orderId,
      required this.totalAmount,
      required this.restaurantLocation,
      required this.orderLocation,
      required this.itemName,
      required this.itemQuantity,
      required this.restroLat,
      required this.restroLong,
      required this.orderLat,
      required this.orderLong,
      required this.tCode,
      required this.did});

  @override
  State<DeliveryContainer> createState() => _DeliveryContainerState();
}

class _DeliveryContainerState extends State<DeliveryContainer> {
  void launchGoogleMaps({
  required String fromLocation,
   required String toLocation,
}) async {
  final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&origin=$fromLocation&destination=$toLocation&travelmode=driving";
  
  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }
}
UpdatePickUp(String tCode){
    UpdateDeliveriesRepository repo = UpdateDeliveriesRepository();
    repo.UpdateDeliveries(tCode, widget.did, '4');
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      height: SizeConfig(context).containerHeight()-50,
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
            padding:
                const EdgeInsets.only(left: 8.0, right: 30, top: 8, bottom: 8),
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
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          width: Get.width-150,
                          child: Text(
                            "Order By:  ${widget.orderId}",
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
                              width: Get.width-200,
                              child: Text(
                                "${widget.restaurantLocation}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  
                                    fontSize: SizeConfig(context).textSize(),
                                    fontWeight: FontWeight.w100,
                                    color: const Color.fromARGB(255, 75, 74, 74)),
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
                              "${widget.orderLocation}",
                              style: TextStyle(
                                  fontSize: SizeConfig(context).textSize(),
                                  fontWeight: FontWeight.w100,
                                  color: const Color.fromARGB(255, 75, 74, 74)),
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
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  UpdatePickUp(widget.tCode);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig(context).buttonHorizontalPadding(),
                      vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.black,
                ),
                child: const Text('Pick Up'),
              ),
              ElevatedButton(
                onPressed: () {
                  String restroLocation = widget.restroLat+','+widget.restroLong;
                  String orderLocation = widget.orderLat+','+widget.orderLong;
                  launchGoogleMaps(
      fromLocation: restroLocation ,
      toLocation: orderLocation,
    );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig(context).buttonHorizontalPadding(),
                      vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text('Deliver'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
