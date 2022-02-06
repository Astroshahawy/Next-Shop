import 'package:flutter/material.dart';

import 'package:next_shop_app/constants/strings.dart';
import 'package:next_shop_app/helpers/title_capitalization.dart';

class CategoriesContainer extends StatelessWidget {
  final List<String> categories;
  const CategoriesContainer({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, allCategoriesScreen),
              child: const Text(
                'View All >',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  categoryScreen,
                  arguments: category,
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0.0 : 5.0,
                    right: index == categories.indexOf(categories.last)
                        ? 0.0
                        : 5.0,
                  ),
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.amber[300]!,
                        Colors.orange[600]!,
                      ],
                    ),
                  ),
                  child: Text(
                    titleCapitalize(category),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
