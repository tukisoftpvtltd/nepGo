import 'package:flutter/material.dart';
class Test2 extends StatelessWidget {
  final Function callback;

  Test2({Key? key, required this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Go back"),
          onPressed: (){
            // callback();
            callback();
            // callback("Hello from Screen B");
            Navigator.pop(context, "Hello from Screen B");
          },
      ),),
    );
  }
}