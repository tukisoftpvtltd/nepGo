import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool ChildSheet =false;
        bool passenger =false;
  //   void _showCommentBottomSheet(BuildContext context){
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
        
  //       return },
  //   );
  // }
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:Center(
        child: ElevatedButton(child: Text("Press"),
        onPressed: (){
        _scaffoldKey.currentState?.openDrawer();
        },),
         
      ),
    drawer: Drawer(),
     
    );
  }
}