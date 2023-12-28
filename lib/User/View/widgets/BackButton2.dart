import 'package:flutter/material.dart';

class BackButton2 extends StatelessWidget {
   BackButton2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Container(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
  }
}