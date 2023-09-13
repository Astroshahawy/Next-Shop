import 'package:next_shop_app/src/presentation/screens/02-home-screen/cubit/home_screen_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/carousel_container.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/categories_container.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/featured_container.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/home_screen_app_bar.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/new_arrivals_container.dart';

import 'package:next_shop_app/src/presentation/widgets/floating_search_bar.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Column(
            children: [
              const HomeScreenAppBar(),
              Expanded(
                child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                    if (state is HomeScreenLoading) {
                      return LoadingSpinningCircle(
                          color: Theme.of(context).primaryColor);
                    } else if (state is HomeScreenLoaded) {
                      return RefreshIndicator(
                        onRefresh: () =>
                            BlocProvider.of<HomeScreenCubit>(context)
                                .getHomeData(),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 50.0),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              CarouselContainer(
                                productList: state.carouselProducts,
                              ),
                              const SizedBox(height: 40.0),
                              CategoriesContainer(
                                categories: state.categories,
                              ),
                              const SizedBox(height: 40.0),
                              FeaturedContainer(
                                products: state.featuredProducts,
                              ),
                              const SizedBox(height: 40.0),
                              NewArrivalsContainer(products: state.newProducts),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
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
