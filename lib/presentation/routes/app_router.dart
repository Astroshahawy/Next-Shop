import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:next_shop_app/constants/strings.dart';
import 'package:next_shop_app/data/api/api.dart';
import 'package:next_shop_app/data/models/product.dart';
import 'package:next_shop_app/data/repositories/repository.dart';
import 'package:next_shop_app/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/presentation/screens/01-login-screen/login_screen.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/cubit/home_screen_cubit.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/home_screen.dart';
import 'package:next_shop_app/presentation/screens/03-product-screen/product_details_screen.dart';
import 'package:next_shop_app/presentation/screens/04-categories-screen/categories_screen.dart';
import 'package:next_shop_app/presentation/screens/04-categories-screen/cubit/categories_cubit.dart';
import 'package:next_shop_app/presentation/screens/05-category-screen/category_screen.dart';
import 'package:next_shop_app/presentation/screens/05-category-screen/cubit/category_cubit.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/cart_screen.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/presentation/screens/07-orders-screen/cubit/orders_cubit.dart';
import 'package:next_shop_app/presentation/screens/07-orders-screen/orders_screen.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/cubit/user_cubit.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/user_screen.dart';
import 'package:next_shop_app/presentation/widgets/Drawer/drawer.dart';

class AppRouter {
  late ApiRepository apiRepository;
  late Widget appDrawer;

  AppRouter() {
    apiRepository = ApiRepository(ApiServices());
    appDrawer = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(apiRepository),
        ),
        BlocProvider(
          create: (context) => LoginCubit(apiRepository),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: const LoaderOverlay(
        child: AppDrawer(),
      ),
    );
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HomeScreenCubit(apiRepository),
              ),
              BlocProvider(
                create: (context) => CartCubit(),
              ),
              BlocProvider(
                create: (context) => LoginCubit(apiRepository),
              ),
              BlocProvider(
                create: (context) => UserCubit(apiRepository),
              ),
            ],
            child: HomeScreen(
              drawer: appDrawer,
            ),
          ),
        );
      case loginScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(apiRepository),
            child: const LoginScreen(),
          ),
        );
      case productScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            final product = settings.arguments as Product;
            return BlocProvider(
              create: (context) => CartCubit(),
              child: LoaderOverlay(
                child: ProductDetails(
                  product: product,
                ),
              ),
            );
          },
        );
      case allCategoriesScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider(
              create: (context) => CategoriesCubit(apiRepository),
              child: CategoriesScreen(
                drawer: appDrawer,
              ),
            );
          },
        );
      case categoryScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            final categoryTitle = settings.arguments as String;
            return BlocProvider(
              create: (context) => CategoryCubit(apiRepository),
              child: CategoryScreen(categoryTitle: categoryTitle),
            );
          },
        );
      case cartScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CartCubit(),
                ),
                BlocProvider(
                  create: (context) => LoginCubit(apiRepository),
                ),
              ],
              child: LoaderOverlay(
                child: CartScreen(
                  drawer: appDrawer,
                ),
              ),
            );
          },
        );
      case ordersScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider(
              create: (context) => OrdersCubit(
                apiRepository,
              ),
              child: OrdersScreen(
                drawer: appDrawer,
              ),
            );
          },
        );
      case userScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserCubit(apiRepository),
                ),
                BlocProvider(
                  create: (context) => LoginCubit(apiRepository),
                ),
              ],
              child: const UserScreen(),
            );
          },
        );
    }
  }
}
