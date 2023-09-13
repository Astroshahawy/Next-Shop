import 'package:next_shop_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:next_shop_app/src/data/models/orders.dart';
import 'package:next_shop_app/src/data/models/product.dart';

class ExpansionItem extends StatelessWidget {
  const ExpansionItem({
    Key? key,
    required this.prods,
    required this.order,
  }) : super(key: key);

  final List<Product> prods;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: prods
          .map(
            (product) => ListTile(
              isThreeLine: true,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.productScreen,
                    arguments: product);
              },
              title: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Qty: ${order.orderProducts[prods.indexOf(product)].quantity}',
              ),
              trailing: Text(
                'USD ${(product.price * order.orderProducts[prods.indexOf(product)].quantity).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
