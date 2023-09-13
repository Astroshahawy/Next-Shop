import 'package:next_shop_app/core/utils/title_capitalization.dart';
import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String text;
  const CategoryTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleCapitalize(text),
      style: const TextStyle(
        fontSize: 20.0,
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
