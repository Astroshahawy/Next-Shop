import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_shop_app/constants/strings.dart';

import 'package:next_shop_app/data/models/user.dart';
import 'package:next_shop_app/presentation/screens/01-login-screen/cubit/login_cubit.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/basic_info.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/cubit/user_cubit.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/orders_tile.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/personal_info.dart';
import 'package:next_shop_app/presentation/widgets/default_app_bar.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context)
        .checkUserAuth(BlocProvider.of<LoginCubit>(context).userAuthStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DefaultAppBar(
            pageTitle: 'Profile',
            isShortBar: true,
            showDrawer: false,
          ),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Expanded(
                  child: Center(
                    child: LoadingSpinningCircle(
                        color: Theme.of(context).primaryColor),
                  ),
                );
              }
              if (state is UserLoaded) {
                final User user = state.user;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BasicInfo(user: user),
                      const SizedBox(height: 10),
                      const OrdersTile(),
                      const SizedBox(height: 10),
                      PersonalInfo(user: user),
                    ],
                  ),
                );
              }
              if (state is UserNotAuth) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/user.svg',
                        width: MediaQuery.of(context).size.width * 0.6,
                        placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: LoadingSpinningCircle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      const Text(
                        'Welcome! Nice to be here',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, loginScreen),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
