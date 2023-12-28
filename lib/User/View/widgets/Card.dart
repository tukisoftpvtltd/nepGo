import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  String imageUrl = '';
  String name = '';
  String location = '';
  ItemCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: SizedBox(
          height: 150,
          width: 250,
          child: Column(
            children: [
              SizedBox(
                height: 185,
                width: 250,
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        "https://meroato.tukisoft.com.np/uploads/$imageUrl",
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(
                        'assets/images/foodpic.png',
                        fit: BoxFit.fill,
                      ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Name",
                            textAlign: TextAlign.left,
                          )),
                      // SizedBox(
                      //   height: 4,
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "location",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )),
                          Text(
                            "location",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 2,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Divider(),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Restaurant Name",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Approx(1 km)",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
