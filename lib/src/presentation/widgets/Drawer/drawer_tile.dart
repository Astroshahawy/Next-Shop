// import 'package:badges/badges.dart';
import 'package:next_shop_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_shop_app/src/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String pageTitle;
  final bool showCartCount;
  const DrawerTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.pageTitle,
    this.showCartCount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int cartQuantity = context.read<CartCubit>().totalQuantity;
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
          ),
          if (showCartCount && cartQuantity > 0)
            Badge(
              backgroundColor: Colors.orange.shade600,
              // elevation: 0,
              // toAnimate: false,
              // shape: BadgeShape.square,
              // borderRadius: BorderRadius.circular(100.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              largeSize: 30,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              label: Text(
                cartQuantity.toString(),
              ),
            ),
        ],
      ),
      leading: Icon(
        icon,
        size: 30.0,
        color: Colors.orange.shade600,
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        Navigator.pop(context);
        bool isNewRouteSameAsCurrent = false;
        final currentPageName = ModalRoute.of(context)!.settings.name;
        Navigator.popUntil(context, (route) {
          if (route.settings.name == pageTitle) {
            isNewRouteSameAsCurrent = true;
          }
          return true;
        });

        if (!isNewRouteSameAsCurrent &&
            currentPageName == AppRoutes.initRoute) {
          Navigator.pushNamed(context, pageTitle);
        }

        if (!isNewRouteSameAsCurrent && pageTitle == AppRoutes.initRoute) {
          Navigator.pop(context);
        }

        if (!isNewRouteSameAsCurrent &&
            currentPageName != AppRoutes.initRoute &&
            pageTitle != AppRoutes.initRoute) {
          Navigator.pushReplacementNamed(context, pageTitle);
        }
      },
    );
  }
}
