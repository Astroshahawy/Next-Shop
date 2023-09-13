import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

class EmptyCartDisplay extends StatelessWidget {
  const EmptyCartDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/empty_cart.svg',
          width: MediaQuery.of(context).size.width * 0.5,
          placeholderBuilder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: LoadingSpinningCircle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        Text(
          'Cart is empty',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30.0,
            letterSpacing: 1.3,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          'Make sure to add some products',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14.0,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
