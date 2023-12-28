import 'package:flutter/material.dart';

class BasketListTile extends StatelessWidget {
  const BasketListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  width: 2 * screenWidth / 10,
                  height: 50,
                  child: Image.asset('assets/images/foodlogo.png')),
              Container(
                width: 5 * screenWidth / 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Pashas Halal Food"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Birauta,Pokhara"),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("Delivery Hours: 12:00 PM - 8:00 PM"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Rs 200.00 (3 item)",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                  width: 2 * screenWidth / 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        "4.8/5",
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
