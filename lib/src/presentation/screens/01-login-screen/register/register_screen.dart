import 'package:next_shop_app/src/presentation/screens/01-login-screen/register/register_container.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterContainer(),
    );
  }
}
