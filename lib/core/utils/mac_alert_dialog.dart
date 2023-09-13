import 'package:next_shop_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

Future macAlertDialog(BuildContext context, String message) async {
  await showMacosAlertDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppLightColors.backgroundColor,
        title: const Text(
          'Success!',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: AppLightColors.defaultColor,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                color: AppLightColors.defaultColor,
                letterSpacing: 0.5,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 70,
        ),
      );
    },
  );
}
