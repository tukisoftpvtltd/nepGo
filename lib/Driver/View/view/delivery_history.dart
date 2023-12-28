import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Controller/bloc/Deliveries/deliveries_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/Function/capitalize.dart';
import '../components/colors.dart';
import '../components/delivery_history.dart';

class DeliveryHistory extends StatefulWidget {
  const DeliveryHistory({super.key});

  @override
  State<DeliveryHistory> createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {
  String? did ='';
    getDriverId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    did = await prefs.getString('driverId');
    BlocProvider.of<DeliveriesBloc>(context).add(LoadDeliveries(did!));
  }
  @override
  void initState() {
    getDriverId();

    // TODO: implement initState
    super.initState();
  }
 int count =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black,),
        title: const Text(
          'Delivery History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocBuilder<DeliveriesBloc, DeliveriesState>(
        builder: (context, state) {
          if(state is DeliveriesLoadingState){
                      return Container(
                        child: Center(
                          child: Container(
                            height: 50,
                            width:50,
                            child: CircularProgressIndicator(
                              color:Colours.primarygreen,
                            ),
                          ),
                        ),
                      );
                    }
          if(state is DeliveriesLoadedState){
            for(int i=0;i<state.model.data!.length;i++){
              if(state.model.data![i].deliveryStatus == 1){
                count++;
              }
            }
            return
             count == 0?
             Container(child: Center(child: Text("No Delivery History")))
             :
            ListView.builder(
              shrinkWrap: true,
              itemCount:state.model.data!.length,
              itemBuilder: (context,index){
                return
                  state.model.data![index].deliveryStatus == 1?  
                DeliveryHistoryContainer(
                  orderCategory: 'Food',
                  orderId: capitalize( state.model.data![index].fullname.toString()),
                  totalAmount: state.model.data![index].amount.toString(),
                  restaurantLocation: state.model.data![index].address.toString(),
                  orderLocation: state.model.data![index].delivaryLocation.toString(),
                  itemName: '',
                  itemQuantity: ''):Container();
              }
  
          );
          }
          else{
             return Container(
                        child: Center(
                          child: Container(
                            height: 50,
                            width:50,
                            child: CircularProgressIndicator(
                              color:Colours.primarygreen,
                            ),
                          ),
                        ),
                      );
          }
          
        },
      ),
    );
  }
}
