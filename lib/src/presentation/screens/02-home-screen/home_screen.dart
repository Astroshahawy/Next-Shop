import 'dart:async';

import 'package:next_shop_app/src/presentation/screens/02-home-screen/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:next_shop_app/src/presentation/widgets/loading_circle.dart';

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
