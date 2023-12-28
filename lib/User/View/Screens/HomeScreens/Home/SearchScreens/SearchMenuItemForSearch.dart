import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../Controller/Functions/UserStatus.dart';
import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/repositories/Basket/add_to_basket_repository.dart';
import '../../../../constants/colors.dart';
import '../../../SnackBars/SnackBars.dart';
import '../../Account/LogIn/loginpage.dart';

class SearchMenuItemsForSearch extends StatefulWidget {
  final String sid;
  final String itemName;
  final String itemPrice;
  final String itemImageUrl;
  final String restaurantName;
  final int itemId;
  final int price;
  final String note;
  SearchMenuItemsForSearch({
    super.key,
    required this.sid,
    required this.restaurantName,
    required this.itemName,
    required this.itemImageUrl,
    required this.itemPrice,
    required this.itemId,
    required this.price,
    required this.note,

  });
  @override
  State<SearchMenuItemsForSearch> createState() => _SearchMenuItemsForSearchState();
}

class _SearchMenuItemsForSearchState extends State<SearchMenuItemsForSearch> {
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
    
void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // insetPadding: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,8),
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alert!',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                Text('Please log in to add to cart',style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade600), // Change the color here
            ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      
                    },
              ),
              SizedBox(
                width: 20,
              ),
                    ElevatedButton(
                    style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colours.primarygreen), // Change the color here
            ),
                    child: Text('Login'),
                    onPressed: () {
                     Navigator.of(context).pop();
                      Get.to( BlocProvider(
                      create: (context) => SignInBloc(context),
                      child: Loginpage(
                        singlePage:true
                      ),
                    ),);
                    },
              ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
       
      );
    },
  );
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
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/imageLoader.png', 
                            image: widget.itemImageUrl,fit: BoxFit.cover,)
                          )),
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
                        ),
                        
                      ],
                    ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: screenWidth/3.2,
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
                      width: screenWidth/3.2,
                      child: ElevatedButton(
                        onPressed: () async{
                         String? userLoginStatus = await isUserLoggedIn();
                        if(userLoginStatus == 'true'){
                      //  BlocProvider.of<BasketBloc>(context).add(getBasketCounter());
                        AddToBasketRepository addToCart =
                            new AddToBasketRepository();
                        addToCart.AddToBasket(widget.sid,
                            counter, widget.itemId, widget.price , '',false);
                        ShowCustomSnackBar(context, "Added to cart",widget.sid);  
                            // widget.callBack(); 
                      }
                      else{
                        _showAlertDialog(context);
                    //        Fluttertoast.showToast(
                    //   msg: 'Log in to add to cart',
                    //   toastLength: Toast.LENGTH_SHORT,
                    //   gravity: ToastGravity.BOTTOM,
                    //   backgroundColor: Colors.black54,
                    //   textColor: Colors.white,
                    //   fontSize: 16.0,
                    //  );
                      }        
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
                      child:  FadeInImage.assetNetwork(
                  placeholder: 'assets/images/imageLoader2.png', // Placeholder using KTransparentImage
                  image: widget.itemImageUrl,
                  fit: BoxFit.cover,
                )
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
                                onTap: () async{
                                 String? userLoginStatus = await isUserLoggedIn();
                                  if(userLoginStatus != 'true'){
                                    _showAlertDialog(context);
                                    }
                                    else{
                                        _showCartDialog(context);
                                    }
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
