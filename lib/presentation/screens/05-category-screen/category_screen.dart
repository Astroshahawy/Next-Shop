import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_shop_app/constants/strings.dart';
import 'package:next_shop_app/helpers/title_capitalization.dart';
import 'package:next_shop_app/presentation/screens/05-category-screen/cubit/category_cubit.dart';
import 'package:next_shop_app/presentation/widgets/product_item.dart';

import 'package:next_shop_app/presentation/widgets/default_app_bar.dart';
import 'package:next_shop_app/presentation/widgets/floating_search_bar.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryTitle;

  const CategoryScreen({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCubit>(context).getCategory(widget.categoryTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              DefaultAppBar(
                pageTitle: titleCapitalize(widget.categoryTitle),
                showDrawer: false,
              ),
              Expanded(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return LoadingSpinningCircle(
                          color: Theme.of(context).primaryColor);
                    } else if (state is CategoryLoaded) {
                      final length = state.products.length;
                      final isShortList = length <= 10;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isShortList ? 1 : 2,
                          crossAxisSpacing: isShortList ? 0.0 : 20.0,
                          mainAxisSpacing: isShortList ? 20.0 : 10.0,
                          childAspectRatio: isShortList ? 4 / 3 : 2 / 3,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 50.0,
                          horizontal: 30.0,
                        ),
                        itemCount: length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                productScreen,
                                arguments: product,
                              );
                            },
                            child: ProductItem(
                              price: product.price.toStringAsFixed(2),
                              imageUrl: product.image,
                              productName: product.title,
                              isShortList: isShortList,
                            ),
                          );
                          // return OpenContainer(
                          //   transitionType: ContainerTransitionType.fade,
                          //   closedBuilder: (context, openContainer) {
                          //     return GestureDetector(
                          //       onTap: openContainer,
                          //       child: ProductItem(
                          //         price: product.price
                          //             .toStringAsFixed(2),
                          //         imageUrl: product.image,
                          //         productName: product.title,
                          //       ),
                          //     );
                          //   },
                          //   openBuilder: (context, _) {
                          //     return ProductDetails(product: product);
                          //   },
                          // );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
          const FloatingSearchBar(),
        ],
      ),
    );
  }
}
