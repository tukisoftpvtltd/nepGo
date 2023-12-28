import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Baskets/Basket/widget/size_config.dart';

class QrDialog extends StatefulWidget {
  String tcode;
  QrDialog({super.key,required this.tcode});

  @override
  State<QrDialog> createState() => _QrDialogState();
}

class _QrDialogState extends State<QrDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Center(
          child: Text(
        '''Scan the QR code to complete 
            the transaction''',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig(context).nameSize() - 2),
      )),
      content: Container(
        height:300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
           SizedBox(
            width: 200, // Set the width of the QR code
            height: 200,
              child: QrImageView(
  data: widget.tcode,
  version: QrVersions.auto,
  size: 200.0,
),
            ),
            
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80.0, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: const Color(0xFF0DAD6A),
              ),
              child: Text(
                'CLOSE',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig(context).nameSize()-4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
