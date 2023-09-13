import 'package:cached_network_image/cached_network_image.dart';
import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/src/data/models/product.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 95.0,
      left: 0.0,
      right: 0.0,
      height: 50.0,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              offset: Offset.fromDirection(90.0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TypeAheadField<Product>(
          animationStart: 0,
          animationDuration: const Duration(seconds: 0),
          suggestionsBoxVerticalOffset: 10,
          hideOnEmpty: true,
          keepSuggestionsOnLoading: true,
          hideSuggestionsOnKeyboardHide: false,
          noItemsFoundBuilder: (context) => const SizedBox(),
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            hasScrollbar: false,
          ),
          textFieldConfiguration: const TextFieldConfiguration(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Colors.black54,
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What are you looking for?',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              prefixIcon: Icon(
                Icons.search,
                size: 28.0,
              ),
            ),
          ),
          debounceDuration: const Duration(milliseconds: 100),
          suggestionsCallback: (pattern) async =>
              await context.read<HomeScreenCubit>().searchProduct(pattern),
          itemBuilder: (context, suggestion) {
            final product = suggestion;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                minLeadingWidth: 10,
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          },
          onSuggestionSelected: (suggestion) {
            FocusScope.of(context).unfocus();
            Navigator.pushNamed(
              context,
              AppRoutes.productScreen,
              arguments: suggestion,
            );
            // context.loaderOverlay.show(
            //   widget: const Center(
            //     child: CircularProgressIndicator(
            //       color: Colors.white,
            //     ),
            //   ),
            // );
            // context.loaderOverlay.hide();
            // Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
