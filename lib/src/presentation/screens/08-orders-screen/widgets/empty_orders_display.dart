import 'package:flutter/material.dart';

class EmptyOrdersDisplay extends StatelessWidget {
  const EmptyOrdersDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Theme.of(context).primaryColor,
          size: MediaQuery.of(context).size.height * 0.15,
        ),
        Text(
          'Orders list is empty',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30.0,
            letterSpacing: 1.3,
          ),
        ),
        Text(
          'Be sure to add some products',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14.0,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
