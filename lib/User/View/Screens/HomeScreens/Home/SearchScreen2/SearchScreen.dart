import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Controller/bloc/Baskets/basket_home/basket_bloc.dart';
import '../../../../../Controller/bloc/Home/home_page/bloc/home_page_bloc.dart';
import '../../../../../Controller/bloc/Search/bloc/search_bloc.dart';
import '../../../../constants/Constants.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/BackButton2.dart';
import '../Restaurants/components/text_button.dart';
import '../SearchScreens/SearchMenuItemForSearch.dart';
import '../SearchScreens/search_items_card.dart';
import '../SearchScreens/search_menu_items.dart';
import '../SearchScreens/widget/filter_dialog.dart';
import '../SearchScreens/widget/sort_widget.dart';
import 'SearchScreenLoader.dart';

class SearchScreen extends StatefulWidget {
  Function callback;
  SearchScreen({super.key, required this.callback});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String CustomSortValue = "Best Match";
  bool _showClearIcon = false;
  bool loading = false;
  List RestroList = [];
  List GroceryList = [];
  String key = '';
  TextEditingController restaurantSearchKey = new TextEditingController();
  TextEditingController grocerySearchKey = new TextEditingController();
  TextEditingController searchController = new TextEditingController();

  int TabIndex = 0;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search();
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_handleTabChange);
  }

  _handleTabChange() {
    print("Tab Changed");

    TabIndex = _tabController!.index;
    setState(() {
      if (TabIndex == 0) {
        searchKey = restroSavedKey;
      } else {
        searchKey = grocerySavedKey;
      }
      print("The item is");
      print(searchKey);
    });
    search();
  }

  search() {
    if (TabIndex == 0) {
      BlocProvider.of<SearchBloc>(context).add(SearchLoading(
          TabIndex,
          searchKey.trimLeft(),
          bestMatch,
          topSales,
          isNew,
          openPlace,
          sortName,
          sortDistance,
          sortSales));
    }
    if (TabIndex == 1) {
      BlocProvider.of<SearchBloc>(context).add(SearchLoading(
          TabIndex,
          searchKey.trimLeft(),
          GrocerybestMatch,
          GrocerytopSales,
          GroceryisNew,
          GroceryopenPlace,
          GrocerysortName,
          GrocerysortDistance,
          GrocerysortSales));
    }
  }

  String RestroSelectedButton = 'Best Match';
  String GrocerySelectedButton = 'Best Match';
  bool bestMatch = true;
  bool topSales = false;
  bool isNew = false;
  String openPlace = 'no';
  String sortName = "null";
  String sortDistance = "null";
  String sortSales = "null";
  bool GrocerybestMatch = true;
  bool GrocerytopSales = false;
  bool GroceryisNew = false;
  String GroceryopenPlace = 'yes';
  String GrocerysortName = "null";
  String GrocerysortDistance = "null";
  String GrocerysortSales = "null";

  void handleClicked(String buttonName) {
    setState(() {
      if (TabIndex == 0) {
        RestroSelectedButton = buttonName;
      }
      if (TabIndex == 1) {
        GrocerySelectedButton = buttonName;
      }
    });
    if (TabIndex == 0) {
      if (RestroSelectedButton == 'Best Match') {
        bestMatch = true;
        topSales = false;
        isNew = false;
      }
      if (RestroSelectedButton == 'Top Sales') {
        bestMatch = false;
        topSales = true;
        isNew = false;
      }
      if (RestroSelectedButton == 'New') {
        bestMatch = false;
        topSales = false;
        isNew = true;
      }
    }
    if (TabIndex == 1) {
      if (GrocerySelectedButton == 'Best Match') {
        GrocerybestMatch = true;
        GrocerytopSales = false;
        GroceryisNew = false;
      }
      if (RestroSelectedButton == 'Top Sales') {
        GrocerybestMatch = false;
        GrocerytopSales = true;
        GroceryisNew = false;
      }
      if (RestroSelectedButton == 'New') {
        GrocerybestMatch = false;
        GrocerytopSales = false;
        GroceryisNew = true;
      }
    }

    search();
  }

  updateFilterData(
      String openRestro, String name, String distance, String sales) {
    setState(() {
      if (TabIndex == 0) {
        openPlace = openRestro;
        sortName = name;
        sortDistance = distance;
        sortSales = sales;
      }
      if (TabIndex == 1) {
        GroceryopenPlace = openRestro;
        GrocerysortName = name;
        GrocerysortDistance = distance;
        GrocerysortSales = sales;
      }
    });
    search();
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TabIndex == 0
            ? FilterDialog(
                index: TabIndex,
                restaurantSearchKey: searchKey,
                grocerySearchKey: searchKey,
                openRestaurant: openPlace,
                name: sortName,
                Distance: sortDistance,
                Sales: sortSales,
                callback: updateFilterData,
              )
            : FilterDialog(
                index: TabIndex,
                restaurantSearchKey: searchKey,
                grocerySearchKey: searchKey,
                openRestaurant: GroceryopenPlace,
                name: GrocerysortName,
                Distance: GrocerysortDistance,
                Sales: GrocerysortSales,
                callback: updateFilterData,
              );
      },
    );
  }

  String searchKey = '';
  String restroSavedKey = '';
  String grocerySavedKey = '';
  Color selectedButtonColor = Colours.primarygreen;
  Color unselectedButtonColor = Colors.black;
  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: ()async{
           widget.callback();
                  Get.back();
                  return true;
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: BackButton(
                color: Colors.black,
                onPressed: (){
                  widget.callback();
                  Get.back();
                },
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Container(
                height: 40,
                child: TextFormField(
                  controller:
                      TabIndex == 0 ? restaurantSearchKey : grocerySearchKey,
                  onChanged: (val) {
                    if (TabIndex == 0) {
                      restroSavedKey = restaurantSearchKey.text;
                    } else {
                      grocerySavedKey = grocerySearchKey.text;
                    }
                    // print("Changing");
                    if (val == '') {
                      // searchRestaurant('');
                      // searchGrocery('');
                      setState(() {
                        _showClearIcon = false;
                      });
                    } else {
                      setState(() {
                        _showClearIcon = true;
                      });
                    }
                    searchKey = val;
                    search();
                  },
                  onFieldSubmitted: (val) {
                    searchKey = val;
                    if (TabIndex == 0) {
                      restroSavedKey = restaurantSearchKey.text;
                    } else {
                      grocerySavedKey = grocerySearchKey.text;
                    }
                    search();
                    // SearchForTheKey(val);
                  },
                  decoration: InputDecoration(
                    hintText: 'What are you looking for?',
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23)),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    suffixIconConstraints:
                        BoxConstraints(minHeight: 20, minWidth: 30),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _showClearIcon
                            ? GestureDetector(
                                onTap: () {
                                  if (_showClearIcon == true && TabIndex == 0) {
                                    setState(() {
                                      restaurantSearchKey.text = '';
                                      _showClearIcon = false;
                                      //SearchForTheKey('');
                                    });
                                  }
                                  if (_showClearIcon == true && TabIndex == 1) {
                                    setState(() {
                                      grocerySearchKey.text = '';
                                      _showClearIcon = false;
                                      //SearchForTheKey('');
                                    });
                                  }
                                  print("cleared");
                                  FocusScope.of(context).unfocus();
                                  if (TabIndex == 0) {
                                    searchKey = '';
                                  } else {
                                    searchKey = '';
                                  }
                                  print("The item is");
                                  print(searchKey);
                                  search();
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              )
                            : Container(),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            if (TabIndex == 0) {
                              searchKey = restroSavedKey;
                            } else {
                              searchKey = grocerySavedKey;
                            }
                            print("The item is");
                            print(searchKey);
                            search();
                            FocusScope.of(context).unfocus();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 0.1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    // _showClearIcon
                                    //     ? Icons.clear
                                    //:
                                    Icons.search_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    //  GestureDetector(
                    //   onTap: () {
                    //     // if (_showClearIcon == true && TabIndex == 0) {
                    //     //   setState(() {
                    //     //     restaurantSearchKey.text = '';
                    //     //     _showClearIcon = false;
                    //     //     //SearchForTheKey('');
                    //     //   });
                    //     // }
                    //     // if (_showClearIcon == true && TabIndex == 1) {
                    //     //   setState(() {
                    //     //     grocerySearchKey.text = '';
                    //     //     _showClearIcon = false;
                    //     //     //SearchForTheKey('');
                    //     //   });
                    //     // }
                    //   },
                    //   child:
                    //   Opacity(
                    //     opacity: 1,
                    //     child:
                    //     Icon(Icons.clear)
                    //     //  Container(
                    //     //     width: 0,
                    //     //     decoration: BoxDecoration(
                    //     //       shape: BoxShape.circle,
                    //     //       border: Border.all(width: 0.3),
                    //     //     ),
                    //     //     child: Padding(
                    //     //       padding: const EdgeInsets.all(8.0),
                    //     //       child: Icon(
                    //     //         // _showClearIcon
                    //     //         //     ? Icons.clear
                    //     //             //:
                    //     //              Icons.search_outlined,
                    //     //         color: Colors.black,
                    //     //         size: 20,
                    //     //       ),
                    //     //     )),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
            titleSpacing: 5,
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          TabBar(
                            controller: _tabController,
                            onTap: (index) {
                              setState(() {
                                TabIndex = index;
                                if (TabIndex == 0) {
                                  searchKey = restroSavedKey;
                                } else {
                                  searchKey = grocerySavedKey;
                                }
                                search();
                              });
                            },
                            tabs: [
                              Tab(
                                child: Text(
                                  "RESTAURANTS",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth < 400 ? 13 : 15),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "GROCERIES",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenWidth < 400 ? 13 : 15),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TabIndex == 0
                                    ? Row(
                                        children: [
                                          CustomTextButton(
                                            name: 'Best Match',
                                            icon: const Icon(
                                                Icons.thumb_up_alt_outlined),
                                            handleClicked: handleClicked,
                                            nameColor: RestroSelectedButton ==
                                                    'Best Match'
                                                ? selectedButtonColor
                                                : unselectedButtonColor,
                                          ),
                                          CustomTextButton(
                                            name: 'Top Sales',
                                            icon: const Icon(
                                                Icons.favorite_outline),
                                            handleClicked: handleClicked,
                                            nameColor: RestroSelectedButton ==
                                                    'Top Sales'
                                                ? selectedButtonColor
                                                : unselectedButtonColor,
                                          ),
                                          CustomTextButton(
                                            name: 'New',
                                            icon: const Icon(
                                                Icons.watch_later_outlined),
                                            handleClicked: handleClicked,
                                            nameColor:
                                                RestroSelectedButton == 'New'
                                                    ? selectedButtonColor
                                                    : unselectedButtonColor,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          CustomTextButton(
                                            name: 'Best Match',
                                            icon: const Icon(
                                                Icons.thumb_up_alt_outlined),
                                            handleClicked: handleClicked,
                                            nameColor: GrocerySelectedButton ==
                                                    'Best Match'
                                                ? selectedButtonColor
                                                : unselectedButtonColor,
                                          ),
                                          CustomTextButton(
                                            name: 'Top Sales',
                                            icon: const Icon(
                                                Icons.favorite_outline),
                                            handleClicked: handleClicked,
                                            nameColor: GrocerySelectedButton ==
                                                    'Top Sales'
                                                ? selectedButtonColor
                                                : unselectedButtonColor,
                                          ),
                                          CustomTextButton(
                                            name: 'New',
                                            icon: const Icon(
                                                Icons.watch_later_outlined),
                                            handleClicked: handleClicked,
                                            nameColor:
                                                GrocerySelectedButton == 'New'
                                                    ? selectedButtonColor
                                                    : unselectedButtonColor,
                                          ),
                                        ],
                                      ),
                                GestureDetector(
                                  onTap: () {
                                    showFilterDialog(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Filter',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenWidth < 400 ? 10 : 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Icon(Icons.filter_alt_outlined,
                                          color: Colors.black,
                                          size: screenWidth < 400 ? 16 : 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            height: 0,
                          ),
      
                          // Text("Input"),
                          // Text("TabIndex $TabIndex"),
                          // Text("Search Key $searchKey"),
                          // Text("Restro Best Match  " + bestMatch.toString() + "Grocery Best Match"+GrocerybestMatch.toString()),
                          // Text("Top Sales  "+ topSales.toString()),
                          // Text("New  "+isNew.toString()),
                          // Text("open place  "+openPlace.toString()),
                          // Text("name  "+sortName),
                          // Text("distance  "+sortDistance),
                          // Text("sales  "+sortSales),
      
                          BlocBuilder<BasketBloc, BasketState>(
                            builder: (context, state) {
                              return BlocBuilder<SearchBloc, SearchState>(
                                builder: (context, state) {
                                  if (state is SearchLoadingState) {
                                    return Container(
                                      height: screenHeight,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          for (int i = 0; i < 10; i++)
                                            SearchPageLoader()
                                        ],
                                      ),
                                    );
                                  }
                                  if (state is SearchLoadedState) {
                                    if (TabIndex == 0) {
                                      return ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Container(
                                            width: screenWidth,
                                            height: screenHeight,
                                            child: TabBarView(
                                              controller: _tabController,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 0.0),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  screenHeight -
                                                                      180,
                                                              child: state.searchData
                                                                          .length ==
                                                                      0
                                                                  ? Center(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                160,
                                                                          ),
                                                                          Opacity(
                                                                              opacity:
                                                                                  0.4,
                                                                              child: Container(
                                                                                  height: 120,
                                                                                  width: 120,
                                                                                  child: Image.asset('assets/images/search-cross.png'))),
                                                                          SizedBox(
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          Text(
                                                                              "Sorry! No search results found"),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : ListView
                                                                      .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount: state
                                                                          .searchData
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return SearchItemsCard(
                                                                            sid: state.searchData[index]
                                                                          [
                                                                          's_id'],
                                                                            restaurantName:
                                                                          capitalize(state.searchData[index]['fullname']),
                                                                            location:
                                                                          state.searchData[index]['address'],
                                                                            logoUrl:
                                                                          "$baseUrl/serviceproviderprofile/${state.searchData[index]['logo']}",
                                                                            ratings:
                                                                          state.searchData[index]['average_rating'],
                                                                            distance:
                                                                          state.searchData[index]['distance'],
                                                                          openTime:state.searchData[index]['openingTime'].toString().replaceAll('00:00', '00'),
                                                                          closeTime:state.searchData[index]['closingTime'].toString().replaceAll('00:00', '00'),
                                                                            row:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            height: 800,
                                                                            child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                              itemCount: state.searchData[index]['TopPickItems'].length,
                                                                              itemBuilder: (context, index2) {
                                                                                return Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    SearchMenuItemsForSearch(
                                                                                      sid: state.searchData[index]['s_id'],
                                                                                      itemId: state.searchData[index]['TopPickItems'][index2]['id'],
                                                                                      price: state.searchData[index]['TopPickItems'][index2]['sellrate'],
                                                                                      note: '',
                                                                                      restaurantName: state.searchData[index]['TopPickItems'][index2]['item_name'],
                                                                                      itemName: state.searchData[index]['TopPickItems'][index2]['item_name'],
                                                                                      itemImageUrl: "https://meroato.tukisoft.com.np/uploads/${state.searchData[index]['TopPickItems'][index2]['cover_image']}",
                                                                                      itemPrice: state.searchData[index]['TopPickItems'][index2]['sellrate'].toString(),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                            ),
                                                                          );
                                                                      },
                                                                    ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container()
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Container(
                                            width: screenWidth,
                                            height: screenHeight,
                                            child: TabBarView(
                                              controller: _tabController,
                                              children: [
                                                Container(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 0.0),
                                                  child: ListView(children: [
                                                    Container(
                                                      height: screenHeight - 180,
                                                      child:
                                                          state.searchData
                                                                      .length ==
                                                                  0
                                                              ? Center(
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            160,
                                                                      ),
                                                                      Opacity(
                                                                          opacity:
                                                                              0.4,
                                                                          child: Container(
                                                                              height:
                                                                                  120,
                                                                              width:
                                                                                  120,
                                                                              child:
                                                                                  Image.asset('assets/images/search-cross.png'))),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          "Sorry! No search results found"),
                                                                    ],
                                                                  ),
                                                                )
                                                              : ListView.builder(
                                                                  itemCount: state
                                                                      .searchData
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return SearchItemsCard(
                                                                      sid: state.searchData[
                                                                              index]
                                                                          [
                                                                          's_id'],
                                                                      restaurantName:
                                                                          state.searchData[index]
                                                                              [
                                                                              'fullname'],
                                                                      location: state
                                                                              .searchData[index]
                                                                          [
                                                                          'address'],
                                                                      logoUrl:
                                                                          "$baseUrl/serviceproviderprofile/${state.searchData[index]['logo']}",
                                                                      ratings: state
                                                                              .searchData[index]
                                                                          [
                                                                          'average_rating'],
                                                                      distance: state
                                                                              .searchData[index]
                                                                          [
                                                                          'distance'],
                                                                      openTime:state.searchData[index]['openingTime'].toString().replaceAll('00:00', '00'),
                                                                      closeTime:state.searchData[index]['closingTime'].toString().replaceAll('00:00', '00'),
                                                                      row: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                800,
                                                                            child:
                                                                                ListView.builder(
                                                                              shrinkWrap:
                                                                                  true,
                                                                              scrollDirection:
                                                                                  Axis.horizontal,
                                                                              itemCount:
                                                                                  state.searchData[index]['TopPickItems'].length,
                                                                              itemBuilder:
                                                                                  (context, index2) {
                                                                                return Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    BlocProvider(
                                                                                      create: (context) => BasketBloc(),
                                                                                      child: SearchMenuItemsForSearch(
                                                                                        sid: state.searchData[index]['s_id'],
                                                                                        itemId: state.searchData[index]['TopPickItems'][index2]['id'],
                                                                                        price: state.searchData[index]['TopPickItems'][index2]['sellrate'],
                                                                                        note: '',
                                                                                        restaurantName: state.searchData[index]['TopPickItems'][index2]['item_name'],
                                                                                        itemName: state.searchData[index]['TopPickItems'][index2]['item_name'],
                                                                                        itemImageUrl: "https://meroato.tukisoft.com.np/uploads/${state.searchData[index]['TopPickItems'][index2]['cover_image']}",
                                                                                        itemPrice: state.searchData[index]['TopPickItems'][index2]['sellrate'].toString(),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                    ),
                                                  ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  } else {
                                    return Container(
                                      width: screenWidth,
                                      height: screenHeight - 400,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colours.primarygreen,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
