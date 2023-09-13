import 'package:cached_network_image/cached_network_image.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/image_container.dart';
import 'package:flutter/material.dart';

import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/image_helper.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';

class ImageField extends StatelessWidget {
  const ImageField({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 150,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            if (product == null)
              !ManageProductsCubit.get(context).imageUploaded
                  ? ImageContainer(
                      child: Image.asset('assets/icon.png'),
                    )
                  : ImageContainer(
                      child: Image.file(
                          ManageProductsCubit.get(context).productImage),
                    ),
            if (product != null)
              !ManageProductsCubit.get(context).imageUploaded
                  ? ImageContainer(
                      child: CachedNetworkImage(
                        imageUrl: product!.image,
                        fit: BoxFit.contain,
                      ),
                    )
                  : ImageContainer(
                      child: Image.file(
                          ManageProductsCubit.get(context).productImage),
                    ),
            Positioned(
              bottom: 0,
              right: -25,
              child: MaterialButton(
                onPressed: () {
                  ImageHelper().selectImageOperation(context);
                },
                elevation: 2.0,
                color: Colors.white,
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
