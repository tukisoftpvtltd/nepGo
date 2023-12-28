import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/User/View/custome_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Controller/repositories/get_your_favorite.dart';
import '../../../../../Controller/repositories/remove_from_favorite.dart';
import '../../../../constants/Constants.dart';
import '../../../../constants/colors.dart';
import '../../Baskets/Basket/widget/size_config.dart';
import 'favorite_list_tile.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyFavoriteList();
  }

  List favoriteList = [];
  getMyFavoriteList() async {
    GetYourFavoriteRepository favList = new GetYourFavoriteRepository();
      SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
    GetfavoriteResponse? res = await favList.getFavoriteList(userId!);
    var data = jsonDecode(res!.body);
    setState(() {
      favoriteList = data['favouriteServiceProvider'];
       print(favoriteList);
    loading= false;
    });
  }
   RemoveFromFavorite(String sid) async {
    print(sid);
    RemoveFromFavoriteRepository removeFromFav = new RemoveFromFavoriteRepository ();
     SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
     RemoveFromFavoriteResponse res = await removeFromFav.RemoveFromFavorite(userId!, sid);
     print(res.statusCode);
     print(res.body);
     getMyFavoriteList();
    
  }
  callback()async{
    print("Fav List Updated");
    GetYourFavoriteRepository favList = new GetYourFavoriteRepository();
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData .getString('user_id');
    GetfavoriteResponse? res = await favList.getFavoriteList("1");
    var data = jsonDecode(res!.body);
    setState(() {
      favoriteList = data['favouriteServiceProvider'];
       print(favoriteList);
    loading= false;

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Container(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          'My Favorites',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig(context).titleSize(),
          ),
        ),
      ),
      body: loading == true?
    CustomeLoader()
    :RefreshIndicator(
        color: Colours.primarygreen,
        onRefresh: (){
          getMyFavoriteList();
          return Future.delayed(Duration(seconds: 1));
        },
        child:
        favoriteList.length ==0? 
        Container(
          height: screenHeight-200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
            Center(
              child: Text(
                "You have not selected any favorite restaurant or groceries",
                textAlign: TextAlign.center,),
            )
          ]),
        )
        :ListView.builder(
          
          shrinkWrap: true,
          itemCount: favoriteList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              color: Color(0xffF3F3F3),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                
            
                children: [
                  FavoriteListTile(
                    callback:callback,
                      sid: favoriteList[index]['s_id'],
                      logoUrl:'$baseUrl/serviceproviderprofile/' +
                              favoriteList[index]['logo'],
                      restaurantName: favoriteList[index]['fullname'],
                      location: favoriteList[index]['address'],
                      price: 0,
                      itemQty: '',
                      openTime: favoriteList[index]['openingTime'],
                      closeTime: favoriteList[index]['closingTime'],
                      ratings: favoriteList[index]['average_rating'],
                    ),
                     GestureDetector(
                      onTap: (){
                        setState(() {
                          loading= true;
                         RemoveFromFavorite(favoriteList[index]['s_id']);                          
                         });
                      },
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                            width: 80,
                            height: 80,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                       ),
                     ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
