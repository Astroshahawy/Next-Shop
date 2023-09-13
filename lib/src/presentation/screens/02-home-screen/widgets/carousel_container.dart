import 'package:carousel_slider/carousel_slider.dart';
import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/carousel_item.dart';
import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/indicator_row.dart';
import 'package:flutter/material.dart';
import 'package:next_shop_app/src/data/models/product.dart';

class CarouselContainer extends StatefulWidget {
  final List<Product> productList;
  const CarouselContainer({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  State<CarouselContainer> createState() => _CarouselContainerState();
}

class _CarouselContainerState extends State<CarouselContainer> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.productList.length,
            itemBuilder: (context, index, pIndex) {
              final product = widget.productList[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.productScreen,
                  arguments: product,
                ),
                child: CarouselItem(
                  imageUrl: product.image,
                  productName: product.title,
                ),
              );
            },
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 1.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 1600),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 5.0,
          left: 0.0,
          right: 0.0,
          child: IndRow(
            shortProductList: widget.productList,
            current: _current,
          ),
        ),
      ],
    );
  }
}
