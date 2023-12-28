import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/User/View/Screens/SnackBars/SnackBars.dart';

import '../../../../../../Controller/Functions/capitalize.dart';
import '../../../../../../Controller/repositories/Basket/add_to_basket_repository.dart';

// ignore: must_be_immutable
class BasketMenuItemsCard extends StatefulWidget {
  final Function callback;
  final int itemId;
  final String sid;
  final String restaurantName;
  final String itemName;
  final int price;
  final String imageUrl;
  // String location;
  // String logoUrl;
  // List items;

  const BasketMenuItemsCard({
    super.key,
    required this.callback,
    required this.itemId,
    required this.sid,
    required this.itemName,
    required this.price,
    required this.imageUrl,
    required this.restaurantName,
  });
  @override
  State<BasketMenuItemsCard> createState() => _BasketMenuItemsCardState();
}

class _BasketMenuItemsCardState extends State<BasketMenuItemsCard> {
  int counter = 1;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }

  TextEditingController note = new TextEditingController();
  void _showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
       // double screenHeight = MediaQuery.of(context).size.height;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            title: Center(child: Text(widget.restaurantName)),
            content: Container(
              width: screenWidth < 400 ? screenWidth / 1.5 : screenWidth / 1.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        height: 200,
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.itemName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Price:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Rs."+widget.price.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(
                        "Note:",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                  TextFormField(
                    maxLines: 2,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(
                                () {
                                  decrement();
                                },
                              );
                            },
                            child: const Text(
                              '-',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          Text('$counter'),
                          TextButton(
                            onPressed: () {
                              setState(
                                () {
                                  increment();
                                },
                              );
                            },
                            child: const Text(
                              '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: const Color(0xFFFF0909),
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                     
                      AddToBasketRepository addToCart =
                          new AddToBasketRepository();
                      addToCart.AddToBasket(widget.sid,
                          counter, widget.itemId, widget.price , note.text,false); 
                    widget.callback();                 
                    Navigator.pop(context);
                    

                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: const Color(0xFF0DAD6A),
                    ),
                    child: const Text('Add to cart'),
                  ),
                ],
              )
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            height: 155,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.3,
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  ),
                  child: Container(
                    width: screenWidth /3,
                    height: 100,
                    child: Container(
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.9,
                  height: 2,
                ),
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            capitalize(widget.itemName),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth < 400 ? 12 : 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs. ${widget.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth < 400 ? 12 : 12),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.green,
                                  size: screenWidth < 400 ? 20 : 22,
                                ),
                                onTap: () {
                                  _showCartDialog(context);
                                },
                              ),
                              
                            ],
                          ),
                        ),
                        SizedBox(
                                height: 3,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      
  }
}
