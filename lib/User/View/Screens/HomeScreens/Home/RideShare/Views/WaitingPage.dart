import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(""),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(child: Text("Driver will arrive in 5 minutes")),
      ),
    );
  }
}