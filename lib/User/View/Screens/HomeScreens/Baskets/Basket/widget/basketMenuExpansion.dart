import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/Functions/capitalize.dart';

import '../../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../Home/Restaurants/components/menu_items_card.dart';
import '../../../Home/SearchScreens/SearchMenuItemWithCallBack.dart';
import '../../../Home/SearchScreens/search_menu_items.dart';
import 'BasketMenuItemCard.dart';

// ignore: must_be_immutable
class BasketMenuExpansion extends StatefulWidget {
  final String dishName;
  List menuItems;
  String sid;
  Function expansionCallBack;
  BasketMenuExpansion({super.key,
   required this.dishName, 
   required this.menuItems,
   required this.sid,
   required this.expansionCallBack
   });

  @override
  State<BasketMenuExpansion> createState() => _BasketMenuExpansionState();
}

class _BasketMenuExpansionState extends State<BasketMenuExpansion> {
  List MenuItem = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MenuItem = widget.menuItems;
        BlocProvider.of<ServiceProviderDetailBloc>(context).add(OnServiceProviderDetailLoading(widget.sid));
  }
  callback(){
    widget.expansionCallBack();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ServiceProviderDetailBloc, ServiceProviderDetailState>(
      builder: (context, state) {
        if(state is ServiceProviderDetailLoadingState){
          return Container();
        }
        else if(state is ServiceProviderDetailLoadedState){
        return Container(
          height: 400,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.data.serviceProviderItemsWithCategories!.length,
            itemBuilder: (context,index){
              return ExpansionTile(
                
            title: Text(
              capitalize(
              state.data.serviceProviderItemsWithCategories![index].catName!),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: screenWidth < 400 ? 14 : 16,
              ),
            ),
            initiallyExpanded: index ==0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 140,
                  width: screenWidth,
                  // width: 150,
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection:Axis.horizontal,
                     itemCount: state.data.serviceProviderItemsWithCategories![index].catItems!.length,
                
                      itemBuilder: (BuildContext context, int index2) {
                        
                        int rate = state.data.serviceProviderItemsWithCategories![index].catItems![index2].sellrate!;
                        return Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              child: SearchMenuItemsWithCallBack(
                                sid: state.data.serviceProviderItemsWithCategories![index].catItems![index2].sId!,
                                itemName: state.data.serviceProviderItemsWithCategories![index].catItems![index2].itemName!,
                                itemPrice: rate.toString(),
                                itemImageUrl: "https://meroato.tukisoft.com.np/uploads/${state.data.serviceProviderItemsWithCategories![index].catItems![index2].coverImage}",
                                itemId: state.data.serviceProviderItemsWithCategories![index].catItems![index2].id!,
                                price: rate,
                                note: '',
                                restaurantName: state.data.serviceProvider![0].fullname!,
                                callBack: callback,
                              ),
                            ),
                          ],
                        );
                        // MenuItemsCard(
                        //   key: UniqueKey(),
                        //   itemId: state.data.serviceProviderItemsWithCategories![index].catItems![index2].id!.toInt(),
                        //   sid: state.data.serviceProviderItemsWithCategories![index].catItems![index2].sId!,
                        //   itemName: state.data.serviceProviderItemsWithCategories![index].catItems![index2].itemName!,
                        //   price: rate,
                        //   imageUrl:
                        //       "https://meroato.tukisoft.com.np/uploads/${state.data.serviceProviderItemsWithCategories![index].catItems![index2].coverImage}",
                        //   restaurantName: state.data.serviceProvider![0].fullname!,
                        // );
                      })),
                
                //  Container(
                //     height: 170,
                //     child: GridView.builder(
                //       physics: NeverScrollableScrollPhysics(),
                //         itemCount: state.data.serviceProviderItemsWithCategories![index].catItems!.length,
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 3,
                //                 childAspectRatio: 80 / 110,
                //                 crossAxisSpacing: 5,
                //                 mainAxisSpacing: 0),
                //         itemBuilder: (BuildContext context, int index2) {
                //           int rate = state.data.serviceProviderItemsWithCategories![index].catItems![index2].sellrate!;
                //           return 
                //           BasketMenuItemsCard(
                //             callback:callback,
                //             key: UniqueKey(),
                //             itemId: state.data.serviceProviderItemsWithCategories![index].catItems![index2].id!.toInt(),
                //             sid: state.data.serviceProviderItemsWithCategories![index].catItems![index2].sId!,
                //             itemName: state.data.serviceProviderItemsWithCategories![index].catItems![index2].itemName!,
                //             price: rate,
                //             imageUrl:
                //                 "https://meroato.tukisoft.com.np/uploads/${state.data.serviceProviderItemsWithCategories![index].catItems![index2].coverImage}",
                //             restaurantName: state.data.serviceProvider![0].fullname!,
                //           );
                //         })),
              ),
            ],
          );
            }
            ,
          ),
        );
        
      }
      else{
        return Container();
      }
      }
      
    );
  }
}
