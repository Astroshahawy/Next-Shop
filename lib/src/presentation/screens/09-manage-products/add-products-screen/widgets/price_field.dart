import 'package:next_shop_app/core/themes/app_colors.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/field_section.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  const PriceField({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      title: 'Price',
      isMarginLeft: false,
      child: TextFormField(
        controller: ManageProductsCubit.get(context).productPriceController,
        keyboardType: TextInputType.number,
        cursorColor: AppLightColors.defaultColor,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Product price',
          hintStyle: TextStyle(
            fontSize: 14,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
