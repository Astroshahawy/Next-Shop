import 'package:next_shop_app/core/utils/mac_alert_dialog.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/category_field.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/description_field.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/image_field.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/price_field.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/title_field.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';
import 'package:flutter/material.dart';

import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/presentation/widgets/default_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    Key? key,
    required this.isEdit,
    this.product,
  }) : super(key: key);

  final bool isEdit;
  final Product? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    if (widget.isEdit) {
      ManageProductsCubit.get(context).fetchProductInfo(widget.product!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ManageProductsCubit.get(context).clear();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<ManageProductsCubit, ManageProductsState>(
                builder: (context, state) {
              return Column(
                children: [
                  DefaultAppBar(
                    pageTitle: widget.isEdit ? 'Edit Product' : 'Add Product',
                    isShortBar: true,
                    showDrawer: false,
                  ),
                  const SizedBox.square(dimension: 30),
                  ImageField(product: widget.product),
                  const SizedBox.square(dimension: 30),
                  const TitleField(),
                  const SizedBox.square(dimension: 20),
                  Row(
                    children: const [
                      Flexible(
                        flex: 3,
                        child: CategoryField(),
                      ),
                      SizedBox.square(dimension: 20),
                      Flexible(
                        flex: 2,
                        child: PriceField(),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 20),
                  const DescriptionField(),
                  const SizedBox.square(dimension: 200),
                  BlocConsumer<ManageProductsCubit, ManageProductsState>(
                      listener: (context, state) {
                    if (state is SubmitLoadedState) {
                      macAlertDialog(context, 'Submitting Completed')
                          .whenComplete(() {
                        Navigator.pop(context);
                        ManageProductsCubit.get(context).clear();
                      });
                    }
                  }, builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      height: 50.0,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          widget.isEdit
                              ? await ManageProductsCubit.get(context)
                                  .editProduct(widget.product!)
                              : await ManageProductsCubit.get(context)
                                  .addProduct();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: state is SubmitLoadingState
                            ? const LoadingSpinningCircle(color: Colors.white)
                            : const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  }),
                  const SizedBox.square(dimension: 20),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
