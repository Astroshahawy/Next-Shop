import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/core/utils/title_capitalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_shop_app/src/presentation/screens/05-category-screen/cubit/category_cubit.dart';
import 'package:next_shop_app/src/presentation/widgets/product_item.dart';

import 'package:next_shop_app/src/presentation/widgets/default_app_bar.dart';
import 'package:next_shop_app/src/presentation/widgets/floating_search_bar.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                DefaultAppBar(
                  pageTitle: titleCapitalize(widget.categoryTitle),
                  showDrawer: false,
                ),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (context.watch<CategoryCubit>().isFirstFetch) {
                      return Expanded(
                        child: LoadingSpinningCircle(
                            color: Theme.of(context).primaryColor),
                      );
                    } else {
                      final length =
                          context.read<CategoryCubit>().products.length;
                      final isShortList = length <= 6;
                      return Expanded(
                        child: Column(
                          children: [
                            const SizedBox.square(
                              dimension: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (BlocProvider.of<CategoryCubit>(context)
                                    .isAllProducts) ...[
                                  const SizedBox.square(dimension: 30),
                                  TextButton.icon(
                                      onPressed: () {
                                        context
                                            .read<CategoryCubit>()
                                            .loadMore();
                                      },
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Load more')),
                                  const Spacer(),
                                ],
                                DropdownButton<String>(
                                  icon: Row(
                                    children: const [
                                      Text('Sort'),
                                      SizedBox.square(dimension: 5),
                                      Icon(Icons.sort_rounded),
                                    ],
                                  ),
                                  underline: const SizedBox(),
                                  items: context
                                      .read<CategoryCubit>()
                                      .dropdown
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) => context
                                      .read<CategoryCubit>()
                                      .sortItems(value!),
                                ),
                                const SizedBox.square(dimension: 30),
                              ],
                            ),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isShortList ? 1 : 2,
                                  crossAxisSpacing: isShortList ? 0.0 : 20.0,
                                  mainAxisSpacing: isShortList ? 20.0 : 10.0,
                                  childAspectRatio: isShortList ? 4 / 3 : 2 / 3,
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 60),
                                itemCount: length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final product = context
                                      .read<CategoryCubit>()
                                      .products[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.productScreen,
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
                                },
                              ),
                            ),
                            if (context.read<CategoryCubit>().isLoading)
                              Column(
                                children: [
                                  LoadingSpinningCircle(
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(height: 15),
                                ],
                              ),
                          ],
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            const FloatingSearchBar(),
          ],
        ),
      ),
    );
  }
}
