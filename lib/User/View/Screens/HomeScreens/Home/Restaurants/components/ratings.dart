

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatings extends StatelessWidget {
  final double initialRatings;
  final double itemSize;
  const CustomRatings(
      {super.key, required this.initialRatings, required this.itemSize});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRatings,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: itemSize,
      itemBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Icon(
            CupertinoIcons.star_fill,
            color: Color(0xFFFF7F09),
            size: 15,
          ),
        );
      },
      onRatingUpdate: (double value) {},
    );
  }
}
