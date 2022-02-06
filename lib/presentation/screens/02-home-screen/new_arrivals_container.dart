import 'package:flutter/material.dart';
import 'package:next_shop_app/constants/strings.dart';

import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/presentation/widgets/product_item.dart';

class NewArrivalsContainer extends StatelessWidget {
  final List<Product> products;
  const NewArrivalsContainer({
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
          'New Arrivals',
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
                child: Stack(
                  children: [
                    ProductItem(
                      price: product.price.toStringAsFixed(2),
                      imageUrl: product.image,
                      productName: product.title,
                      isHomeScreen: true,
                    ),
                    Positioned(
                      left: 0.0,
                      top: 25.0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 30.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15.0),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.amber[300]!,
                              Colors.orange[600]!,
                            ],
                          ),
                        ),
                        child: const Text(
                          'New',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
