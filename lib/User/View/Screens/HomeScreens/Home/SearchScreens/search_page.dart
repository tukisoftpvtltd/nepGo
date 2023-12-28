// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/User/Controller/bloc/Home/home_navigation/home_navigation_bloc.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../Controller/bloc/Account/sign_in/bloc/sign_in_bloc.dart';
// import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
// import '../../../../../Controller/repositories/search/search_repository.dart';
// import '../../../../constants/Constants.dart';
// import '../../../../constants/colors.dart';
// import '../HomeScreensNavigation.dart';
// import 'search_items_card.dart';
// import 'search_menu_items.dart';
// import 'widget/sort_widget.dart';

// class SearchPage extends StatefulWidget {
//   final String restaurantSearchTerm;
//   final String grocerySearchTerm;
//   int index;
//   final bool bestMatch;
//   final bool TopSales;
//   final bool isNew;
//   final String openRestaurant;
//   final String name;
//   final String Distance;
//   final String Sales;

//   SearchPage({
//     Key? key,
//     required this.restaurantSearchTerm,
//     required this.grocerySearchTerm,
//     required this.index,
//     required this.bestMatch,
//     required this.TopSales,
//     required this.isNew,
//     required this.openRestaurant,
//     required this.name,
//     required this.Distance,
//     required this.Sales,
//   }) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage>
//     with SingleTickerProviderStateMixin {
//   bool loading = false;
//   List RestroList = [];
//   List GroceryList = [];
//   String key = '';

//   int TabIndex = 0;

//   SearchForTheKey(String Key) {
//     if (TabIndex == 0) {
//       searchRestaurant(Key);
//     }
//     if (TabIndex == 1) {
//       searchGrocery(Key);
//     }
//   }

//   searchRestaurant(String searchKey) async {
//     setState(() {
//       RestroList = [];
//       loading = true;
//       key = searchKey;
//     });
//     SharedPreferences _locationDetail = await SharedPreferences.getInstance();
//     String? latitude = _locationDetail.getString('latitude');
//     String? longitude = _locationDetail.getString('longitude');
//     SearchPageRepository repo = SearchPageRepository();
//     SearchResponse? response;
//     if (widget.bestMatch == true) {
//       response =
//           await repo.getSearchData(searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("1");
//     } else if (widget.isNew == true) {
//       response = await repo.getSearchDataOrderByNewlyCreated(
//           searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("2");
//     } else if (widget.isNew == false &&
//         widget.name == "null" &&
//         widget.Distance == 'null' &&
//         widget.Sales == "null") {
//       response =
//           await repo.getSearchData(searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("3");
//     } else if (widget.name == "ASC" &&
//         widget.Distance == "null" &&
//         widget.Sales == "null") {
//       response = await repo.getSearchDataOrderByNameASC(
//           searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("4");
//     } else if (widget.name == "DESC" &&
//         widget.Distance == "null" &&
//         widget.Sales == "null") {
//       response = await repo.getSearchDataOrderByNameDESC(
//           searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("5");
//     } else if (widget.name == "null" &&
//         widget.Distance == 'ASC' &&
//         widget.Sales == "null") {
//       response = await repo.getSearchDataOrderByDistance(
//           searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("6");
//     } else if (widget.name == "null" &&
//         widget.Distance == 'null' &&
//         widget.Sales == "ASC") {
//       response =
//           await repo.getSearchData(searchKey, "1", latitude!, longitude!,widget.openRestaurant);
//       print("1");
//     }
//     var data = jsonDecode(response!.body);
//     List restro = data['serviceProvider'];
//     List itemList = data['itemsWithServieProviders'];
//     int restroLength = restro.length;
//     if (searchKey == '') {
//       key = "null";
//     } else {
//       key = searchKey;
//     }
//     for (int k = 0; k < itemList.length; k++) {
//       for (int i = 0; i < restroLength; i++) {
//         if (restro[i]['fullname'].contains(key) &&
//             itemList[k]['fullname'].contains(key)) {
//           restro.removeAt(i);
//         }
//       }
//     }
//     RestroList.addAll(restro);
//     RestroList.addAll(itemList);
//     setState(() {
//       //restaurantSearchKey.text = searchKey;
//       loading = false;
//     });
//   }

