import 'package:flutter/material.dart';

import '../../Baskets/Basket/widget/size_config.dart';

class QrDialog extends StatefulWidget {
  const QrDialog({super.key});

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
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig(context).nameSize() - 2),
      )),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            const Image(image: AssetImage('assets/images/qrcode.png')),
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
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig(context).nameSize()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
