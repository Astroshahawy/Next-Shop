import 'package:flutter/material.dart';
import 'package:next_shop_app/src/data/models/product.dart';

class IndRow extends StatelessWidget {
  const IndRow({
    Key? key,
    required this.shortProductList,
    required int current,
  })  : _current = current,
        super(key: key);

  final List<Product> shortProductList;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: shortProductList.asMap().entries.map(
        (entry) {
          return Container(
            width: 60.0,
            height: 3.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color:
                  Colors.white.withOpacity(_current == entry.key ? 1.0 : 0.4),
            ),
          );
        },
      ).toList(),
    );
  }
}
