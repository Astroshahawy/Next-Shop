import 'package:next_shop_app/core/utils/title_capitalization.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/add-products-screen/widgets/field_section.dart';
import 'package:next_shop_app/src/presentation/screens/09-manage-products/cubit/manage_products_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({super.key});

  @override
  Widget build(BuildContext context) {
    return FieldSection(
      title: 'Category',
      isMarginRight: false,
      child: DropdownButtonFormField(
        onChanged: (String? value) =>
            ManageProductsCubit.get(context).categoryValue = value,
        elevation: 4,
        dropdownColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(
          ManageProductsCubit.get(context).categoryValue!.isEmpty
              ? 'Select Category'
              : ManageProductsCubit.get(context).categoryValue!,
          style: const TextStyle(
            fontSize: 14,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        icon: Icon(
          CupertinoIcons.chevron_down,
          color: Colors.grey.shade400,
        ),
        items: ManageProductsCubit.get(context).categories.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              titleCapitalize(value),
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
