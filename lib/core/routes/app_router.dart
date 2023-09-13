import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/presentation/screens/01-login-screen/login_screen.dart';
import 'package:next_shop_app/src/presentation/screens/01-login-screen/register/register_screen.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/home_screen.dart';
import 'package:next_shop_app/src/presentation/screens/03-product-screen/product_details_screen.dart';
import 'package:next_shop_app/src/presentation/screens/04-categories-screen/categories_screen.dart';
import 'package:next_shop_app/src/presentation/screens/05-category-screen/category_screen.dart';
import 'package:next_shop_app/src/presentation/screens/06-cart-screen/cart_screen.dart';
import 'package:next_shop_app/src/presentation/screens/07-user-screen/user_screen.dart';
import 'package:next_shop_app/src/presentation/screens/08-orders-screen/orders_screen.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/add_product_screen.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/manage_products-screen/manage_products_screen.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/manage_products-screen/widgets/product_list_item.dart';
import 'package:next_shop_app/src/presentation/widgets/Drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppRouter {
  final Widget appDrawer = const LoaderOverlay(
    child: AppDrawer(),
  );

  Route? generateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case AppRoutes.ordersScreen:
            return OrdersScreen(
              drawer: appDrawer,
            );
          case AppRoutes.manageProductsScreen:
            return const LoaderOverlay(
              child: ManageProductsScreen(),
            );
          case AppRoutes.addProductScreen:
            final arguments = settings.arguments as AddProductArguments;
            return LoaderOverlay(
              child: AddProductScreen(
                isEdit: arguments.isEdit,
                product: arguments.product,
              ),
            );
          case AppRoutes.userScreen:
            return const UserScreen();
          case AppRoutes.cartScreen:
            return LoaderOverlay(
              child: CartScreen(
                drawer: appDrawer,
              ),
            );
          case AppRoutes.categoryScreen:
            final categoryTitle = settings.arguments as String;
            return CategoryScreen(categoryTitle: categoryTitle);
          case AppRoutes.allCategoriesScreen:
            return CategoriesScreen(
              drawer: appDrawer,
            );
          case AppRoutes.productScreen:
            final product = settings.arguments as Product;
            return LoaderOverlay(
              child: ProductDetails(
                product: product,
              ),
            );
          case AppRoutes.loginScreen:
            return const LoginScreen();
          case AppRoutes.registerScreen:
            return const RegisterScreen();
          case AppRoutes.initRoute:
          default:
            return HomeScreen(
              drawer: appDrawer,
            );
        }
      },
    );
  }
}