//   searchGrocery(String searchKey) async {
//     setState(() {
//       GroceryList = [];
//       loading = true;
//       key = searchKey;
//     });
//     SharedPreferences _locationDetail = await SharedPreferences.getInstance();
//     String? latitude = _locationDetail.getString('latitude');
//     String? longitude = _locationDetail.getString('longitude');
//     SearchPageRepository repo = SearchPageRepository();
//     SearchResponse? response;
//     print("The name is");
//     print(widget.name);
//     if (widget.bestMatch == true) {
//       response =
//           await repo.getSearchData(searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("1");
//     } else if (widget.isNew == true) {
//       response = await repo.getSearchDataOrderByNewlyCreated(
//           searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("2");
//     } else if (widget.isNew == false &&
//         widget.name == "null" &&
//         widget.Distance == 'null' &&
//         widget.Sales == "null") {
//       response =
//           await repo.getSearchData(searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("3");
//     } else if (widget.name == "ASC" &&
//         widget.Distance == "null" &&
//         widget.Sales == "null") {
//       response = await repo.getSearchDataOrderByNameASC(
//           searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("4");
//     } else if (widget.name == "DESC" &&
//         widget.Distance == "null" &&
//         widget.Sales == "null") {
//       response = await repo.getSearchDataOrderByNameDESC(
//           searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("5");
//     } else if (widget.name == "null" &&
//         widget.Distance == 'ASC' &&
//         widget.Sales == "null") {
//       response = await repo.getSearchDataOrderByDistance(
//           searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("6");
//     } else if (widget.name == "null" &&
//         widget.Distance == 'null' &&
//         widget.Sales == "ASC") {
//       response =
//           await repo.getSearchData(searchKey, "2", latitude!, longitude!,widget.openRestaurant);
//       print("7");
//     }
//     var data = jsonDecode(response!.body);
//     List grocery = data['serviceProvider'];
//     List itemList = data['itemsWithServieProviders'];
//     int groceryLength = grocery.length;
//     if (searchKey == '') {
//       key = "null";
//       print("Search key is empty");
//     } else {
//       key = searchKey;
//     }
//     for (int k = 0; k < itemList.length; k++) {
//       for (int i = 0; i < groceryLength; i++) {
//         if (grocery[i]['fullname'].contains(key) &&
//             itemList[k]['fullname'].contains(key)) {
//           grocery.removeAt(i);
//         }
//       }
//     }
//     GroceryList.addAll(grocery);
//     GroceryList.addAll(itemList);
//     setState(() {
//       loading = false;
//     });
//   }

//   TextEditingController restaurantSearchKey = new TextEditingController();
//   TextEditingController grocerySearchKey = new TextEditingController();
//   TextEditingController searchController = new TextEditingController();

//   String capitalize(String text) {
//     if (text == null || text.isEmpty) {
//       return text;
//     }

//     List<String> words = text.split(' ');
//     for (int i = 0; i < words.length; i++) {
//       if (words[i].isNotEmpty) {
//         words[i] = words[i][0].toUpperCase() + words[i].substring(1);
//       }
//     }

//     return words.join(' ');
//   }

