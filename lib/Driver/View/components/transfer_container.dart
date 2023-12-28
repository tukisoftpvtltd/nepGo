import 'package:flutter/material.dart';

import 'size_config.dart';

class TransferContainer extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String restaurantLocation;
  final String deliveryLocation;
  final double ratings;
  const TransferContainer(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.restaurantLocation,
      required this.deliveryLocation,
      required this.ratings});

  @override
  State<TransferContainer> createState() => _TransferContainerState();
}

class _TransferContainerState extends State<TransferContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig(context).containerHeight() / 1.8,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Container()),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: SizeConfig(context).nameSize(),
                        ),
                      ),
                      Text(
                        widget.restaurantLocation,
                        style: TextStyle(
                          fontSize: SizeConfig(context).textSize(),
                        ),
                      ),
                      Text(
                        widget.deliveryLocation,
                        style: TextStyle(
                          fontSize: SizeConfig(context).textSize(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, right: 14.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(
                        0xFFFF7F09,
                      ),
                    ),
                    Text('${widget.ratings}/5')
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig(context).buttonHorizontalPadding(),
                      vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.black,
                ),
                child: const Text('DECLINE'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig(context).buttonHorizontalPadding(),
                      vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text('ACCEPT'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
