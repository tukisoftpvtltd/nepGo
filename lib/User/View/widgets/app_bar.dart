import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final IconData? iconbutton;
  final VoidCallback? pressed;

  const MyAppBar({
    this.iconbutton,
    this.pressed,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actions: [
        IconButton(
          alignment: Alignment.topRight,
          onPressed: pressed,
          icon: Icon(
            iconbutton,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