//   // TabController tabBarController;
//   String CustomSortValue = "Best Match";
//   bool _showClearIcon = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     restaurantSearchKey.text = widget.restaurantSearchTerm;
//     grocerySearchKey.text = widget.grocerySearchTerm;
//     _tabController =
//         TabController(length: 2, vsync: this, initialIndex: widget.index);
//     setState(() {
//       TabIndex = widget.index;
//       if (widget.bestMatch == true) {
//         CustomSortValue = "Best Match";
//       }
//       if (widget.TopSales == true) {
//         CustomSortValue = "Top Sales";
//       }
//       if (widget.isNew == true) {
//         CustomSortValue = "New";
//       }
//     });
//     searchRestaurant(restaurantSearchKey.text);
//     searchGrocery(grocerySearchKey.text);
//     searchController.text = '';
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   TabController? _tabController;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 60,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 9.0, bottom: 0),
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 0.5,
//                 ),
//               ),
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back_rounded,
//                   color: Colors.black,
//                   size: 32,
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//               ),
//             ),
//           ),
//           title: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//             child: TextFormField(
//               controller:
//                   TabIndex == 0 ? restaurantSearchKey : grocerySearchKey,
//               onChanged: (val) {
//                 if (val == '') {
//                   searchRestaurant('');
//                   searchGrocery('');
//                   setState(() {
//                     _showClearIcon = false;
//                   });
//                 } else {
//                   setState(() {
//                     _showClearIcon = true;
//                   });
//                 }
//               },
//               onFieldSubmitted: (val) {
//                 SearchForTheKey(val);
//               },
//               decoration: InputDecoration(
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(23)),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     if (_showClearIcon == true && TabIndex == 0) {
//                       setState(() {
//                         restaurantSearchKey.text = '';
//                         _showClearIcon = false;
//                         SearchForTheKey('');
//                       });
//                     }
//                     if (_showClearIcon == true && TabIndex == 1) {
//                       setState(() {
//                         grocerySearchKey.text = '';
//                         _showClearIcon = false;
//                         SearchForTheKey('');
//                       });
//                     }
//                   },
//                   child: Opacity(
//                     opacity: 0.5,
//                     child: Container(
//                         width: 0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 0.3),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Icon(
//                             _showClearIcon
//                                 ? Icons.clear
//                                 : Icons.search_outlined,
//                             color: Colors.black,
//                             size: 25,
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           titleSpacing: 5,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             color: Colors.white,
//             height: screenHeight,
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     const Divider(
//                       thickness: 1.5,
//                     ),
//                     TabBar(
//                       controller: _tabController,
//                       onTap: (index) {
//                         setState(() {
//                           TabIndex = index;
//                         });
//                       },
//                       tabs: [
//                         Tab(
//                           child: Text(
//                             "RESTAURANTS",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: screenWidth < 400 ? 13 : 15),
//                           ),
//                         ),
//                         Tab(
//                           child: Text(
//                             "GROCERIES",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: screenWidth < 400 ? 13 : 15),
//                           ),
//                         ),
//                       ],
//                     ),
//                     CustomSort(
//                         CustomSortValue: CustomSortValue,
//                         index: TabIndex,
//                         restaurantSearchKey: restaurantSearchKey.text,
//                         grocerySearchKey: grocerySearchKey.text,
//                         openRestaurant: widget.openRestaurant,
//                         name: widget.name,
//                         Distance: widget.Distance,
//                         Sales: widget.Sales),
//                     const Divider(
//                       thickness: 1.5,
//                     ),
//                     loading == true
//                         ? Container(
//                             width: screenWidth,
//                             height: screenHeight,
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 color: Colours.primarygreen,
//                               ),
//                             ),
//                           )
//                         : SingleChildScrollView(
//                             child: Container(
//                               width: screenWidth,
//                               height: screenHeight,
//                               child: TabBarView(
//                                 controller: _tabController,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8.0),
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 height: screenHeight - 250,
//                                                 child: ListView.builder(
//                                                   shrinkWrap: true,
//                                                   itemCount: RestroList.length,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     return SearchItemsCard(
//                                                       sid: RestroList[index]
//                                                           ['s_id'],
//                                                       restaurantName:
//                                                           capitalize(
//                                                               RestroList[index]
//                                                                   ['fullname']),
//                                                       location:
//                                                           RestroList[index]
//                                                               ['address'],
//                                                       logoUrl:
//                                                           "$baseUrl/serviceproviderprofile/${RestroList[index]['logo']}",
//                                                       ratings: RestroList[index]
//                                                           ['average_rating'],
//                                                           distance: RestroList[index]
//                                                           ['distance'],
//                                                       row: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Container(
//                                                             height: 800,
//                                                             child: ListView
//                                                                 .builder(
//                                                               shrinkWrap: true,
//                                                               scrollDirection:
//                                                                   Axis.horizontal,
//                                                               itemCount: RestroList[
//                                                                           index]
//                                                                       [
//                                                                       'TopPickItems']
//                                                                   .length,
//                                                               itemBuilder:
//                                                                   (context,
//                                                                       index2) {
//                                                                 return Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     SearchMenuItems(
//                                                                       sid: RestroList[index]['s_id'],
//                                                                        itemId:RestroList[index]
//                                                                               [
//                                                                               'TopPickItems']
//                                                                           [
//                                                                           index2]
//                                                                       [
//                                                                       'id'],
//                                                               price:RestroList[index]
//                                                                               [
//                                                                               'TopPickItems']
//                                                                           [
//                                                                           index2]
//                                                                       [
//                                                                       'sellrate'],
//                                                               note:'',
//                                                                       restaurantName:
//                                                                           RestroList[index]['TopPickItems'][index2]
//                                                                               [
//                                                                               'item_name'],
//                                                                       itemName: RestroList[index]['TopPickItems']
//                                                                               [
//                                                                               index2]
//                                                                           [
//                                                                           'item_name'],
//                                                                       itemImageUrl:
//                                                                           "https://meroato.tukisoft.com.np/uploads/${RestroList[index]['TopPickItems'][index2]['cover_image']}",
//                                                                       itemPrice:
//                                                                           RestroList[index]['TopPickItems'][index2]
//                                                                               [
//                                                                               'sellrate'],
//                                                                     ),
//                                                                   ],
//                                                                 );
//                                                               },
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 0.0),
//                                     child: ListView(children: [
//                                       Container(
//                                         height: screenHeight - 250,
//                                         child: ListView.builder(
//                                           itemCount: GroceryList.length,
//                                           shrinkWrap: true,
//                                           itemBuilder: (context, index) {
//                                             return SearchItemsCard(
//                                               sid: GroceryList[index]['s_id'],
//                                               restaurantName: GroceryList[index]
//                                                   ['fullname'],
//                                               location: GroceryList[index]
//                                                   ['address'],
//                                               logoUrl:
//                                                   "$baseUrl/serviceproviderprofile/${GroceryList[index]['logo']}",
//                                               ratings: GroceryList[index]
//                                                   ['average_rating'],
//                                                   distance: GroceryList[index]
//                                                   ['distance'],
//                                               row: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     height: 1000,
//                                                     child: ListView.builder(
//                                                       shrinkWrap: true,
//                                                       scrollDirection:
//                                                           Axis.horizontal,
//                                                       itemCount: GroceryList[
//                                                                   index]
//                                                               ['TopPickItems']
//                                                           .length,
//                                                       itemBuilder:
//                                                           (context, index2) {
//                                                         return Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             SearchMenuItems(
//                                                               sid: GroceryList[index]['s_id'],
//                                                               itemId:GroceryList[index]
//                                                                               [
//                                                                               'TopPickItems']
//                                                                           [
//                                                                           index2]
//                                                                       [
//                                                                       'id'],
//                                                               price:GroceryList[index]
//                                                                               [
//                                                                               'TopPickItems']
//                                                                           [
//                                                                           index2]
//                                                                       [
//                                                                       'sellrate'],
//                                                               note:'',
//                                                               restaurantName:
//                                                                   GroceryList[index]
//                                                                               [
//                                                                               'TopPickItems']
//                                                                           [
//                                                                           index2]
//                                                                       [
//                                                                       'item_name'],
//                                                               itemName: GroceryList[
//                                                                           index]
//                                                                       [
//                                                                       'TopPickItems']
//                                                                   [
//                                                                   index2]['item_name'],
//                                                               itemImageUrl:
//                                                                   "https://meroato.tukisoft.com.np/uploads/${GroceryList[index]['TopPickItems'][index2]['cover_image']}",
//                                                               itemPrice: GroceryList[
//                                                                           index]
//                                                                       [
//                                                                       'TopPickItems']
//                                                                   [
//                                                                   index2]['sellrate'],
//                                                             ),
//                                                           ],
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ]),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
