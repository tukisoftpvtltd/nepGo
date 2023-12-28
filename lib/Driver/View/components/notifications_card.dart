import 'package:flutter/material.dart';

import 'size_config.dart';
class NotificationsCard extends StatefulWidget {
  final String date;
  // final Date date;
  final String time;
  final String messageTitle;
  final String message;
  const NotificationsCard({
    super.key,
    required this.date,
    required this.time,
    required this.messageTitle,
    required this.message,
  });

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: SizeConfig(context).containerHeight() / 3,
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: SizeConfig(context).textSize() - 3,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: SizeConfig(context).textSize() - 3,
                    ),
                  ),
                ],
              ),
              Text(
                widget.messageTitle,
                style: TextStyle(
                    fontSize: SizeConfig(context).nameSize() - 2,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: SizeConfig(context).textSize() - 1,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B716C),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
