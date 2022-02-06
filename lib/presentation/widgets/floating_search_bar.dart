import 'package:flutter/material.dart';

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
        child: const TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'What are you looking for?',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.search,
              size: 28.0,
            ),
          ),
        ),
      ),
    );
  }
}
