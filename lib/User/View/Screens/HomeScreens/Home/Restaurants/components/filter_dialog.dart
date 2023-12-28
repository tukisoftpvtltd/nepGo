import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/User/View/Screens/HomeScreens/Home/Restaurants/screens/restaurants_page.dart';
import 'package:get/get.dart';
import '../../../../../constants/colors.dart';
import '../../../Baskets/Basket/widget/size_config.dart';

class RestaurantFilterDialog extends StatefulWidget {
  final int index;
  final String restaurantSearchKey;
  final String grocerySearchKey;
   final String openRestaurant;
  final String name;
  final String Distance;
  final String Sales;
  RestaurantFilterDialog({super.key,
  required this.index,
  required this.restaurantSearchKey,
  required this.grocerySearchKey,
  required this.openRestaurant,
  required this.name,
  required this.Distance,
  required this.Sales,
  });
  @override
  State<RestaurantFilterDialog> createState() => _RestaurantFilterDialogState();
}

class _RestaurantFilterDialogState extends State<RestaurantFilterDialog> {
  Color selectedButtonColor = const Color(0xFFFF7F09);
  Color unselectedButtonColor = Colors.black;
  String selectedButton = 'Name';
  String isAscending = "null";
  bool isSwitchOn = false;
  void handleClicked(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(widget.openRestaurant =='yes'){
      isSwitchOn = true;
    }
    if(widget.name!="null"){
      selectedButton = 'Name';
      if(widget.name == "ASC"){
        isAscending="true";
      }
       if(widget.name == "DESC"){
        isAscending="false";
      }

    }
    if(widget.Distance!="null"){
      selectedButton = 'Distance';
    }
    
    if(widget.Sales!="null"){
      selectedButton = 'Sales';
    }
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return AlertDialog(
        scrollable: true,
        content: Container(
          // height: screenHeight < 800 ? screenHeight / 1.5 : screenHeight / 2,
          width: screenWidth < 400 ? screenWidth / 1.4 : screenWidth / 1.3,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Filter',
                style: TextStyle(fontSize: SizeConfig(context).nameSize()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Show Open Restaurants Only',
                    style:
                        TextStyle(fontSize: SizeConfig(context).textSize() - 2),
                  ),
                  CupertinoSwitch(
                    activeColor: Colours.primarygreen,
                    value: isSwitchOn,
                    onChanged: (value) {
                      setState(() {
                        isSwitchOn = value;
                      });
                    },
                  ),
                ],
              ),
              const Divider(
                thickness: 0.3,
                color: Colors.grey,
              ),
              Text(
                'Sort By',
                style: TextStyle(fontSize: SizeConfig(context).nameSize()-2),
              ),
              InkWell(
                 onTap: () {
                  handleClicked('Name');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name:',
                        style: TextStyle(fontSize: SizeConfig(context).textSize(),
                        color: selectedButton == 'Name'
                              ? selectedButtonColor
                              : unselectedButtonColor,),
                        
                      ),
                      Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.3,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAscending = "true";
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        isAscending =="true" ? Colours.primarygreen : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ASC',
                                      style: TextStyle(
                                        color: isAscending=="true" 
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig(context).textSize(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAscending = "false";
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        isAscending =="false" ? Colours.primarygreen : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'DESC',
                                      style: TextStyle(
                                        color: isAscending =="false"
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig(context).textSize(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 0.3,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  handleClicked('Distance');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance:',
                        style: TextStyle(
                          fontSize: SizeConfig(context).textSize(),
                          color: selectedButton == 'Distance'
                              ? selectedButtonColor
                              : unselectedButtonColor,
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: selectedButton == 'Distance'
                            ? selectedButtonColor
                            : unselectedButtonColor,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  handleClicked('Sales');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sales:',
                        style: TextStyle(
                          fontSize: SizeConfig(context).textSize(),
                          color: selectedButton == 'Sales'
                              ? selectedButtonColor
                              : unselectedButtonColor,
                        ),
                      ),
                      Icon(
                        Icons.sell_outlined,
                        color: selectedButton == 'Sales'
                            ? selectedButtonColor
                            : unselectedButtonColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String openRestaurant='';
                    String name ="null";
                    String Distance='null';
                    String Sales='null';               
                    if(isSwitchOn == true){
                      openRestaurant ='yes';     
                    }
                     if(isSwitchOn == false){
                      openRestaurant ='no';
                    }
                          if(selectedButton =="Name"){
                            if(isAscending=="true"){
                              name = "ASC";
                            }
                             if(isAscending == "false"){
                              name = "DESC";
                            }           
                          }
                          if(selectedButton =="Distance"){
                            Distance = "ASC";
                          }
                          if(selectedButton =="Sales"){
                            Sales = "ASC";
                          }
                          print("isServiceProviderOpen: $openRestaurant");
                          print("name: $name");
                          print("Distance: $Distance");
                          print("Sales: $Sales");
                          Get.offAll(RestaurantsPage(
                            bestMatch: false,
                            TopSales: false,
                            isNew: false,
                            openRestaurant: openRestaurant,
                            name:name,
                            Distance:Distance,
                            Sales:Sales,
                          ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colours.primarygreen,
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

//print all prime numbers from 1 to 1000



