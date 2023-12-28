import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../Controller/Functions/capitalize.dart';
// import '../../../../../Model/my_order_model.dart';
import '../../../../../Model/order_history_model.dart';
import '../../../../widgets/BackButton2.dart';
import '../../Baskets/Basket/widget/size_config.dart';
import '../OrderHistory/qr_dialog.dart';

class ViewHistory extends StatefulWidget {
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
  final  List<BillingItems> billingItems;
  bool myOrder;
   ViewHistory( {super.key,
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
      required this.qrCode,
      required this.billingItems});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QrDialog(tcode: widget.qrCode,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton2(),
        title: Text(
          widget.myOrder == true ? "My Order":'ORDER HISTORY',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig(context).titleSize(),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
                            child: Container(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: Image.network(
                                  widget.logoUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.white,
                              width: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    capitalize(widget.restaurantName),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig(context).nameSize()-2,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                        size: SizeConfig(context).iconSize()-3,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                           capitalize(widget.location),
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig(context).textSize()-2,
                                                  overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Text(
                                      "Placed on: ${widget.date}",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig(context).textSize() - 2),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rs ${widget.price} (${widget.itemQty} items)",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize:
                                                SizeConfig(context).textSize()-3,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.fire_truck_outlined,
                                              color: Colors.green,
                                              size: SizeConfig(context).iconSize()-4,
                                            ),
                                            Text(
                                              widget.myOrder?"on the way":"delivered",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: SizeConfig(context)
                                                    .textSize()-3,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          widget.myOrder ?Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _showQrDialog(context);
                                },
                                child: SizedBox(
            width: 100, // Set the width of the QR code
            height: 100,
              child: QrImageView(
  data: widget.qrCode,
  version: QrVersions.auto,
  size: 200.0,
),
            ),
                              ),
                            ),
                          ):
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: Row(
                              children: [
                                Icon(Icons.star,
                                size:  SizeConfig(context)
                                                    .iconSize()-3,
                                color: Colors.orange,),
                                Text("${widget.ratings}/5",
                                style: TextStyle(
                                  fontSize: SizeConfig(context)
                                                    .textSize()-3,
                                ),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ITEMS',
                              style: TextStyle(
                                  fontSize: SizeConfig(context).nameSize()),
                            ),
                            Text('PRICE',
                                style: TextStyle(
                                  fontSize: SizeConfig(context).nameSize(),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                          ListView.builder(
                            itemCount:widget.billingItems.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    capitalize(widget.billingItems[index].itemName.toString()) + "   X"+ widget.billingItems[index].quantity.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig(context).textSize() - 1),
                                  ),
                                  Text(
                                    'Rs '+widget.billingItems[index].rate.toString() ,
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig(context).textSize() - 1,
                                    ),
                                  ),
                                ],
                              );
                            },
                           
                              
                            
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SUB-TOTAL',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Rs.  ${widget.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Rs. ${widget.discount}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DELIVERY CHARGE',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                       'Rs. ${widget.deliveryCharge}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'GRAND TOTAL',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: SizeConfig(context).nameSize() - 1),
                    ),
                    Text(
                      'Rs. ${widget.total}',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: SizeConfig(context).nameSize() - 1),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFF0DAD6A),
                      ),
                      child: Text(
                        'CLOSE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig(context).nameSize()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
