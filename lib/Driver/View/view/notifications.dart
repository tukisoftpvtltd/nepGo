import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/notifications_card.dart';
import '../components/size_config.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black,),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: Text(
            'Notifications',
            style: TextStyle(
                fontSize: SizeConfig(context).titleSize()-4,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 8; i++)
                const Column(
                  children: [
                    NotificationsCard(
                        date: '2023/04/05',
                        time: '9:54',
                        messageTitle: 'New Order Request',
                        message:
                            'Food Order request from Birauta, Pokhara'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
