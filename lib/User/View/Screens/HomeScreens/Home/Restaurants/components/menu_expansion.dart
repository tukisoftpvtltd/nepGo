import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/Functions/capitalize.dart';
import 'package:get/get.dart';

import '../../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
import '../../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../constants/colors.dart';
import '../../../Account/LogIn/loginpage.dart';
import '../../SearchScreens/search_menu_items.dart';
import 'menu_items_card.dart';

// ignore: must_be_immutable
class MenuExpansion extends StatefulWidget {
  bool? scrollable;
  final String dishName;
  List menuItems;
  MenuExpansion({super.key,this.scrollable, required this.dishName, required this.menuItems});

  @override
  State<MenuExpansion> createState() => _MenuExpansionState();
}

class _MenuExpansionState extends State<MenuExpansion> {
  List MenuItem = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MenuItem = widget.menuItems;
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<ServiceProviderDetailBloc, ServiceProviderDetailState>(
      builder: (context, state) {
        if(state is ServiceProviderDetailLoadingState){
          return Container();
        }
        else if(state is ServiceProviderDetailLoadedState){
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.data.serviceProviderItemsWithCategories!.length,
          
          itemBuilder: (context,index){
            return ExpansionTile(
          title: Text(
            capitalize(
            state.data.serviceProviderItemsWithCategories![index].catName!),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: screenWidth < 400 ? 14 : 14,
            ),
          ),
          
          initiallyExpanded: index ==0 && state.data.serviceProviderItemsWithCategories![index].catItems!.length !=0,
          
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,10),
                child: GridView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: state.data.serviceProviderItemsWithCategories![index].catItems!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, 
                        mainAxisSpacing: 8,
                        childAspectRatio: (screenWidth/3)/(screenWidth/3+15), //width/height
                       ),
                      itemBuilder: (BuildContext context, int index2) {
                        int rate = state.data.serviceProviderItemsWithCategories![index].catItems![index2].sellrate!;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          child: SearchMenuItems(
                                    sid: state.data.serviceProviderItemsWithCategories![index].catItems![index2].sId!,
                                    itemName: state.data.serviceProviderItemsWithCategories![index].catItems![index2].itemName!,
                                    itemPrice: rate.toString(),
                                    itemImageUrl: "https://meroato.tukisoft.com.np/uploads/${state.data.serviceProviderItemsWithCategories![index].catItems![index2].coverImage}",
                                    itemId: state.data.serviceProviderItemsWithCategories![index].catItems![index2].id!,
                                    price: rate,
                                    note: '',
                                    restaurantName: state.data.serviceProvider![0].fullname!,
                                  ),
                        );
                      })),
            )
          
                    // ListView.builder(
                    //   // physics: AlwaysScrollableScrollPhysics(),
                    //   // physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   scrollDirection:Axis.horizontal,
                    //    itemCount: state.data.serviceProviderItemsWithCategories![index].catItems!.length,
                    //     itemBuilder: (BuildContext context, int index2) {
                          
                    //       int rate = state.data.serviceProviderItemsWithCategories![index].catItems![index2].sellrate!;
                    //       return Row(
                    //         mainAxisAlignment:MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             width: 140,
                    //              height: 150,
                    //             child: SearchMenuItems(
                    //               sid: state.data.serviceProviderItemsWithCategories![index].catItems![index2].sId!,
                    //               itemName: state.data.serviceProviderItemsWithCategories![index].catItems![index2].itemName!,
                    //               itemPrice: rate.toString(),
                    //               itemImageUrl: "https://meroato.tukisoft.com.np/uploads/${state.data.serviceProviderItemsWithCategories![index].catItems![index2].coverImage}",
                    //               itemId: state.data.serviceProviderItemsWithCategories![index].catItems![index2].id!,
                    //               price: rate,
                    //               note: '',
                    //               restaurantName: state.data.serviceProvider![0].fullname!,
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //       // MenuItemsCard(
                    //       //   key: UniqueKey(),
                    //       //   itemId: state.data.serviceProviderItemsWithCategories![index].catItems![index2].id!.toInt(),
                    //       //   sid: state.data.serviceProviderItemsWithCategories![index].catItems![index2].sId!,
                    //       //   itemName: state.data.serviceProviderItemsWithCategories![index].catItems![index2].itemName!,
                    //       //   price: rate,
                    //       //   imageUrl:
                    //       //       "https://meroato.tukisoft.com.np/uploads/${state.data.serviceProviderItemsWithCategories![index].catItems![index2].coverImage}",
                    //       //   restaurantName: state.data.serviceProvider![0].fullname!,
                    //       // );
                    //     })),
              
             
          ],
        );
          }
          ,
        );
        
      }
      else{
        return Container();
      }
      }
      
    );
  }
}
