import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 120.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.amber.shade300,
            Colors.orange.shade600,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(20.0),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Next',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const TextSpan(
                    text: 'Shop',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
