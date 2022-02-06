import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class FloatingButton extends StatelessWidget {
  final Product product;
  const FloatingButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  Future<void> addToCart(BuildContext context, Product product) async {
    final newProduct =
        BlocProvider.of<CartCubit>(context).tryAddToCart(product);
    if (context.read<CartCubit>().cartProductStatus) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: const Text(
            'Product already added to cart.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      context.loaderOverlay.show(
        widget: const LoadingSpinningCircle(color: Colors.white),
      );
      await BlocProvider.of<CartCubit>(context).addToCart(newProduct);
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Product added to cart.',
            style: TextStyle(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0.0,
      bottom: 50.0,
      height: 60.0,
      width: 125,
      child: GestureDetector(
        onTap: () async => await addToCart(context, product),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.amber[300]!,
                Colors.orange[600]!,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset.fromDirection(180),
              ),
            ],
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.white,
                  size: 34.0,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Add to',
                      style: TextStyle(
                        height: 0.8,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'cart',
                      style: TextStyle(
                        height: 0.8,
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 3.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
