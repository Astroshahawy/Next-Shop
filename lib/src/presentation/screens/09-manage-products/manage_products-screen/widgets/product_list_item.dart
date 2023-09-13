import 'package:cached_network_image/cached_network_image.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5,
            offset: Offset.fromDirection(90.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            child: ListTile(
              title: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(
                context, AppRoutes.addProductScreen,
                arguments: AddProductArguments(isEdit: true, product: product)),
            icon: Icon(
              Icons.edit_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () async {
              context.loaderOverlay.show(
                widget: const LoadingSpinningCircle(color: Colors.white),
              );
              await ManageProductsCubit.get(context).deleteProduct(product.id);
              if (context.mounted) context.loaderOverlay.hide();
            },
            icon: Icon(
              Icons.delete_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

class AddProductArguments {
  final bool isEdit;
  final Product? product;

  AddProductArguments({
    required this.isEdit,
    this.product,
  });
}
