import 'package:next_shop_app/core/themes/app_colors.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/field_section.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      title: 'Description',
      isDescription: true,
      child: TextFormField(
        controller:
            ManageProductsCubit.get(context).productDescriptionController,
        keyboardType: TextInputType.name,
        cursorColor: AppLightColors.defaultColor,
        maxLines: 5,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Product description',
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
