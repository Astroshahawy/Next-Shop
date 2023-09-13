import 'package:next_shop_app/core/utils/mac_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:next_shop_app/src/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

class RegisterContainer extends StatefulWidget {
  const RegisterContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterContainer> createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  late String userName;
  late String userEmail;
  // late String userPassword;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userEmailController.dispose();
    super.dispose();
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
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is RegisterCompleted) {
              macAlertDialog(context, 'Register completed')
                  .whenComplete(() => Navigator.pop(context));
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/add_user.svg',
                      width: deviceSize.width * 0.8,
                      placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const LoadingSpinningCircle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
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
                                labelText: 'User name',
                                hintText: 'Enter a user name',
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
                            child: TextFormField(
                              key: const ValueKey('email'),
                              controller: _userEmailController,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(
                                            _userEmailController.text.trim())) {
                                  return 'Please enter a valid email.';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
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
                                userEmail = value!;
                              },
                            ),
                          ),
                          SizedBox(height: deviceSize.height * 0.02),
                          FormFieldContainer(
                            child: PasswordField(
                              passwordController: _passwordController,
                            ),
                          ),
                          SizedBox(height: deviceSize.height * 0.02),
                          FormFieldContainer(
                            child: ConfirmPasswordField(
                              confirmPasswordController:
                                  _confirmPasswordController,
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
                            await context.read<LoginCubit>().register(
                                  userName: userName,
                                  userEmail: userEmail,
                                  password: PasswordField.userPassword,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: state is RegisterProcessing
                            ? const LoadingSpinningCircle(color: Colors.white)
                            : const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
                  ],
                ),
              ),
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
              hintText: 'Enter password',
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

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController confirmPasswordController;
  static String userConfirmPassword = '';

  const ConfirmPasswordField({
    Key? key,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: const ValueKey('confirmPassword'),
            controller: widget.confirmPasswordController,
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Password should be 6 characters long.';
              }
              return null;
            },
            obscureText: obscurePassword,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm your password',
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
              ConfirmPasswordField.userConfirmPassword = value!;
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
