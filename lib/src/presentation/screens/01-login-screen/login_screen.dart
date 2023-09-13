import 'package:next_shop_app/src/presentation/screens/01-login-screen/login_container.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginContainer(),
    );
  }
}
