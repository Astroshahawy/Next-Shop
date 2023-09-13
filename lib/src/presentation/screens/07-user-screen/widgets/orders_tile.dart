import 'package:next_shop_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class OrdersTile extends StatelessWidget {
  const OrdersTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.ordersScreen),
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
