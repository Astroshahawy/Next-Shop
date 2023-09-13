import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    Key? key,
    required this.imageUrl,
    required this.productName,
  }) : super(key: key);

  final String imageUrl;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CachedNetworkImage(
              width: double.infinity,
              alignment: Alignment.topCenter,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.orange.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        blurRadius: 5,
                        offset: Offset.fromDirection(90),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'See more >',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.amber,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        blurRadius: 5,
                        offset: Offset.fromDirection(90),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
