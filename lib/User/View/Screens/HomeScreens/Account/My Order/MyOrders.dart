import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/Driver/Controller/Function/capitalize.dart';
import 'package:food_app/Driver/View/components/colors.dart';
import 'package:food_app/User/Controller/repositories/Orders/my_order.dart';
import 'package:food_app/User/Model/my_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/Constants.dart';
import '../../../../custome_loader.dart';
import '../../../../widgets/BackButton2.dart';
import '../../Baskets/Basket/widget/size_config.dart';
import 'order_list_tile.dart';


class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool loading = true;
  MyOrderModel? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()async{
    setState(() {
      loading=true;
    });
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
    GetYourOrderRepository repo = GetYourOrderRepository();
    model =  await repo.getOrderRequest(userId!);
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton2(),
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig(context).titleSize(),
          ),
        ),
      ),
      body: 
      loading?
       CustomeLoader()
      :
      SingleChildScrollView(
        child:
        model?.myOrder?.length ==0? 
        Container(
          height: screenHeight-200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
            Center(
              child: Text(
                "No orders available.",
                textAlign: TextAlign.center,),
            )
          ]),
        ):Column(
          children: [
           
            Container(
              
              height: screenHeight-80,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model?.myOrder?.length,
                itemBuilder: (context, index) {
                  List<BillingItems>? billingItemsList = model?.myOrder![index].billingItems;
                 
                  int? amount = model?.myOrder?[index].amount;
                  int? discount = model?.myOrder?[index].discount;
                  int? deliveryCharge = model?.myOrder?[index].deliveryCharge;
                  int? total = model?.myOrder?[index].total;
                  int? itemQty = model?.myOrder?[index].noOfItems;
                  print("the tcode is '${model?.myOrder?[index].tCode}'");
                  return OrderListTile(
                        logoUrl: "$baseUrl/serviceproviderprofile/${model?.myOrder?[index].logo}",
                        restaurantName: '${model?.myOrder?[index].fullname}',
                        location: '${model?.myOrder?[index].address}',
                        price: amount!,
                        discount:discount!,
                        deliveryCharge:deliveryCharge!,
                        total:total!,
                        itemQty:  itemQty!,
                        time: '${model?.myOrder?[index].createdAt}',
                        date: '${model?.myOrder?[index].createdAt}',
                        ratings: '${model?.myOrder?[index].averageRating}',
                        orderStatus: 'on the way',
                        myOrder:true,
                        billingItems : billingItemsList!, 
                        qrCode:  '${model?.myOrder?[index].tCode}',
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
