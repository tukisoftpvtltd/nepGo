import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../Controller/Functions/UserStatus.dart';
import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Controller/repositories/Basket/add_to_basket_repository.dart';
import '../../../SnackBars/SnackBars.dart';

class SearchMenuItemsWithCallBack extends StatefulWidget {
  final String sid;
  final String itemName;
  final String itemPrice;
  final String itemImageUrl;
  final String restaurantName;
  final int itemId;
  final int price;
  final String note;
  Function callBack;
  SearchMenuItemsWithCallBack({
    super.key,
    required this.sid,
    required this.restaurantName,
    required this.itemName,
    required this.itemImageUrl,
    required this.itemPrice,
    required this.itemId,
    required this.price,
    required this.note,
    required this.callBack,

  });
  @override
  State<SearchMenuItemsWithCallBack> createState() => _SearchMenuItemsWithCallBackState();
}

class _SearchMenuItemsWithCallBackState extends State<SearchMenuItemsWithCallBack> {
  @override
  Widget build(BuildContext context) {
    int counter = 1;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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

    void _showCartDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
         // double screenHeight = MediaQuery.of(context).size.height;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: Center(child: Text(capitalize(widget.restaurantName))),
              content: Container(
                // height:
                //     screenHeight < 800 ? screenHeight / 2 : screenHeight / 2.5,
                width: 800,
                    // screenWidth < 400 ? screenWidth / 1.5 : screenWidth / 1.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 200,
                          width: 300,
                          child: Image.network(widget.itemImageUrl,
                          fit: BoxFit.cover,))),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      capitalize(widget.itemName),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                     Row(
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Rs "+widget.itemPrice,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Note:',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
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
                          'Quantity11',
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
                        ),
                        
                      ],
                    ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: const Color(0xFFFF0909),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () async{
                         String? userLoginStatus = await isUserLoggedIn();
                        if(userLoginStatus == 'true'){
                        AddToBasketRepository addToCart =
                            new AddToBasketRepository();
                        addToCart.AddToBasket(widget.sid,
                            counter, widget.itemId, widget.price , '',false);

                            // widget.callBack(); 
                      }
                      else{
                           Fluttertoast.showToast(
                      msg: 'Log in to add to cart ',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0,
                     );
                      }  
                      widget.callBack();               
                      Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFF0DAD6A),
                        ),
                        child: const Text('Add to cart'),
                      ),
                    ),
                  ],
                )
                  ],
                ),
              ),
              
              actions: [
                
              ],
            );
          });
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            height:135,
            width: screenWidth /3,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.3,
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
  ),
                  child: Container(
                    width: screenWidth /3,
                    height: 85,
               
                    child: Container(
                      child: Image.network(
                        widget.itemImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.9,
                  height: 2,
                ),
                Container(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0,top:5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            capitalize(widget.itemName),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth < 400 ? 10 : 10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, right: 5,bottom:2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs. ${widget.itemPrice}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth < 400 ? 10 : 10),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.green,
                                  size: screenWidth < 400 ? 20 : 20,
                                ),
                                onTap: () {
                                  _showCartDialog(context);
                                },
                              ),
                            ],
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
    );
  
  }
}
