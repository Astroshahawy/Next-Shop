import 'package:flutter/material.dart';
import 'package:next_shop_app/data/models/user.dart';
import 'package:next_shop_app/helpers/title_capitalization.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PERSONAL INFORMATION',
            style: TextStyle(
              color: Colors.grey[700],
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'First Name',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            titleCapitalize(user.name.firstname),
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Divider(
            height: 30.0,
            thickness: 1.0,
          ),
          Text(
            'Last Name',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            titleCapitalize(user.name.lastname),
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Divider(
            height: 30.0,
            thickness: 1.0,
          ),
          Text(
            'Phone Number',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            user.phone,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const Divider(
            height: 30.0,
            thickness: 1.0,
          ),
          Text(
            'ADDRESS',
            style: TextStyle(
              color: Colors.grey[700],
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'City',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            titleCapitalize(user.address.city),
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Street',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            titleCapitalize(user.address.street),
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Number',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            user.address.number.toString(),
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Zipcode',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            user.address.zipcode,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
