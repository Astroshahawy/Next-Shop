import 'package:flutter/material.dart';
import 'package:next_shop_app/src/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubtotalContainer extends StatelessWidget {
  const SubtotalContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            wordSpacing: 1.5,
            color: Colors.grey[900],
            fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
          ),
          children: [
            const TextSpan(
              text: 'Subtotal ',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            const TextSpan(
              text: 'USD ',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            TextSpan(
              text: context.watch<CartCubit>().totalCost.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
