import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:next_shop_app/presentation/screens/01-login-screen/cubit/login_cubit.dart';

import 'package:next_shop_app/presentation/screens/02-home-screen/carousel_container.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/categories_container.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/cubit/home_screen_cubit.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/featured_container.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/home_screen_app_bar.dart';
import 'package:next_shop_app/presentation/screens/02-home-screen/new_arrivals_container.dart';
import 'package:next_shop_app/presentation/screens/06-cart-screen/cubit/cart_cubit.dart';
import 'package:next_shop_app/presentation/screens/08-user-screen/cubit/user_cubit.dart';
import 'package:next_shop_app/presentation/widgets/floating_search_bar.dart';
import 'package:next_shop_app/presentation/widgets/loading_circle.dart';

class HomeScreen extends StatefulWidget {
  final Widget drawer;
  const HomeScreen({
    Key? key,
    required this.drawer,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime = DateTime.now();
  bool hasInternet = true;
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _connectionSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(
            backgroundColor: Colors.amber.shade300.withOpacity(0.9),
            textColor: Colors.grey.shade800,
            msg: 'Press "Back" again to exit',
            fontSize: 16.0,
          );
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        drawer: widget.drawer,
        body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1))
              .then((value) => InternetConnectionChecker().hasConnection),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ConnectionCheckLoader();
            }
            return !hasInternet
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/notify.svg',
                          width: MediaQuery.of(context).size.width * 0.6,
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                            padding: const EdgeInsets.all(30.0),
                            child: const LoadingSpinningCircle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        const Text(
                          'Oops! Somthing went wrong',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        const Text(
                          'This doesn\'t seem right! Let us try again.',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              final hasInternet =
                                  await InternetConnectionChecker()
                                      .hasConnection;
                              setState(() {
                                this.hasInternet = hasInternet;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text(
                              'RETRY',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const HomeScreenBody();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectionSubscription!.cancel();
    super.dispose();
  }
}

class ConnectionCheckLoader extends StatelessWidget {
  const ConnectionCheckLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.amber.shade300,
            Colors.orange.shade600,
          ],
        ),
      ),
      child: const SpinKitFadingCircle(
        color: Colors.white,
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenCubit>(context).getHomeData();
    BlocProvider.of<CartCubit>(context).loadCartProducts();
    BlocProvider.of<LoginCubit>(context).userAuth();
    BlocProvider.of<UserCubit>(context).getDrawerBasicInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const HomeScreenAppBar(),
            Expanded(
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (state is HomeScreenLoading) {
                    return LoadingSpinningCircle(
                        color: Theme.of(context).primaryColor);
                  } else if (state is HomeScreenLoaded) {
                    return RefreshIndicator(
                      onRefresh: () => BlocProvider.of<HomeScreenCubit>(context)
                          .getHomeData(),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50.0),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CarouselContainer(
                              productList: state.carouselProducts,
                            ),
                            const SizedBox(height: 40.0),
                            CategoriesContainer(
                              categories: state.categories,
                            ),
                            const SizedBox(height: 40.0),
                            FeaturedContainer(
                              products: state.featuredProducts,
                            ),
                            const SizedBox(height: 40.0),
                            NewArrivalsContainer(products: state.newProducts),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
        const FloatingSearchBar(),
      ],
    );
  }
}
