import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:next_shop_app/data/models/cart_product.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 55.0,
            backgroundColor: Colors.white,
            child: CachedNetworkImage(
              imageUrl: cartProduct.image,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartProduct.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'USD ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[900],
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1!.fontFamily,
                        ),
                      ),
                      TextSpan(
                        text: cartProduct.price.toStringAsFixed(2),
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1!.fontFamily,
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                ButtonsRow(cartProduct: cartProduct),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => BlocProvider.of<CartCubit>(context)
                        .decreaseItemCount(cartProduct),
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: const Border(
                          right: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.minus,
                        size: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    cartProduct.quantity.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => BlocProvider.of<CartCubit>(context)
                        .increaseItemCount(cartProduct),
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: const Border(
                          left: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.plus,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DeleteButton(cartProduct: cartProduct),
      ],
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.cartProduct,
  }) : super(key: key);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.loaderOverlay.show(
          widget: const LoadingSpinningCircle(color: Colors.white),
        );
        await BlocProvider.of<CartCubit>(context).deleteItem(cartProduct);
        context.loaderOverlay.hide();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        child: const Text('Delete'),
      ),
    );
  }
}
