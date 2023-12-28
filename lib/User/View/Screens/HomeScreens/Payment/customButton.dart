// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:food_app/Driver/View/components/colors.dart';



class CustomButton extends StatelessWidget {
  String name;
  void Function() handleClicked;
  double? width;
  double? height;
  double? top;
  double? fontSize;
  IconData? iconData;
  bool? isIcon;
  Color? color;

  CustomButton({
    Key? key,
    this.color = Colours.primarygreen,
    required this.name,
    required this.handleClicked,
    this.width = 200,
    this.height = 50,
    this.top = 25,
    this.iconData,
    this.isIcon = false,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.only(top: top!),
      child: ElevatedButton(
        onPressed: handleClicked,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: Size(width!, height!),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon! ? Icon(iconData) : const SizedBox(),
            isIcon! ? SizedBox(width: 16) : const SizedBox(),
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize!),
            ),
          ],
        ),
      ),
    );
  }
}