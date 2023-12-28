import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Baskets/Basket/view_basket.dart';
import 'package:food_app/User/View/constants/Constants.dart';
import 'package:food_app/User/View/custome_loader.dart';
import '../../../../../Controller/bloc/Baskets/Basket_detail.dart/bloc/basket_detail_bloc.dart';
import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../Controller/repositories/Basket/deleteRestroBasket.dart';
import '../../../../../Controller/repositories/Basket/delete_from_basket_repository.dart';
import '../../../../constants/colors.dart';
import 'basket_list.dart';
import 'noCartFound.dart';

class BasketScreen extends StatefulWidget {
  Function callback;
  BasketScreen({super.key,required this.callback});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  bool loading = true;
  List BasketList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BasketBloc>(context).add(onBasketLoading());

     widget.callback();
  }
  //100
  //35

  DeleteBasket(String sid) async{
     DeleteBasketRepository repo = DeleteBasketRepository();
    bool response = await repo.DeleteRestroBasket(sid) ;
    if(response == true){
      BlocProvider.of<BasketBloc>(context).add(onBasketLoading());
    }
    widget.callback();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              if(state is BasketLoading){
              return Scaffold(
                appBar: AppBar(
                    toolbarHeight: 50,
                    title: Center(child: Text(
                    "My Baskets",style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),)),
                  backgroundColor: Colors.white,
                  elevation: 0,),
                body: CustomeLoader());
              }
              else if(state is BasketEmpty){
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                    toolbarHeight: 50,
                    title: Center(child: Text(
                    "My Baskets",style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),)),
                  backgroundColor: Colors.white,
                  elevation: 0,),
                body: NoCartFound());
              }
              else if(state is BasketLoaded){
                return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 50,
                    title: Center(child: Text(
                    "My Baskets",style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),)),
                  backgroundColor: Colors.white,
                  elevation: 0,),
                  body: RefreshIndicator(
                    color: Colours.primarygreen,
                    onRefresh: () async {
                      return Future.delayed(Duration(seconds: 1));
                    },
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: state.basketListModel.serviceProviderWithItemsCount!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              height: 120,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => BasketDetailBloc(),
                    child: BlocProvider(
                      create: (context) => ServiceProviderDetailBloc(),
                      child: ViewBasket(
                        sid: state.basketListModel.serviceProviderWithItemsCount![index].sId.toString(),
                      ),
                    ),
                  )));
                                    },
                                    child: Container(
                                      height: 120,
                                      child: BasketListTile(
                                        sid: state.basketListModel.serviceProviderWithItemsCount![index].sId.toString(),
                                        logoUrl:'$baseUrl/serviceproviderprofile/' +
                                                state.basketListModel.serviceProviderWithItemsCount![index].logo.toString(),
                                        restaurantName: state.basketListModel.serviceProviderWithItemsCount![index].fullname.toString(),
                                        location: state.basketListModel.serviceProviderWithItemsCount![index].address.toString(),
                                        price: 0,
                                        itemQty: state.basketListModel.serviceProviderWithItemsCount![index].basketItems.toString(),
                                        openTime: state.basketListModel.serviceProviderWithItemsCount![index].openingTime.toString(),
                                        closeTime:  state.basketListModel.serviceProviderWithItemsCount![index].closingTime.toString(),
                                        ratings:double.parse(state.basketListModel.serviceProviderWithItemsCount![index].averageRate.toString()),
                                        items: state.basketListModel.serviceProviderWithItemsCount![index].basketItems!.toList(),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      String sid = state.basketListModel.serviceProviderWithItemsCount![index].sId.toString();
                                      DeleteBasket(sid);
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 100,
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(
                color: Colours.primarygreen,
              ));
              }
            },
          );
        // : BasketList.isEmpty == true
        //     ? NoCartFound()
        //     : SafeArea(
        //         child: RefreshIndicator(
        //           color: Colours.primarygreen,
        //           onRefresh: () async {
        //             return Future.delayed(Duration(seconds: 1));
        //           },
        //           child: ListView.builder(
        //             itemCount: BasketList.length,
        //             shrinkWrap: true,
        //             itemBuilder: (BuildContext context, int index) {
        //               List BasketItemList = BasketList[index]['Basket_Items'];
        //               print(BasketItemList);

        //               return Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
        //                 child: Container(
        //                   height: 120,
        //                   child: ListView(
        //                     shrinkWrap: true,
        //                     scrollDirection: Axis.horizontal,
        //                     children: [
        //                       Container(
        //                         height: 120,
        //                         child: BasketListTile(
        //                           sid: BasketList[index]['s_id'],
        //                           logoUrl:
        //                               '$baseUrl/serviceproviderprofile/' +
        //                                   BasketList[index]['logo'],
        //                           restaurantName: BasketList[index]['fullname'],
        //                           location: BasketList[index]['address'],
        //                           price: 0,
        //                           itemQty: "0".toString(),
        //                           openTime: "10:00",
        //                           closeTime: "10:00",
        //                           ratings: 3,
        //                           items: BasketItemList,
        //                         ),
        //                       ),
        //                       GestureDetector(
        //                         onTap: () {
        //                           DeleteBasket();
        //                         },
        //                         child: Container(
        //                           height: 120,
        //                           width: 100,
        //                           color: Colors.red,
        //                           child: Icon(
        //                             Icons.delete,
        //                             color: Colors.white,
        //                             size: 32,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       );
  }
}
