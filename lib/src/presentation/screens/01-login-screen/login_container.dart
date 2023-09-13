import 'package:next_shop_app/core/constants/constants.dart';
import 'package:next_shop_app/src/presentation/screens/07-user-screen/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:next_shop_app/src/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  late String userName;
  // late String userPassword;

  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context).tryGetUserData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade600,
              Colors.amber.shade300,
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is UserDataLoading) {
              return const LoadingSpinningCircle(color: Colors.white);
            }
            if (state is UserDataLoaded) {
              userName = state.username;
              PasswordField.userPassword = state.password;

              _usernameController = TextEditingController(text: userName);
              _usernameController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _usernameController.text.length));
              _passwordController =
                  TextEditingController(text: PasswordField.userPassword);
              _passwordController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _passwordController.text.length));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/login.svg',
                  width: deviceSize.width * 0.8,
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const LoadingSpinningCircle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.1),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormFieldContainer(
                        child: TextFormField(
                          key: const ValueKey('username'),
                          controller: _usernameController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'Username is: johnd',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(
                              0.0,
                              10.0,
                              20.0,
                              10.0,
                            ),
                          ),
                          onSaved: (value) {
                            userName = value!;
                          },
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.02),
                      FormFieldContainer(
                        child: PasswordField(
                          passwordController: _passwordController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.05),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        _formKey.currentState!.save();
                        FocusScope.of(context).unfocus();
                        await context.read<LoginCubit>().login(
                              userName: userName,
                              password: PasswordField.userPassword,
                            );
                        if (mounted) {
                          await context.read<LoginCubit>().userAuth();
                        }
                        if (mounted) {
                          await context.read<UserCubit>().getDrawerBasicInfo();
                        }
                        if (mounted) Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: state is LoginProcessing
                        ? const LoadingSpinningCircle(color: Colors.white)
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: deviceSize.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.registerScreen),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FormFieldContainer extends StatelessWidget {
  const FormFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.5,
            offset: Offset.fromDirection(90),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  static String userPassword = '';

  const PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: const ValueKey('password'),
            controller: widget.passwordController,
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Password should be 6 characters long.';
              }
              return null;
            },
            obscureText: obscurePassword,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Password is: m38rmF\$',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(
                0.0,
                10.0,
                20.0,
                10.0,
              ),
            ),
            onSaved: (value) {
              PasswordField.userPassword = value!;
            },
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            obscurePassword = !obscurePassword;
          }),
          child: Icon(
            obscurePassword
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: obscurePassword ? Colors.grey : Colors.orange,
          ),
        ),
      ],
    );
  }
}
