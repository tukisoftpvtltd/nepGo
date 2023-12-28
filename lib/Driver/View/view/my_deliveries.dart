import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Controller/Function/capitalize.dart';
import 'package:food_app/User/View/constants/colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/bloc/Deliveries/deliveries_bloc.dart';
import '../../Controller/repository/updateDelivery.dart';
import '../components/delivery_container.dart';
import '../components/size_config.dart';
import '../components/transfer_container.dart';

class MyDeliveriesScreen extends StatefulWidget {
  int index;
  //index 0 means pending deliverires
  //index 1 means delivered 
  //index 2 means transfer
   MyDeliveriesScreen({super.key,required this.index});

  @override
  State<MyDeliveriesScreen> createState() => _MyDeliveriesScreenState();
}

class _MyDeliveriesScreenState extends State<MyDeliveriesScreen> {
  String? did='';
  
  getDriverId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      did = await prefs.getString('driverId');
      print("the driver id is");
      print(did);
      BlocProvider.of<DeliveriesBloc>(context).add(LoadDeliveries(did!));
  }
  
  @override
  void initState() {
    // TODO: implement initState
    getDriverId();
    
    super.initState();
  }
  int count =0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
         leading: null,
        elevation: 0,
          title: const Text(
            'Deliveries',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
      ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // TabBar(
                //   tabs: [
                //     Tab(
                //       child: Text(
                //         "MY DELIVERIES",
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: SizeConfig(context).textSize()),
                //       ),
                //     ),
                //     Tab(
                //       child: Text(
                //         "TRANSFER REQUEST",
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: SizeConfig(context).textSize()),
                //       ),
                //     ),
                //   ],
                // ),
                BlocBuilder<DeliveriesBloc, DeliveriesState>(
                  builder: (context, state) {
                    if(state is DeliveriesLoadingState){
                      return Expanded(
                        child: Container(
                          child: Center(
                            child: Container(
                              height: 50,
                              width:50,
                              child: CircularProgressIndicator(
                                color:Colours.primarygreen,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if(state is DeliveriesLoadedState){
                      for(int i=0;i<state.model.data!.length;i++){
              if(state.model.data![i].deliveryStatus == 0){
                count++;
              }
            }
                      return 
                      Expanded(
                      child: Container(
                        width: double.infinity,
                        child: count ==0 ?
                      Container(
                        
                        child: Padding(
                        padding:  EdgeInsets.fromLTRB(0,Get.height/2-150,0,0),
                        child: ListView(
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.asset('assets/images/fast-delivery.png')),
                                
                            ),
                            Center(child: Text("No Deliveries")),
                            
                          ]
                         ),
                        ),
                          // child:
                        // ),
                      )
                      :
                            ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.model.data!.length,
                          itemBuilder: (context,index){
                            if(state.model.data![index].deliveryStatus == 0){
                              count++;
                            }
                            return  
                            
                            state.model.data![index].deliveryStatus == widget.index ? 
                            Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8.0, top: 8.0),
                                  child: DeliveryContainer(
                                      orderCategory: 'Food',
                                      orderId: capitalize(state.model.data![index].fullname.toString()),
                                      totalAmount: state.model.data![index].amount.toString(),
                                      restaurantLocation: capitalize(state.model.data![index].address.toString()),
                                      orderLocation: capitalize(state.model.data![index].delivaryLocation.toString()),
                                      itemName: '',
                                      itemQuantity: '',
                                      restroLat: state.model.data![index].latitude.toString(),
                                      restroLong: state.model.data![index].longitude.toString(),
                                      orderLat:state.model.data![index].lat.toString(),
                                      orderLong:state.model.data![index].long.toString(),
                                      tCode:state.model.data![index].tCode.toString(),
                                      did:did!
                                      ),
                                ):
                                Container(
                                )
                                ;
                          }
                        ),
                      ),
                    );
                  
                    }
                    else{
                     return  Center(
                        child: CircularProgressIndicator(
                          color:Colours.primarygreen,
                        ),
                      );
                    }
                    
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
