import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: ListView(
        children: [
          ListTile(
            tileColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
              child: Text("Language"),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
              child: Text("English"),
            ),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
            onTap: (){},
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            tileColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
              child: Text("Rules & Regulations"),
            ),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
            onTap: (){},
          ),
          Divider(
            height: 1,
          ),
          
          
        ],
      ),);
  }
}