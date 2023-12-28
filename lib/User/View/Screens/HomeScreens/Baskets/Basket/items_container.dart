import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/Functions/capitalize.dart';
import '../../../../../Controller/bloc/Baskets/Basket_detail.dart/bloc/basket_detail_bloc.dart';
import '../../../../../Controller/repositories/Basket/add_to_basket_repository.dart';
import '../../../../../Model/add_to_cart_model.dart';
import 'widget/size_config.dart';

class BasketItemsContainer extends StatefulWidget {
  final String sid;
  final int itemId;
  final String itemName;
  final int price;
  final String count;
  const BasketItemsContainer({
    super.key,
    required this.sid,
    required this.itemId,
    required this.itemName,
    required this.price,
    required this.count,
  });

  @override
  State<BasketItemsContainer> createState() => _BasketItemsContainerState();
}

class _BasketItemsContainerState extends State<BasketItemsContainer> {


  @override
  Widget build(BuildContext context) {
         int itemNo =int.parse(widget.count);

  void increment() async{
      itemNo++;
     AddToBasketRepository addToCart =
                          new AddToBasketRepository();
     AddToBasketModel response = await addToCart.AddToBasket(
      widget.sid,itemNo, widget.itemId, widget.price , "",true);
      if(response.status =="success"){
        BlocProvider.of<BasketDetailBloc>(context).add(onBasketDetailLoading(widget.sid));
      }
      else{

      }
    
  }

  void decrement() async{
      if (itemNo > 1) {
        itemNo--;
      }
    await Future.delayed(Duration(milliseconds: 100));
     AddToBasketRepository addToCart =
                          new AddToBasketRepository();
     AddToBasketModel response = await addToCart.AddToBasket(
      widget.sid,itemNo, widget.itemId, widget.price , "",true);
       if(response.status =="success"){
        BlocProvider.of<BasketDetailBloc>(context).add(onBasketDetailLoading(widget.sid));
      }
      else{

      }
  }

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalize(widget.itemName),
                    style: TextStyle(
                      fontSize: SizeConfig(context).textSize(),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                decrement();
                              });
                            },
                            child: 
                             TextButton(
                              
  onPressed: () {
    decrement();
  },
  child: Text(
    '-',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.green,
    ),
  ),
)
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '$itemNo' ,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                                increment();
                            },
                            child: TextButton(
                              
  onPressed: () {
    increment();
  },
  child: Text(
    '+',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.green,
    ),
  ),
)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                'Rs. ${widget.price.toString()}',
                style: TextStyle(
                  fontSize: SizeConfig(context).textSize(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
