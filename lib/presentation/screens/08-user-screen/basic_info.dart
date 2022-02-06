import 'package:flutter/material.dart';
import 'package:next_shop_app/data/models/user.dart';
import 'package:next_shop_app/helpers/title_capitalization.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${titleCapitalize('${user.name.firstname} ${user.name.lastname}')} ',
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
