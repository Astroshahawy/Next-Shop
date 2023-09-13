import 'package:next_shop_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:next_shop_app/src/presentation/screens/01-login-screen/cubit/login_cubit.dart';

import 'package:next_shop_app/src/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final isAuth = context.read<LoginCubit>().userAuthStatus;
        if (isAuth) {
          context.loaderOverlay.show(
            widget: const LoadingSpinningCircle(color: Colors.white),
          );
          await context.read<CartCubit>().clearCart();
          if (context.mounted) context.loaderOverlay.hide();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                    'Checkout completed.. your order will be delieverd soon.'),
              ),
            );
          }
        } else {
          Navigator.pushNamed(context, AppRoutes.loginScreen);
        }
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.amber[300],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              offset: Offset.fromDirection(90.0),
            ),
          ],
        ),
        child: Text(
          'Proceed to checkout (${context.watch<CartCubit>().totalQuantity} items)',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
