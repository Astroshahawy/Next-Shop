import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_shop_app/constants/strings.dart';
import 'package:next_shop_app/presentation/screens/04-categories-screen/category_container.dart';
import 'package:next_shop_app/presentation/screens/04-categories-screen/category_title.dart';
import 'package:next_shop_app/presentation/screens/04-categories-screen/cubit/categories_cubit.dart';
import 'package:next_shop_app/presentation/widgets/default_app_bar.dart';
import 'package:next_shop_app/presentation/widgets/floating_search_bar.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class CategoriesScreen extends StatefulWidget {
  final Widget drawer;
  const CategoriesScreen({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      body: Stack(
        children: [
          Column(
            children: [
              const DefaultAppBar(
                pageTitle: 'Categories',
              ),
              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return LoadingSpinningCircle(
                          color: Theme.of(context).primaryColor);
                    }
                    if (state is CategoriesLoaded) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                categoryScreen,
                                arguments: 'all products',
                              ),
                              child: const CategoryContainer(
                                child: CategoryTitle(
                                  text: 'all products',
                                ),
                              ),
                            );
                          }
                          final category = state.categories[index - 1];
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              categoryScreen,
                              arguments: category,
                            ),
                            child: CategoryContainer(
                              child: CategoryTitle(text: category),
                            ),
                          );
                        },
                        itemCount: state.categories.length + 1,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
          const FloatingSearchBar(),
        ],
      ),
    );
  }
}
