import 'package:flutter/material.dart';

import 'package:next_shop_app/constants/strings.dart';

class DefaultAppBar extends StatelessWidget {
  final String pageTitle;
  final bool isShortBar;
  // final bool showCart;
  final bool showDrawer;

  const DefaultAppBar({
    Key? key,
    required this.pageTitle,
    this.isShortBar = false,
    // this.showCart = false,
    this.showDrawer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isShortBar)
          Container(
            height: MediaQuery.of(context).viewPadding.top,
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
          ),
        Container(
          height: isShortBar ? 70.0 : 120.0,
          width: double.infinity,
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
          child: Stack(
            children: [
              Positioned(
                right: 0.0,
                left: 0.0,
                top: isShortBar ? 0.0 : 25.0,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Next',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const TextSpan(
                        text: 'Shop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      if (!showDrawer)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(20.0),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (showDrawer)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
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
                        ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          pageTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      // if (showCart)
                      //   Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: GestureDetector(
                      //       onTap: () =>
                      //           Navigator.pushNamed(context, cartScreen),
                      //       child: Container(
                      //         color: Colors.transparent,
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: const Icon(
                      //           Icons.shopping_cart,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
