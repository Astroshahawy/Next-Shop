import 'package:next_shop_app/src/presentation/screens/03-product-screen/widgets/app_bar.dart';
import 'package:next_shop_app/src/presentation/screens/03-product-screen/widgets/floating_button.dart';
import 'package:next_shop_app/src/presentation/screens/03-product-screen/widgets/image_container.dart';
import 'package:next_shop_app/src/presentation/screens/03-product-screen/widgets/product_description.dart';
import 'package:next_shop_app/src/presentation/screens/03-product-screen/widgets/product_info.dart';
import 'package:next_shop_app/src/presentation/screens/03-product-screen/widgets/product_subinfo.dart';
import 'package:flutter/material.dart';

import 'package:next_shop_app/src/data/models/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).viewPadding.top,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.amber[300]!,
                        Colors.orange[600]!,
                      ],
                    ),
                  ),
                ),
                const CustomAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ProductSubInfo(product: product),
                        ImageContainer(product: product),
                        ProductInfo(product: product),
                        ProductDescription(product: product),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FloatingButton(product: product),
          ],
        ),
      ),
    );
  }
}
