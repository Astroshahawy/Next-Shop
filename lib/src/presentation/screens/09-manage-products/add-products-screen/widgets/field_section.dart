import 'package:flutter/material.dart';

import 'package:next_shop_app/core/themes/app_colors.dart';

class FieldSection extends StatelessWidget {
  const FieldSection({
    Key? key,
    required this.title,
    required this.child,
    this.isMarginRight = true,
    this.isMarginLeft = true,
    this.isDescription = false,
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool isMarginRight;
  final bool isMarginLeft;
  final bool isDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: isMarginLeft ? 30 : 0,
        right: isMarginRight ? 30 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                letterSpacing: 1,
                color: AppLightColors.defaultColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: isDescription
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.057,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.5,
                  offset: Offset.fromDirection(90),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
