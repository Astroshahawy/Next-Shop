import 'package:next_shop_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class ManageProductsTile extends StatelessWidget {
  const ManageProductsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.manageProductsScreen),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        color: Colors.white,
        child: const ListTile(
          leading: Icon(Icons.miscellaneous_services_rounded),
          title: Text(
            'Manage Products',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
