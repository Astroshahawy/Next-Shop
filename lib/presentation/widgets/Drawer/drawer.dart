import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:next_shop_app/constants/strings.dart';
import 'package:next_shop_app/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/cubit/user_cubit.dart';
import 'package:next_shop_app/presentation/widgets/Drawer/about_tile.dart';
import 'package:next_shop_app/presentation/widgets/Drawer/drawer_tile.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAuth = context.watch<LoginCubit>().userAuthStatus;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.top + 160.0,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.amber.shade300,
                  Colors.orange.shade600,
                ],
              ),
              border: Border(
                bottom: Divider.createBorderSide(context),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Next',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const TextSpan(
                        text: 'Shop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Text(
                  isAuth
                      ? context.read<UserCubit>().username
                      : 'Welcome Customer',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          ListBody(
            children: const [
              DrawerTile(
                title: 'Home',
                icon: Icons.home_rounded,
                pageTitle: initRoute,
              ),
              Divider(
                height: 0.0,
                thickness: 1.0,
              ),
              DrawerTile(
                title: 'Categories',
                icon: Icons.category_rounded,
                pageTitle: allCategoriesScreen,
              ),
              Divider(
                height: 0.0,
                thickness: 1.0,
              ),
              DrawerTile(
                title: 'Cart',
                icon: Icons.shopping_cart_rounded,
                pageTitle: cartScreen,
                showCartCount: true,
              ),
              Divider(
                height: 0.0,
                thickness: 1.0,
              ),
            ],
          ),
          const DrawerTile(
            icon: Icons.person_rounded,
            title: 'Profile',
            pageTitle: userScreen,
          ),
          const Divider(
            height: 0.0,
            thickness: 1.0,
          ),
          const AboutTile(),
          const Divider(
            height: 0.0,
            thickness: 1.0,
          ),
          const Spacer(),
          const Divider(
            height: 0.0,
            thickness: 1.0,
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            title: Text(
              isAuth ? 'Logout' : 'Sign in',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            leading: Icon(
              isAuth ? Icons.logout_rounded : Icons.login_rounded,
              color: isAuth ? Colors.orange.shade600 : null,
              size: 30.0,
            ),
            trailing: const Icon(Icons.arrow_right),
            onTap: () async {
              if (isAuth) {
                context.loaderOverlay.show(
                  widget: const LoadingSpinningCircle(color: Colors.white),
                );
                await context.read<LoginCubit>().logout();
                await context.read<LoginCubit>().userAuth();
                context.loaderOverlay.hide();
                Phoenix.rebirth(context);
              } else {
                Navigator.popAndPushNamed(context, loginScreen);
              }
            },
          ),
        ],
      ),
    );
  }
}
