import 'package:flutter/material.dart';
import 'TextPage2.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String name='Abiral';
  updateName(){
    setState(() {
      name = "Function Called";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(name),
          ElevatedButton(onPressed: (){
           Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Test2(callback: updateName)),
    );
          }, child: Text("press")),
        ]),
      ),
    );
  }
}