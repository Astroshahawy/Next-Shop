import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.price,
    required this.productName,
    this.isShortList = false,
    this.isHomeScreen = false,
  }) : super(key: key);

  final String imageUrl;
  final String price;
  final String productName;
  final bool isShortList;
  final bool isHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.5,
                offset: Offset.fromDirection(90.0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: isHomeScreen ? UniqueKey() : imageUrl,
                child: CachedNetworkImage(
                  height: isHomeScreen ? 130.0 : 180.0,
                  imageUrl: imageUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: isShortList
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign:
                          isShortList ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        fontSize: isShortList ? 16.0 : 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'USD ',
                            style: TextStyle(
                              fontSize: isShortList ? 14.0 : 12.0,
                              color: Colors.black,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                            ),
                          ),
                          TextSpan(
                            text: price,
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontFamily,
                              fontSize: isShortList ? 18.0 : 16.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const FavoriteCircle(),
      ],
    );
  }
}

class FavoriteCircle extends StatefulWidget {
  const FavoriteCircle({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteCircle> createState() => _FavoriteCircleState();
}

class _FavoriteCircleState extends State<FavoriteCircle> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset.fromDirection(90, 2),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isFav = !isFav;
            });
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            ),
          ),
        ),
      ),
    );
  }
}
