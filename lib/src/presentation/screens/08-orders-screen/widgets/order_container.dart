import 'package:next_shop_app/src/presentation/screens/08-orders-screen/widgets/expansion_item.dart';
import 'package:flutter/material.dart';
import 'package:next_shop_app/src/data/models/orders.dart';
import 'package:next_shop_app/src/data/models/product.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer({
    Key? key,
    required this.order,
    required this.prods,
  }) : super(key: key);

  final Order order;
  final List<Product> prods;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            'Order #${order.id}',
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            order.date,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          children: [
            ExpansionItem(prods: prods, order: order),
          ],
        ),
      ),
    );
  }
}
