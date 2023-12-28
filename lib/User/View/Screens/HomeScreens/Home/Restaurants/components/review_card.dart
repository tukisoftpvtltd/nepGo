import 'package:flutter/material.dart';
import 'package:food_app/Driver/Controller/Function/capitalize.dart';

import 'ratings.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final double rating;
  final String reviewTitle;
  final String reviewText;

  const ReviewCard({
    Key? key,
    required this.name,
    required this.date,
    required this.rating,
    required this.reviewTitle,
    required this.reviewText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1.5,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final bool isSmallDevice = constraints.maxWidth < 400;
            final double horizontalPadding = isSmallDevice ? 8.0 : 10.0;
            final double verticalPadding = isSmallDevice ? 8.0 : 10.0;
            final double nameFontSize = isSmallDevice ? 13 : 15;
            final double titleFontSize = isSmallDevice ? 16 : 20;
            final double textFontSize = isSmallDevice ? 12 : 14;
            final double iconSize = isSmallDevice ? 20 : 32;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          'By $name \nOn : $date',
                            maxLines:2,
                            overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: nameFontSize-2,
                          color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(width: 35),
                      IgnorePointer(
                        ignoring: true,
                        child: CustomRatings(
                          initialRatings: rating,
                          itemSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    capitalize(reviewTitle) ,
                    style: TextStyle(
                      fontSize: titleFontSize-4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    reviewText,
                    style: TextStyle(fontSize: textFontSize-2),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
