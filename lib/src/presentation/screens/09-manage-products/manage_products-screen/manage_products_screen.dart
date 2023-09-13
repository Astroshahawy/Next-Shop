import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/manage_products-screen/widgets/product_list_item.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';
import 'package:flutter/material.dart';

import 'package:next_shop_app/src/presentation/widgets/default_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  @override
  void initState() {
    ManageProductsCubit.get(context).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DefaultAppBar(
            pageTitle: 'Manage Products',
            isShortBar: true,
            showDrawer: false,
            isAddProduct: true,
          ),
          BlocBuilder<ManageProductsCubit, ManageProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return Expanded(
                  child: Center(
                    child: LoadingSpinningCircle(
                        color: Theme.of(context).primaryColor),
                  ),
                );
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () =>
                      ManageProductsCubit.get(context).getProducts(),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                    itemCount: ManageProductsCubit.get(context).products.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product =
                          ManageProductsCubit.get(context).products[index];
                      return ProductListItem(product: product);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
