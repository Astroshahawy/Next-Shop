import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (var i = 1; i <= rating; i++) {
      stars += '⭐  ';
    }
    return Text(
      stars.trim(),
      style: const TextStyle(fontSize: 16),
    );
  }
}
