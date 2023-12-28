// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../Restaurants/components/text_button.dart';
// import '../search_page.dart';
// import 'filter_dialog.dart';



// class CustomSort extends StatefulWidget {
//   final String CustomSortValue;
//   final int index;
//   final String restaurantSearchKey;
//   final String grocerySearchKey;
//   final String openRestaurant;
//   final String name;
//   final String Distance;
//   final String Sales;
//    CustomSort({super.key,
//   required this.CustomSortValue,
//   required this.index,
//   required this.restaurantSearchKey,
//   required this.grocerySearchKey,
//   required this.openRestaurant,
//   required this.name,
//   required this.Distance,
//   required this.Sales,
//   });

//   @override
//   State<CustomSort> createState() => _CustomSortState();
// }

// class _CustomSortState extends State<CustomSort> {
//   Color selectedButtonColor = const Color(0xFFFF7F09);
//   Color unselectedButtonColor = Colors.black;
 
//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("The Index is");
//     print(widget.index);
//     print(widget.name);
//   }

//   void showFilterDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
       
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return FilterDialog(
//               index:widget.index,
//               restaurantSearchKey:widget.restaurantSearchKey,
//               grocerySearchKey:widget.grocerySearchKey,
//               openRestaurant: widget.openRestaurant,
//               name: widget.name,
//               Distance: widget.Distance,
//               Sales: widget.Sales,
//               callback: (){},
                
//             );
//           },
//         );
//       },
//     );
//   }

 

//   @override
//   Widget build(BuildContext context) {
//      String selectedButton = widget.CustomSortValue;
    
//   void handleClicked(String buttonName) {
//     setState(() {
//       selectedButton = buttonName;
//     });
//      if(selectedButton == 'Best Match'){
//         Get.offAll(SearchPage(
//                             restaurantSearchTerm: widget.restaurantSearchKey,
//                             grocerySearchTerm: widget.grocerySearchKey,
//                             index: widget.index,
//                             bestMatch: true,
//                             TopSales: false,
//                             isNew: false,
//                             openRestaurant: "null",
//                             name:"null",
//                             Distance:"null",
//                             Sales:"null",
//                           ));
//     }
//     if(selectedButton == 'Top Sales'){
//       Get.offAll(SearchPage(
//                              restaurantSearchTerm: widget.restaurantSearchKey,
//                             grocerySearchTerm: widget.grocerySearchKey,
//                             index: widget.index,
//                             bestMatch: false,
//                             TopSales: true,
//                             isNew: false,
//                             openRestaurant: "null",
//                             name:"null",
//                             Distance:"null",
//                             Sales:"null",
//                           ));
      
//     }
//     if(selectedButton == 'New'){
//         Get.offAll(SearchPage(
//                              restaurantSearchTerm: widget.restaurantSearchKey,
//                             grocerySearchTerm: widget.grocerySearchKey,
//                             index: widget.index,
//                             bestMatch: false,
//                             TopSales: false,
//                             isNew: true,
//                             openRestaurant: "null",
//                             name:"null",
//                             Distance:"null",
//                             Sales:"null",
//                           ));
                          
//     }
//   }
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//             //  Get.offAll(SearchPage(
//                   //           bestMatch: false,
//                   //           TopSales: true,
//                   //           isNew: false,
//                   //           openRestaurant: "null",
//                   //           name:"null",
//                   //           Distance:"null",
//                   //           Sales:"null",
//                   //         ));
//           Row(
//             children: [
//               CustomTextButton(
//                 name: 'Best Match',
//                 icon: const Icon(Icons.thumb_up_alt_outlined),
//                 handleClicked: handleClicked,
//                 nameColor: selectedButton == 'Best Match'
//                     ? selectedButtonColor
//                     : unselectedButtonColor,
//               ),
//               CustomTextButton(
//                 name: 'Top Sales',
//                 icon: const Icon(Icons.favorite_outline),
//                 handleClicked: handleClicked,
//                 nameColor: selectedButton == 'Top Sales'
//                     ? selectedButtonColor
//                     : unselectedButtonColor,
//               ),
//               CustomTextButton(
//                 name: 'New',
//                 icon: const Icon(Icons.watch_later_outlined),
//                 handleClicked: handleClicked,
//                 nameColor: selectedButton == 'New'
//                     ? selectedButtonColor
//                     : unselectedButtonColor,
//               ),
//               // CustomTextButton(
//               //   name: 'Price',
//               //   icon: const Icon(Icons.arrow_drop_up),
//               //   handleClicked: handleClicked,
//               //   nameColor: selectedButton == 'Price'
//               //       ? selectedButtonColor
//               //       : unselectedButtonColor,
//               // ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () {
//                print(widget.openRestaurant);
//               print(widget.name);
//               print(widget.Distance);
//               print(widget.Sales);
//               showFilterDialog(context);
//             },
//             child: Row(
//               children: [
//                 Text(
//                   'Filter',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: screenWidth < 400 ? 10 : 12,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//                 Icon(Icons.filter_alt_outlined,
//                     color: Colors.black, size: screenWidth < 400 ? 16 : 18),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }