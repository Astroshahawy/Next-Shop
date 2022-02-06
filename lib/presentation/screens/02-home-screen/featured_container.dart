import 'package:flutter/material.dart';
import 'package:next_shop_app/constants/strings.dart';

import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/presentation/widgets/product_item.dart';

class FeaturedContainer extends StatelessWidget {
  final List<Product> products;
  const FeaturedContainer({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Featured',
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 7 / 8,
            ),
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    productScreen,
                    arguments: product,
                  );
                },
                child: ProductItem(
                  price: product.price.toStringAsFixed(2),
                  imageUrl: product.image,
                  productName: product.title,
                  isHomeScreen: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
