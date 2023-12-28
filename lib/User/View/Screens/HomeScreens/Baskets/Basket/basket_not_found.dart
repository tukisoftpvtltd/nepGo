import 'package:flutter/material.dart';

class BasketNotFound extends StatefulWidget {
  const BasketNotFound({super.key});

  @override
  State<BasketNotFound> createState() => _BasketNotFoundState();
}

class _BasketNotFoundState extends State<BasketNotFound> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Please login to add to basket"),
      ),
    );
  }
}
