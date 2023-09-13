import 'package:next_shop_app/core/utils/title_capitalization.dart';
import 'package:flutter/material.dart';
import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/presentation/widgets/rating_star.dart';

class ProductSubInfo extends StatelessWidget {
  const ProductSubInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Row(
        children: [
          Text(
            '${product.rating.count}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          RatingStars(
            rating: product.rating.rate.toInt(),
          ),
          const Spacer(),
          Text(
            'Category: ${titleCapitalize(product.category)}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
