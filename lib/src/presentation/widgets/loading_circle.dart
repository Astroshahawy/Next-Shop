import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinningCircle extends StatelessWidget {
  final Color color;
  const LoadingSpinningCircle({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningCircle(
        size: 40.0,
        color: color,
      ),
    );
  }
}
