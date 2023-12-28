import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../Controller/Functions/UserStatus.dart';
import '../../../../../../../Controller/Functions/capitalize.dart';
import '../../../../../../../Controller/bloc/Home/service_provider_detail/bloc/service_provider_detail_bloc.dart';
import '../../../../../../../Controller/repositories/add_review.dart';
import '../../../../../../../Controller/repositories/add_to_favorite.dart';
import '../../../../../../../Controller/repositories/remove_from_favorite.dart';
import '../../../../../../constants/Constants.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../custome_loader.dart';
import '../../../../../../widgets/BackButton2.dart';
import '../../Restaurant_Map.dart';
import '../../components/menu_expansion.dart';
import '../../components/ratings.dart';
import '../../components/review_card.dart';
import '../../view_restaurant_loader.dart';

class MyHomePage extends StatefulWidget {
  final String sid;
  MyHomePage({
    required this.sid,
    Key? key,
  }) : super(
          key: key,
        );
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  TabController? _tabController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  int rate = 1;
  void _showReviewDialog(BuildContext context) {
    AddReview(String title, String reviewText, int rate) async {
      SharedPreferences userData = await SharedPreferences.getInstance();
      String? userId = userData.getString('user_id');
      AddReviewRepository review = new AddReviewRepository();
      AddReviewResponse response =
          await review.AddReview(userId!, widget.sid, title, reviewText, rate);
      print(response.body);

      BlocProvider.of<ServiceProviderDetailBloc>(context)
          .add(OnServiceProviderDetailLoading(widget.sid));
      Get.back();
      // Get.off(BlocProvider(
      //   create: (context) => ServiceProviderDetailBloc(),
      //   child: ViewRestautant(sid: widget.sid),
      // ));
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: const Center(child: Text('Write a Review')),
          content: Container(
            width: screenWidth < 400 ? screenWidth / 1.5 : screenWidth / 1.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ratings:',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFFF7F09),
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating.toInt();
                        });
                      },
                    ),
                  ],
                ),
                Text("Title"),
                Container(
                  height: 50,
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                TextFormField(
                  maxLines: 3,
                  controller: _reviewController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    width: screenWidth / 3.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFFFF0909),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    width: screenWidth / 3.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_titleController.text == '' ||
                            _reviewController.text == '') {
                          Fluttertoast.showToast(
                            msg: "Please provide a full review",
                            toastLength:
                                Toast.LENGTH_SHORT, // Duration of the toast
                            gravity: ToastGravity.BOTTOM, // Toast position
                            timeInSecForIosWeb: 1, // Time duration for iOS
                            backgroundColor: Colors.black54, // Background color
                            textColor: Colors.white, // Text color
                            fontSize: 16.0, // Font size
                          );
                        } else {
                          AddReview(_titleController.text,
                              _reviewController.text, rate);
                          _titleController.clear();
                          _reviewController.clear();
                          //Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFF0DAD6A),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  bool loading = true;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  double scrollPercentage = 0.0;
  bool showAppBar = false;
  double screenHeight = 0;
  @override
  void initState() {
    super.initState();
    getUserId();
    BlocProvider.of<ServiceProviderDetailBloc>(context)
        .add(OnServiceProviderDetailLoading(widget.sid));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(context);
      _listenForScrollChanges();
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  String? userId;
  getUserId() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    userId = userData.getString('user_id');
  }

  String? userLoginStatus;
  getUserStatus() async {
    userLoginStatus = await isUserLoggedIn();
  }

  RemoveFromFavorite(String sid) async {
    setState(() {
      loader = true;
    });
    RemoveFromFavoriteRepository removeFromFav =
        new RemoveFromFavoriteRepository();
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData.getString('user_id');
    userLoginStatus = await isUserLoggedIn();

    if (userLoginStatus != 'true') {
      Fluttertoast.showToast(
        msg: 'Log in to add to favorite',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      RemoveFromFavoriteResponse res =
          await removeFromFav.RemoveFromFavorite(userId!, sid);
      toggleFavorite();
      // ShowCustomSnackBar(context,'Removed from favorite');
      Fluttertoast.showToast(
        msg: 'Removed from favorite',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    setState(() {
      // BlocProvider.of<ServiceProviderDetailBloc>(context)
      //     .add(OnServiceProviderDetailLoading(widget.sid));
      isFavorite = false;
      loader = false;
    });
  }

  double? latitude;
  double? longitude;
  AddToFavorite(String sid) async {
    setState(() {
      loader = true;
    });
    AddToFavoriteRepository addToFav = new AddToFavoriteRepository();
    SharedPreferences userData = await SharedPreferences.getInstance();
    String? userId = userData.getString('user_id');
    print(userId);
    if (userId == null) {
      Fluttertoast.showToast(
        msg: 'Log in to add to favorite',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      AddToFavoriteResponse res = await addToFav.AddToFavorite(userId!, sid);
      toggleFavorite();
      Fluttertoast.showToast(
        msg: 'Added to favorite',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isFavorite = true;
      });
    }
    setState(() {
      // BlocProvider.of<ServiceProviderDetailBloc>(context)
      //     .add(OnServiceProviderDetailLoading(widget.sid));
      loader = false;
    });
  }

  bool loader = false;
  bool loadingFirstTime = true;
  ScrollController _scrollController = ScrollController();

  bool showText = false;
  double viewPortSize =1.0;
  void _listenForScrollChanges() {
    final controller = PrimaryScrollController.of(context)!;

    controller.addListener(() {
      print(controller.offset);
      setState(() {
        // Show the text when scrolling
        showText = controller.offset > 220; // Adjust the threshold as needed
      });
      if(controller.offset>440){
        
        setState(() {
        viewPortSize =0.75;
      });
      }
      if(controller.offset<440){
        
        setState(() {
        // Show the text when scrolling
        viewPortSize =1;
      });
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ServiceProviderDetailBloc, ServiceProviderDetailState>(
          builder: (context, state) {
          if (state is ServiceProviderDetailLoadingState) {
          return ViewRestaurantLoader();
        } else if (state is ServiceProviderDetailLoadedState){
          if(loadingFirstTime == true){
          if(state.data.favrouite!.isEmpty == true){
              isFavorite =false;
          }
          else{
            int length = state.data.favrouite!.length;
            for(int k= 0;k<length;k++){
              if(state.data.favrouite![k].userId.toString() == userId){
                isFavorite =true;
              }
            }
          }
          loadingFirstTime = false;
          }
        
          else{
            
          }
          return  Stack(
              children: [
                 Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: BackButton2(),
                    backgroundColor: Colors.grey.shade50,
                    title: Text(
                                    capitalize(state.data.serviceProvider![0].fullname
                                                          .toString()),
                                    style: TextStyle(color: Colors.black),
                                  )
                  ),
                   body: DefaultTabController(
                    length: 3,
                     child: NestedScrollView(
                        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                             return <Widget>[
                          SliverList(delegate: SliverChildBuilderDelegate(
                            (BuildContext context,int index){
                              return Stack(
                                children: [
                                  Container(height: screenHeight / 4,
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.vertical(
                                                          bottom: Radius.circular(20)),
                                                    ),
                                                    child: Container(
                                                        width: screenWidth,
                                                        child: 
                                                         FadeInImage.assetNetwork(
                            placeholder: 'assets/images/imageLoader2.png', // Placeholder using KTransparentImage
                            image: "$baseUrl/serviceproviderprofile/" +
                                                              state.data.serviceProviderDetails![0]
                                                                  .banner
                                                                  .toString(),
                            fit: BoxFit.fill,
                          ),
                                                        )),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 160, 0, 0),
                                    child: Container(
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFFFF6F6),
                                                      border:
                                                          Border.all(width: 1, color: Colors.white),
                                                      borderRadius: BorderRadius.circular(100),
                                                    ),
                                                    child: ClipOval(
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xFFFFF6F6),
                                                          //borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        child: 
                                                         FadeInImage.assetNetwork(
                            placeholder: 'assets/images/imageLoader.png', // Placeholder using KTransparentImage
                            image: "$baseUrl/serviceproviderprofile/" +
                                                              state.data.serviceProvider![0].logo
                                                                  .toString(),
                            fit: BoxFit.cover,
                          ),
                                                      ),
                                                    ),
                                                  ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,230,20,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: screenWidth / 8,
                                          height: screenHeight / 16,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE5E4E4),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 0,
                                              color: Color(0xFFE5E4E4),
                                            ),
                                          ),
                                          child: IconButton(
                                              icon: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border_rounded,
                                                color: isFavorite
                                                    ? Colors.red
                                                    : const Color.fromARGB(255, 70, 69, 69),
                                                size: screenWidth < 400 ? 28 : 32,
                                              ),
                                              onPressed: () {
                                                if (isFavorite == false) {
                                                  AddToFavorite(widget.sid);
                                                } else {
                                                  RemoveFromFavorite(widget.sid);
                                                }
                                              }),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: screenWidth / 8,
                                          height: screenHeight / 16,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE5E4E4),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFFE5E4E4),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: Center(
                                              child: Icon(
                                                Icons.share_outlined,
                                                color:
                                                    const Color.fromARGB(255, 70, 69, 69),
                                                size: screenWidth < 400 ? 28 : 32,
                                              ),
                                            ),
                                            onPressed: () {
                                              Share.share(
                                                state.data.serviceProviderDetails![0]
                                                    .website
                                                    .toString(),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: screenWidth / 8,
                                          height: screenHeight / 16,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE5E4E4),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xFFE5E4E4),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.location_on_outlined,
                                              color: const Color.fromARGB(255, 70, 69, 69),
                                              size: screenWidth < 400 ? 28 : 32,
                                            ),
                                            onPressed: () {
                                              double lat =  double.parse(state.data.serviceProviderDetails![0].latitude.toString());
                                              double long =  double.parse(state.data.serviceProviderDetails![0].longitude.toString());
                                                     
                                              Get.to(RestaurantMap(
                                                latitude:lat,
                                                longitude: long,
                                              ));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                
                                ],
                              );
                            
                            },
                            childCount: 1
                          )),
                   
                          //Details
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: screenWidth /1.3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              capitalize(state.data.serviceProvider![0].fullname
                                                          .toString()),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: screenWidth < 400 ? 26 : 30),
                                            ),
                                            Container(
                                              width: screenWidth * 0.8,
                                              child: Text(
                                                maxLines: 1,
                                                 capitalize(state
                                                            .data.serviceProviderDetails![0].address
                                                            .toString()),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: 1,
                          )),
                   
                          //Star,location,time
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 0.5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.star,
                                              color: const Color(0xFFFF7F09),
                                              size: screenWidth < 400 ? 26 : 30,
                                            ),
                                          ),
                                          Text(
                                            '${state.data.serviceProvider![0].averageRating}/5',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 132, 131, 131),
                                                fontSize: screenWidth < 400 ? 12 : 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.location_on_outlined,
                                              size: screenWidth < 400 ? 26 : 30,
                                            ),
                                            onPressed: () {},
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              capitalize(state
                                                            .data.serviceProviderDetails![0].address
                                                            .toString()),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: screenWidth < 400 ? 11 : 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '(Approx: 0 km)',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: screenWidth < 400 ? 11 : 12),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.watch_later_outlined,
                                              size: screenWidth < 400 ? 26 : 30,
                                            ),
                                          ),
                                          Text(
                                            state.data.serviceProviderDetails![0].openingTime.toString()
                                            +'-'+ state.data.serviceProviderDetails![0].closingTime.toString(),
                                            // '10:00 - 10:00',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: screenWidth < 400 ? 11 : 12,
                                            ),
                                          ),
                                          Text(
                                            'Open',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: screenWidth < 400 ? 11 : 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: 1, // Number of list items
                            ),
                          ),
                   
                          //Tab Bar
                          // SliverAppBar(
                          //   elevation: 0,
                          //   toolbarHeight: 0,
                          //   collapsedHeight: 0,
                          //   pinned: true, 
                          //   floating: false,// Set this to false
                          //   backgroundColor: Colors.white,
                          //   expandedHeight: 0,
                   
                          //   bottom: PreferredSize(
                          //     preferredSize: Size.fromHeight(48.0),
                          //     child: Column(
                          //       children: [
                          //         TabBar(
                          //           controller: _tabController,
                          //           tabs: [
                          //             Tab(
                          //               child: Text(
                          //                 'MENU',
                          //                 style: TextStyle(
                          //                     color: Colors.black,
                          //                     fontSize: screenWidth < 400 ? 12 : 13),
                          //               ),
                          //             ),
                          //             Tab(
                          //               child: Container(
                          //                 width: 150,
                          //                 child: Text(
                          //                     'REVIEWS('
                          //                               +state.data.serviceProviderReviews!.length.toString()
                          //                               +')',
                          //                   maxLines: 1,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   style: TextStyle(
                          //                       color: Colors.black,
                          //                       fontSize: screenWidth < 400 ? 12 : 13),
                          //                 ),
                          //               ),
                          //             ),
                          //             Tab(
                          //               child: Text(
                          //                 'INFO',
                          //                 style: TextStyle(
                          //                     color: Colors.black,
                          //                     fontSize: screenWidth < 400 ? 12 : 13),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                                  
                          //       ],
                          //     ),
                          //   ),
                            
                            
                          // ),
                          
                             
                             ];
                        },
                        
                        
                        body:Column(
                          children: [
                            Material(
                              child: TabBar(
                                    controller: _tabController,
                                    tabs: [
                                      Tab(
                                        child: Text(
                                          'MENU',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth < 400 ? 12 : 13),
                                        ),
                                      ),
                                      Tab(
                                        child: Container(
                                          width: 150,
                                          child: Text(
                                              'REVIEWS('
                                                        +state.data.serviceProviderReviews!.length.toString()
                                                        +')',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth < 400 ? 12 : 13),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Text(
                                          'INFO',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth < 400 ? 12 : 13),
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                            Expanded(
                            
                              
                              child: TabBarView(
                               
                                    controller: _tabController,
                                    children: [
                                      MenuExpansion(dishName:'',
                                                                    menuItems: [],
                                                                    ),
                                      
                                      Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left: 10.0, right: 10.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        'Overall Rating',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: 'Inter',
                                                                            fontSize: screenWidth < 400
                                                                                ? 13
                                                                                : 13),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .fromLTRB(0, 2, 10, 0),
                                                                            child: Text(
                                                                              state
                                                                                  .data
                                                                                  .serviceProvider![0]
                                                                                  .averageRating
                                                                                  .toString(),
                                                                              style: TextStyle(
                                                                                  color: const Color(
                                                                                      0xFFFF7F09),
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  fontSize:
                                                                                      screenWidth < 400
                                                                                          ? 15
                                                                                          : 15),
                                                                            ),
                                                                          ),
                                                                          IgnorePointer(
                                                                              ignoring: true,
                                                                              child: CustomRatings(
                                                                                initialRatings: 0,
                                                                                itemSize:
                                                                                    screenWidth < 400
                                                                                        ? 22
                                                                                        : 25,
                                                                              )),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      _showReviewDialog(context);
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        elevation: 0,
                                                                        backgroundColor:
                                                                            const Color(0xFF0DAD6A)),
                                                                    child: Text(
                                                                      'Write a review',
                                                                      style: TextStyle(
                                                                          fontSize: screenWidth < 400
                                                                              ? 15
                                                                              : 15),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            ListView.builder(
                                                              physics: NeverScrollableScrollPhysics(),
                                                                shrinkWrap: true,
                                                                itemCount: state.data
                                                                    .serviceProviderReviews!.length,
                                                                itemBuilder: (context, index) {
                                                                  double star = double.parse(state
                                                                      .data
                                                                      .serviceProviderReviews![index]
                                                                      .star
                                                                      .toString()
                                                                      .toString());
                                                                  return ReviewCard(
                                                                    name: state
                                                                        .data
                                                                        .serviceProviderReviews![
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    date: state
                                                                        .data
                                                                        .serviceProviderReviews![
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    rating: star,
                                                                    reviewTitle: state
                                                                        .data
                                                                        .serviceProviderReviews![
                                                                            index]
                                                                        .title
                                                                        .toString(),
                                                                    reviewText: state
                                                                        .data
                                                                        .serviceProviderReviews![
                                                                            index]
                                                                        .reviews
                                                                        .toString(),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                        Column(
                                                          children: [
                                                            const Divider(
                                                              thickness: 1.5,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  top: 12.0,
                                                                  left: 25,
                                                                  right: 25,
                                                                  bottom: 12),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {},
                                                                    child: const Image(
                                                                      image: AssetImage(
                                                                          'assets/images/Vector-3.png'),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {},
                                                                    child: const Image(
                                                                      image: AssetImage(
                                                                          'assets/images/Vector-4.png'),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {},
                                                                    child: const Image(
                                                                      image: AssetImage(
                                                                          'assets/images/Vector-5.png'),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {},
                                                                    child: const Image(
                                                                      image: AssetImage(
                                                                          'assets/images/Vector-6.png'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const Divider(
                                                              thickness: 1.5,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    'Restaurant Info',
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: screenWidth < 400
                                                                            ? 13
                                                                            : 15),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    state.data.serviceProviderDetails![0].description.toString(),
                                                                    style: TextStyle(
                                                                        fontSize: screenWidth < 400
                                                                            ? 13
                                                                            : 15),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 8.0, bottom: 8),
                                                                    child: Divider(
                                                                      thickness: 1.5,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Restaurant Description",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 14),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    state.data.serviceProviderDetails![0].description.toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      
                                    ],
                                  ),
                            ),
                          ],
                        ),
                     
                     ),
                   ),
                 ),
                  loader == true ? CustomeLoader():Container(),   
                    ],
                  );
          
        }
        else{
         return ViewRestaurantLoader();
        }
          },
          
    ),
      ),
    );
  }
}



