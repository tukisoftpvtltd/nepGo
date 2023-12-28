import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/User/Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../Controller/bloc/Baskets/Basket_detail.dart/bloc/basket_detail_bloc.dart';
import '../../../../constants/colors.dart';
import 'view_basket.dart';
import 'widget/size_config.dart';

class BasketListTile extends StatelessWidget {
  final String sid;
  final String logoUrl;
  final String restaurantName;
  final String location;
  final int price;
  final String itemQty;
  final String openTime;
  final String closeTime;
  final double ratings;
  final List items;

  const BasketListTile(
      {super.key,
      required this.sid,
      required this.logoUrl,
      required this.restaurantName,
      required this.location,
      required this.price,
      required this.itemQty,
      required this.openTime,
      required this.closeTime,
      required this.ratings,
      required this.items});

  @override
  Widget build(BuildContext context) {
    String capitalize(String text) {
      if (text == null || text.isEmpty) {
        return text;
      }

      List<String> words = text.split(' ');
      for (int i = 0; i < words.length; i++) {
        if (words[i].isNotEmpty) {
          words[i] = words[i][0].toUpperCase() + words[i].substring(1);
        }
      }

      return words.join(' ');
    }

    final screenWidth = MediaQuery.of(context).size.width;
    
    
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: screenWidth * 1,
        height: 120,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 1.0,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/imageLoader.png',
                             image: logoUrl,
                             fit: BoxFit.fill,),
                          // Image.network(
                          //   logoUrl,
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                      Container(
                        width: 5.5 * screenWidth / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5,0,0,0),
                              child: Text(
                                capitalize(restaurantName),
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: SizeConfig(context).textSize(),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: screenWidth * 0.6,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colours.primarygreen,
                                    size: SizeConfig(context).iconSize() - 6,
                                  ),
                                  Container(
                                    width: screenWidth * 0.4,
                                    child: Text(
                                      capitalize(location),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig(context).textSize() -
                                                  4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5,0,0,0),
                              child: Text(
                                "Delivery Hours: ${openTime.replaceAll('00:00','00')} AM - ${closeTime.replaceAll('00:00','00')} PM",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig(context).textSize() - 4),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.8 * screenWidth / 10,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: SizeConfig(context).iconSize() - 4,
                              ),
                              Text(
                                "$ratings/5",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig(context).textSize() - 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
