import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MenuTile.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 40,
            child: const Center(
              child: Text(
                "More",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          MenuTile(
            IconName: "1",
            TextName: "  About Food App",
          ),
          MenuTile(
            IconName: "2",
            TextName: "  Feedback",
          ),
          MenuTile(
            IconName: "3",
            TextName: "  Terms and conditions",
          ),
          MenuTile(
            IconName: "4",
            TextName: "  Privacy Policy",
          ),
          MenuTile(
            IconName: "5",
            TextName: "  FAQ",
          ),
          SizedBox(
            height: 320,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                  size: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.orange,
                  size: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                  size: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Version 2.2.1.2",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                " Food App",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Developed by: Tukisoft Pvt. Ltd.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
