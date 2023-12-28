import 'package:flutter/material.dart';

import 'MenuScreens/about.dart';
import 'MenuScreens/faq.dart';
import 'MenuScreens/feedback.dart';
import 'MenuScreens/privacy_policy.dart';
import 'MenuScreens/terms_and_conditions.dart';

// ignore: must_be_immutable
class MenuTile extends StatelessWidget {
  String IconName;
  String TextName;
  MenuTile({super.key, required this.IconName, required this.TextName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [
            const SizedBox(
              width: 20,
            ),
            IconName == "1"
                ? const Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                    size: 25,
                  )
                : Container(),
            IconName == "2"
                ? const Icon(
                    Icons.feedback_outlined,
                    size: 25,
                    color: Colors.grey,
                  )
                : Container(),
            IconName == "3"
                ? const Icon(
                    Icons.file_copy_outlined,
                    size: 25,
                    color: Colors.grey,
                  )
                : Container(),
            IconName == "4"
                ? const Icon(
                    Icons.file_copy_outlined,
                    size: 25,
                    color: Colors.grey,
                  )
                : Container(),
            IconName == "5"
                ? const Icon(
                    Icons.question_mark_outlined,
                    size: 25,
                    color: Colors.grey,
                  )
                : Container(),
            GestureDetector(
              onTap: () {
                if (IconName == "1") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutApp()));
                } else if (IconName == "2") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedBack()));
                } else if (IconName == "3") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsAndConditions()));
                } else if (IconName == "4") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicy()));
                } else if (IconName == "5") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const FAQ()));
                }
              },
              child: Text(
                TextName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          ]),
          const Divider(
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
