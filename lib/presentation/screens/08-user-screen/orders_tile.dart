import 'package:flutter/material.dart';
import 'package:next_shop_app/constants/strings.dart';

class OrdersTile extends StatelessWidget {
  const OrdersTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ordersScreen),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        color: Colors.white,
        child: const ListTile(
          leading: Icon(Icons.credit_card_rounded),
          title: Text(
            'Orders',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
