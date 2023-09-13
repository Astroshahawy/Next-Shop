import 'package:next_shop_app/core/injection/injector.dart';
import 'package:next_shop_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();

  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}