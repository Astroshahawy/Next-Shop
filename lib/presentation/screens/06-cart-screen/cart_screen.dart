import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_shop_app/presentation/screens/06-cart-screen/cart_item.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/checkout_button.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/empty_cart_display.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/subtotal_container.dart';
import 'package:next_shop_app/presentation/widgets/default_app_bar.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class CartScreen extends StatefulWidget {
  final Widget drawer;
  const CartScreen({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        drawer: widget.drawer,
        body: Column(
          children: [
            const DefaultAppBar(
              pageTitle: 'Cart',
              isShortBar: true,
            ),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return LoadingSpinningCircle(
                        color: Theme.of(context).primaryColor);
                  }
                  if (state is CartLoaded) {
                    if (state.cartProducts.isEmpty) {
                      return const EmptyCartDisplay();
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SubtotalContainer(),
                        const CheckoutButton(),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                thickness: 2.0,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              itemCount: state.cartProducts.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final cartProduct =
                                    state.cartProducts.reversed.toList()[index];
                                return CartItem(cartProduct: cartProduct);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
