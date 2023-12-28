import 'package:flutter/material.dart';

class RestaurantLoader extends StatefulWidget {
  const RestaurantLoader({super.key});

  @override
  State<RestaurantLoader> createState() => _RestaurantLoaderState();
}

class _RestaurantLoaderState extends State<RestaurantLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:265,
          width: double.infinity,
          color: Colors.amber,
    );
  }
}