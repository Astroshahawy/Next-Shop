import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:next_shop_app/core/injection/injector.dart';
import 'package:next_shop_app/core/routes/app_router.dart';
import 'package:next_shop_app/core/themes/app_themes.dart';
import 'package:next_shop_app/src/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/cubit/home_screen_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/04-categories-screen/cubit/categories_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/05-category-screen/cubit/category_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/07-user-screen/cubit/user_cubit.dart';
import 'package:next_shop_app/src/presentation/screens/08-orders-screen/cubit/orders_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          lazy: false,
          create: (context) => getIt<LoginCubit>()..userAuth(),
        ),
        BlocProvider<HomeScreenCubit>(
          create: (context) => getIt<HomeScreenCubit>()..getHomeData(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => getIt<CategoriesCubit>(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => getIt<CategoryCubit>(),
        ),
        BlocProvider<OrdersCubit>(
          create: (context) => getIt<OrdersCubit>(),
        ),
        BlocProvider<CartCubit>(
          lazy: false,
          create: (context) => getIt<CartCubit>()..loadCartProducts(),
        ),
        BlocProvider<UserCubit>(
          lazy: false,
          create: (context) => getIt<UserCubit>()..getDrawerBasicInfo(),
        ),
        BlocProvider<ManageProductsCubit>(
          create: (context) => getIt<ManageProductsCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Next Shop',
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        onGenerateRoute: AppRouter().generateRoutes,
      ),
    );
  }
}
