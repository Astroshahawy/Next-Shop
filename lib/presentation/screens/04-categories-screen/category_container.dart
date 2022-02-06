import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final Widget child;

  const CategoryContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            offset: Offset.fromDirection(90.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
