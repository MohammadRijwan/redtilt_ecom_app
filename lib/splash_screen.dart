import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/src/core/common/spinkit_widget.dart';
import 'package:redtilt_ecom_app/src/feature/auth/login/login_screen.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/products_screen.dart';

class SplashScreen extends StatefulWidget {
  static String route = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await Future.delayed(const Duration(seconds: 1));
    if (auth.currentUser != null) {
      context.pushReplacementNamed(ProductsScreen.route);
    } else {
      context.goNamed(LoginScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome to E-Commerce \nApplication',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const SpinKitWidget(),
        ],
      ),
    );
  }
}
