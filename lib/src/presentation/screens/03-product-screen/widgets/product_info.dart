import 'package:flutter/material.dart';
import 'package:next_shop_app/src/data/models/product.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'USD ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[900],
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                  ),
                ),
                TextSpan(
                  text: product.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                    fontSize: 26.0,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
