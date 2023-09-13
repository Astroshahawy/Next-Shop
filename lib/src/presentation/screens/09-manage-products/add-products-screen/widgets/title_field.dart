import 'package:next_shop_app/core/themes/app_colors.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/field_section.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      title: 'Title',
      child: TextFormField(
        controller: ManageProductsCubit.get(context).productTitleController,
        keyboardType: TextInputType.name,
        cursorColor: AppLightColors.defaultColor,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Product title',
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
