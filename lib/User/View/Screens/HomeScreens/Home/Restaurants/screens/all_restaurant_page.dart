import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/screens/all_restaurant_loader.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/screens/view_restaurant.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../Controller/Functions/convertMilestoKm.dart';
import '../../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../../Controller/bloc/Search/bloc/search_bloc.dart';
import '../../../../../constants/Constants.dart';
import '../../../../../constants/colors.dart';
import '../../../../../widgets/BackButton2.dart';
import '../../SearchScreens/search_items_card.dart';
import '../../SearchScreens/search_menu_items.dart';
import '../../SearchScreens/widget/filter_dialog.dart';
import '../components/restaurant_card.dart';
import '../components/text_button.dart';


class AllRestaurantPage extends StatefulWidget {
  int tabValue;
  Function callback;
  AllRestaurantPage({super.key,
  required this.tabValue,
  required this.callback});

  @override
  State<AllRestaurantPage> createState() => _AllRestaurantPageState();
}

class _AllRestaurantPageState extends State<AllRestaurantPage>with SingleTickerProviderStateMixin {
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

  int TabIndex = 1;
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
    TabIndex = widget.tabValue;
    // TODO: implement initState
    super.initState();
    search();
    _tabController = TabController(length: 1, vsync: this);
    _tabController?.addListener(_handleTabChange);
  }
  _handleTabChange(){
    print("Tab Changed");
    TabIndex =_tabController!.index; 
    search();
  }
  search(){
    BlocProvider.of<SearchBloc>(context).add(
        SearchLoading(TabIndex,
         searchKey,
          bestMatch,
           topSales,
            isNew,
             openPlace,
              sortName,
               sortDistance,
                sortSales));
  }
  

  String selectedButton = 'Best Match';
  bool bestMatch = true;
  bool topSales = false;
  bool isNew = false;
  String openPlace = 'no';
  String sortName = "null";
  String sortDistance = "null";
  String sortSales = "null";
  void handleClicked(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
    if (selectedButton == 'Best Match') {
      bestMatch = true;
      topSales = false;
      isNew = false;
    }
    if (selectedButton == 'Top Sales') {
      bestMatch = false;
      topSales = true;
      isNew = false;
    }
    if (selectedButton == 'New') {
      bestMatch = false;
      topSales = false;
      isNew = true;
    }
    search();
  }

  updateFilterData(
      String openRestro, String name, String distance, String sales) {
    setState(() {
      openPlace = openRestro;
      sortName = name;
      sortDistance = distance;
      sortSales = sales;
    });
    search();
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FilterDialog(
              index: TabIndex,
              restaurantSearchKey: searchKey,
              grocerySearchKey: searchKey,
              openRestaurant: openPlace,
              name: sortName,
              Distance: sortDistance,
              Sales: sortSales,
              callback: updateFilterData,
            );
          },
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
      length: 1,
      child: Scaffold(
        backgroundColor: Color(0XFFF3F3F3),
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: (){
                  widget.callback();
                  Get.back();
          }
        ),
        title: TabIndex == 0 ? Text(
          'Restaurants',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        )
        :
        Text(
          'Groceries',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        )
        ,
      ),
      body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  children: [
                    const Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomTextButton(
                                name: 'Best Match',
                                icon: const Icon(Icons.thumb_up_alt_outlined),
                                handleClicked: handleClicked,
                                nameColor: selectedButton == 'Best Match'
                                    ? selectedButtonColor
                                    : unselectedButtonColor,
                              ),
                              CustomTextButton(
                                name: 'Top Sales',
                                icon:  Icon( FontAwesomeIcons.arrowUp,
                                color: Colors.red,
                                size: 4,),
                                handleClicked: handleClicked,
                                nameColor: selectedButton == 'Top Sales'
                                    ? selectedButtonColor
                                    : unselectedButtonColor,
                              ),
                              CustomTextButton(
                                name: 'New',
                                icon: const Icon(Icons.watch_later_outlined),
                                handleClicked: handleClicked,
                                nameColor: selectedButton == 'New'
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
                          )
                        ],
                      ),
                    ),
                    // Divider(
                    //   thickness: 0.5,
                    //   height: 1,
                    // ),
                    // Text("Input"),
                    // Text("TabIndex $TabIndex"),
                    // Text("Search Key $searchKey"),
                    // Text("Best Match  " + bestMatch.toString()),
                    // Text("Top Sales  "+ topSales.toString()),
                    // Text("New  "+isNew.toString()),
                    // Text("open place  "+openPlace.toString()),
                    // Text("name  "+sortName),
                    // Text("distance  "+sortDistance),
                    // Text("sales  "+sortSales),
                    
                    BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if(state is SearchLoadingState){
                                 return AllRestroLoader();

                                //  Container(
                                //    height: screenHeight-150,
                                //    child: ListView.builder(
                                //     shrinkWrap: true,
                                //     itemCount: 3,
                                //     itemBuilder: (context ,index){
                                //       return  Shimmer.fromColors(
                                //        baseColor: Colors.grey.shade300,
                                //        highlightColor: Colors.grey.shade100,
                                //        child: Padding(
                                //          padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                //          child: Container(
                                //            width: screenWidth,
                                //            height: 250,
                                //            color: Colors.white,
                                //          ),
                                //        ),
                                //      );
                                //     }
                                     
                                      
                                     
                                //    ),
                                //  );
                              }
                              if(state is SearchLoadedState){
                                
                                return 
                                SingleChildScrollView(
                                  
                        child: Container(
                          width: screenWidth,
                          height: screenHeight-150,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                             
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Divider(
                      thickness: 0.5,
                      height: 1,
                    ),
                                      Column(
                                        children: [
                                          Container(
                                            color: Color(0XFFF3F3F3),
                                            height:  screenHeight-150,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.searchData.length,
                                              itemBuilder:
                                                  (context, index) {
                                                return 
                                                RestaurantCard(
                            logoUrl:
                                 "$baseUrl/serviceproviderprofile/${state.searchData[index]['logo']}"
                                ,
                            handleClicked: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            ServiceProviderDetailBloc(),
                                        child: ViewRestautant(
                                          sid: state.searchData[index]['s_id'],
                                        ),
                                      )));
                            },
                            imageUrl:
                                "$baseUrl/serviceproviderprofile/${state.searchData[index]['banner'] ??"1687685186376.jpg"}",
                            distance: milesToKilometers(state.searchData[index]['distance']),
                            location: state.searchData[index]['address'],
                            name: state.searchData[index]['fullname'],
                            rating: state.searchData[index]['average_rating'],
                            time: state.searchData[index]['openingTime'].toString().replaceAll('00:00','00')
                            +' to '
                            + state.searchData[index]['closingTime'].toString().replaceAll('00:00','00'));
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                              
                              }
                              else{
                                 return AllRestroLoader();
                              }
                              
                            },
                          )
                          
                    
                  ],
                ),
              ],
            ),
          ),
        
      ),
    );
  }
}
