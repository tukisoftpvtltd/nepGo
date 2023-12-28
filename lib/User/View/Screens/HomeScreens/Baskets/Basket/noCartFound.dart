import 'package:flutter/material.dart';

class NoCartFound extends StatefulWidget {
  const NoCartFound({super.key});

  @override
  State<NoCartFound> createState() => _NoCartFoundState();
}

class _NoCartFoundState extends State<NoCartFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            height: 100,
            width: 100,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/cart.png'))),
              SizedBox(height: 10,),
          Text("Sorry! You don’t have any Cart"),
        ]),
      ),
    );
  }
}