import 'package:flutter/material.dart';
import 'package:next_shop_app/presentation/screens/01-login-screen/login_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginContainer(),
    );
  }
}
