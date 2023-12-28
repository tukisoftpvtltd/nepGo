import 'package:flutter/material.dart';

import '../../SearchScreens/widget/filter_dialog.dart';
import 'text_button.dart';


class CustomSort extends StatefulWidget {
  const CustomSort({super.key});

  @override
  State<CustomSort> createState() => _CustomSortState();
}

class _CustomSortState extends State<CustomSort> {
  Color selectedButtonColor = const Color(0xFFFF7F09);
  Color unselectedButtonColor = Colors.black;
  String selectedButton = 'Best Match';

  void handleClicked(String buttonName) {
    setState(() {
      selectedButton = buttonName;
    });
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FilterDialog(
              index: 0,
              openRestaurant: "yes",
              name:"null",
              Distance:"null" ,
              Sales:"null", grocerySearchKey: '', restaurantSearchKey: '', 
              callback: (){},

            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
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
                icon: const Icon(Icons.favorite_outline),
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
              // CustomTextButton(
              //   name: 'Price',
              //   icon: const Icon(Icons.arrow_drop_up),
              //   handleClicked: handleClicked,
              //   nameColor: selectedButton == 'Price'
              //       ? selectedButtonColor
              //       : unselectedButtonColor,
              // ),
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
                    color: Colors.black, size: screenWidth < 400 ? 16 : 18),
              ],
            ),
          )
        ],
      ),
    );
  }
}