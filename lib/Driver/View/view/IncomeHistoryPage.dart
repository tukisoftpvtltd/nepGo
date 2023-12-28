import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Driver/Controller/bloc/RequestHistory/bloc/request_history_bloc.dart';
import 'package:food_app/User/View/custome_loader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controller/bloc/Account/sign_up/sign_up_bloc.dart';
import '../../Controller/repository/Sales/requestHistory/requestModel.dart';
import '../../Controller/repository/Sales/requestHistory/requestRepository.dart';
import '../components/colors.dart';

class IncomeHistoryPage extends StatefulWidget {
  const IncomeHistoryPage({super.key});

  @override
  State<IncomeHistoryPage> createState() => _IncomeHistoryPageState();
}

class _IncomeHistoryPageState extends State<IncomeHistoryPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int currentPage =0;
  int indexValue=1;
 List<RequestModel?> requestList =[];
 bool loading= true;
 bool loadMore = false;
  // getData()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? driverId = prefs.getString('driverId');
  //   print("the driver id is"+driverId.toString());
  //   RequestRepository repo = new RequestRepository();
  //   RequestModel? requestModel = await repo.getrequestData(driverId!,indexValue);
  //   if(requestModel.nextPageUrl.toString() !='null'){
  //     indexValue++;
  //     loadMore =true;
  //   }
  //   else{
  //     loadMore = false;
  //   }
  //   requestList.add(requestModel);
  //   setState(() {
  //     loading = false;
  //   });
  // }
  // loadMoredata()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? driverId = prefs.getString('driverId');
  //   print("the driver id is"+driverId.toString());
  //   RequestRepository repo = new RequestRepository();
  //   RequestModel? requestModel = await repo.getrequestData(driverId!,indexValue);
  //   requestList.add(requestModel);
  //   currentPage++;
  //   // setState(() {
  //   //   loading =false;
  //   // });

  // }
  String timeLimit = 'Daily';
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
     BlocProvider.of<RequestHistoryBloc>(context).add(LoadRequestHistory(1));
  //  getData();
  }
  // loadMore(int anotherPageNumber)async{
  //   print(requestList);
  //   Future.delayed(Duration(seconds: 5), () {
  //    BlocProvider.of<RequestHistoryBloc>(context).add(LoadMoreRequestHistory(++anotherPageNumber));
  //    currentPage=1;
  // });
  // }
  


  bool showLoader = true;
  int allCounter =0;
    int completedCounter =0;
    int pendingCounter =0;
    int cancelCounter =0;
  @override
  Widget build(BuildContext context) {
    
    double screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Income History",
          style: TextStyle(color: Colors.black, fontSize: 18),
        )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pending',
                    maxLines: 1,
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
                Tab(
                  child: Text(
                    'Cancelled',
                    maxLines: 1,
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade100,
            height: 60,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
              TextButton(
                
                onPressed: () {
                  setState(() {
                  timeLimit = 'Daily';
                  });
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: timeLimit == 'Daily' ?Colours.primarygreen:Colours.primarygreen.withOpacity(0.4),
                  textStyle: TextStyle(fontSize: 14,color: Colors.white),
                ),
                child: Text('Daily',style: TextStyle(fontSize: 14)),
              ),
              SizedBox(
                  width: 20,
                ),
              TextButton(
                onPressed: () {
                   setState(() {
                  timeLimit = 'Weekly';
                  });
                },
                child: Text('Weekly',style: TextStyle(fontSize: 14)),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: timeLimit == 'Weekly' ?Colours.primarygreen:Colours.primarygreen.withOpacity(0.4),
                  textStyle: TextStyle(fontSize: 14,color: Colors.white),
                ),
              ),
              SizedBox(
                  width: 20,
                ),
              TextButton(
                onPressed: () {
                   setState(() {
                  timeLimit = 'Yearly';
                  });
                },
                child: Text('Yearly',style: TextStyle(fontSize: 14),),
                 style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: timeLimit == 'Yearly' ?Colours.primarygreen:Colours.primarygreen.withOpacity(0.4),
                  textStyle: TextStyle(fontSize: 14,color: Colors.white),
                ),
              ),
            ],)

          ),
          BlocBuilder<RequestHistoryBloc, RequestHistoryState>(
            builder: (context, state) {
              // if(loading == true){
              //      return Container(
              //     height: Get.height - 200,
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: 10,
              //       itemBuilder: (context, index){
              //         return IncomeShimmer();
              //       },
              //     ),
              //   );
              // }
              if(state is RequestHistoryLoading ){
                return Container(
                  height: Get.height - 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return IncomeShimmer();
                    },
                  ),
                );
              }
              if(state is RequestHistoryLoaded){
                requestList.add(state.data);
                return Container(
                height: Get.height - 260,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    state.data!.data!.length ==0 ?
                    Center(child: Text("No Record Found"),)
                    :
                    ListView.builder(
                      itemCount: requestList[currentPage]!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                          allCounter++;
                        return IncomeContainer(
                          type: 'All',
                          pickUplocation: requestList[currentPage]!.data![index].pickupLocation.toString(),
                          destintaionLocation: requestList[currentPage]!.data![index].detinationLocation.toString(),
                          distance: requestList[currentPage]!.data![index].distance!,
                          amount: requestList[currentPage]!.data![index].amount.toString(),
                        );
                      },
                    ),
                    
                   ListView.builder(
                      itemCount: state.data!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if(state.data!.data![index].isRideCompleted == 1){
                          completedCounter++;
                        }
                       return 
                       state.data!.data![index].isRideCompleted == 1?
                       IncomeContainer(
                        type: 'Completed',
                          pickUplocation: state.data!.data![index].pickupLocation.toString(),
                          destintaionLocation: state.data!.data![index].detinationLocation.toString(),
                          distance: state.data!.data![index].distance!,
                          amount: state.data!.data![index].amount.toString(),
                        ):Container();
                      },
                    ),
                    ListView.builder(
                      itemCount: state.data!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if(state.data!.data![index].cancel == 0 && state.data!.data![index].isRideCompleted ==0){
                          pendingCounter++;
                        }
                       return 
                       (state.data!.data![index].cancel == 0 && state.data!.data![index].isRideCompleted ==0 )?
                       IncomeContainer(
                        type: 'Pending',
                          pickUplocation: state.data!.data![index].pickupLocation.toString(),
                          destintaionLocation: state.data!.data![index].detinationLocation.toString(),
                          distance: state.data!.data![index].distance!,
                          amount: state.data!.data![index].amount.toString(),
                        ):Container();
                      },
                    ),
                    ListView.builder(
                      itemCount: state.data!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                         if(state.data!.data![index].cancel == 1){
                          cancelCounter++;
                        }
                       return 
                       state.data!.data![index].cancel == 1?
                       IncomeContainer(
                          type:'Cancel',
                          pickUplocation: state.data!.data![index].pickupLocation.toString(),
                          destintaionLocation: state.data!.data![index].detinationLocation.toString(),
                          distance: state.data!.data![index].distance!,
                          amount: state.data!.data![index].amount.toString(),
                        ):Container();
                      },
                    ),
                  ],
                ),
              );
             
           
              }
              else{
                 return Container(
                  height: Get.height - 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return IncomeShimmer();
                    },
                  ),
                );
              }
              
              
              
           },
          ),
        
        ],
      ),
    bottomSheet: Container(
      color: Colours.primarygreen,
      height: 60,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text("Total :",style: TextStyle(fontSize: 16,color: Colors.white),),
          Text("Rs. 140",style: TextStyle(fontSize: 16,color: Colors.white),),
        ]),
      ),
    ),
    );
  }
}

