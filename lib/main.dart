import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:next_shop_app/presentation/routes/app_router.dart';

import 'app.dart';

void main() {
  runApp(
    Phoenix(
      child: MyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
