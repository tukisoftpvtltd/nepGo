import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String name;
  final Icon icon;
  final void Function(String) handleClicked;
  final Color nameColor;

  const CustomTextButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.handleClicked,
    required this.nameColor,
  }) : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => widget.handleClicked(widget.name),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,5,0),
              child: Text(
                widget.name,
                style: TextStyle(
                  color: widget.nameColor,
                  fontSize: screenWidth < 400 ? 10 : 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Icon(widget.icon.icon,
                color: widget.nameColor, size: screenWidth < 400 ? 16 : 18),
          ],
        ),
      ),
    );
  }
}