class IncomeContainer extends StatefulWidget {
  String type;
   String pickUplocation;
  String destintaionLocation;
  double distance;
  String amount;
  IncomeContainer({super.key,
  required this.type,
  required this.pickUplocation,
  required this.destintaionLocation,
  required this.distance,
  required this.amount});
 

  @override
  State<IncomeContainer> createState() => _IncomeContainerState();
}

class _IncomeContainerState extends State<IncomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(children: [
            SizedBox(
              width: 20,
            ),
            ClipOval(
                child: Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'assets/rideshare/person.jpg',
                      fit: BoxFit.cover,
                    ))),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width*0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From : ${widget.pickUplocation}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "To : ${widget.destintaionLocation}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Distance : ${(widget.distance/1000).toStringAsFixed(2)} Km",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14,
                        color: Colors.grey, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
           
            Container(
              width: Get.width*0.15,
              child: Text(
                "Rs. ${widget.amount}",
                style: TextStyle(
                    color: widget.type =='Pending' ?Colors.grey :widget.type == 'Cancel' ?Colors.red : Colours.primarygreen, fontWeight: FontWeight.w600),
              ),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
            
          ),
        ],
      ),
    );
  
  }
}




class IncomeShimmer extends StatelessWidget {
  const IncomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(children: [
            SizedBox(
              width: 20,
            ),
            Shimmer.fromColors(
               baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
              child: ClipOval(
                  child: Container(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        'assets/rideshare/person.jpg',
                        fit: BoxFit.cover,
                      ))),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: Get.width*0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width:Get.width*1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width:Get.width*1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 15,
                      width:Get.width*1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
           
            
          ]),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
            
          ),
        ],
      ),
    );
  ;
  }
}