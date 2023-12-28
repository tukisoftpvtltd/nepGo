import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Controller/repositories/Orders/order_history.dart';
import '../../../../../Model/order_history_model.dart';
import '../../../../constants/Constants.dart';
import '../../../../custome_loader.dart';
import '../../../../widgets/BackButton2.dart';
import '../../Baskets/Basket/widget/size_config.dart';
import 'order_list_tile.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
        getData();
  }
  // OrderResponse? model;
  OrderHistoryModel? model;
  bool loading = true;
  getData()async{
    setState(() {
      loading=true;
    });
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
    GetOrderHistoryRepository repo = GetOrderHistoryRepository();
    model =  await repo.getOrderhistory(userId!);
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
          'Order History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig(context).titleSize(),
          ),
        ),
      ),
      body: 
      loading ?
       CustomeLoader()
      :
      SingleChildScrollView(
        child: model?.salesledger?.length ==0? 
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
        ):
        
        Container(
          height: screenHeight-80,
          child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model?.salesledger?.length,
                  itemBuilder: (context, index) {
              List<BillingItems>? billingItemsList = model?.salesledger![index].billingItems;
              print("The billing Items are:");
             // print(billingItemsList?[0].itemName);
              int? amount = model?.salesledger?[index].amount;
              print("The amount is:"+ amount.toString());
              int? discount = model?.salesledger?[index].discount;
              int? deliveryCharge = model?.salesledger?[index].deliveryCharge;
              int? total = model?.salesledger?[index].total;
              int? itemQty = model?.salesledger?[index].noOfItems;
                    return OrderListTile(
                        logoUrl: "$baseUrl/serviceproviderprofile/${model?.salesledger![index].logo}",
                        restaurantName: '${model?.salesledger![index].fullname}',
                        location: '${model?.salesledger![index].address}',
                        price: amount!,
                        discount: discount!,
                        deliveryCharge:deliveryCharge!,
                        total:total!,
                        itemQty: itemQty!,
                        time: '${model?.salesledger![index].createdAt}',
                        date: '${model?.salesledger![index].createdAt}',
                        ratings: '0.0',
                        orderStatus: 'Delivered',
                        myOrder: false,
                        billingItems: billingItemsList??[],
                        qrCode: '${model?.salesledger![index].tCode}'
                        );
                  }
                  ),
        ),
                
         
      ),
    );
  }
}
