import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/splash_screen.dart';
import 'package:redtilt_ecom_app/src/feature/auth/login/login_screen.dart';
import 'package:redtilt_ecom_app/src/feature/auth/registration/signup_screen.dart';
import 'package:redtilt_ecom_app/src/feature/cart/cart_screen.dart';
import 'package:redtilt_ecom_app/src/feature/order_checkout/presentation/order_checkout_screen.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/products_screen.dart';
import 'package:redtilt_ecom_app/src/feature/product_details/presentation/products_details_screen.dart';

class AppRoute {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      getAllRoutes(),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) =>
        RouteErrorScreen(
            title: 'Route Not Found',
            message: 'Error! The route ${state.error} not found.'),
  );

  static GoRouter get router => _router;

  static GoRoute getAllRoutes() {
    return GoRoute(
        path: SplashScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          getLoginRoute(),
          getSignUpRoute(),
          getProductsRoute(),
          getProductDetailsRoute(),
          getCartRoute(),
          getOrderCheckOutRoute(),
        ]);
  }

  static GoRoute getLoginRoute() {
    return GoRoute(
        path: LoginScreen.route,
        name: LoginScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen());
  }

  static GoRoute getSignUpRoute() {
    return GoRoute(
        path: SignUpScreen.route,
        name: SignUpScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            const SignUpScreen());
  }

  static GoRoute getProductsRoute() {
    return GoRoute(
        path: ProductsScreen.route,
        name: ProductsScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            ProductsScreen());
  }

  static GoRoute getProductDetailsRoute() {
    return GoRoute(
        path: ProductDetailsScreen.route,
        name: ProductDetailsScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            ProductDetailsScreen(productId: state.extra as int));
  }

  static GoRoute getCartRoute() {
    return GoRoute(
        path: CartScreen.route,
        name: CartScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            const CartScreen());
  }

  static GoRoute getOrderCheckOutRoute() {
    return GoRoute(
        path: OrderCheckOutScreen.route,
        name: OrderCheckOutScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            const OrderCheckOutScreen());
  }
}

class RouteErrorScreen extends StatelessWidget {
  final String title;
  final String message;

  const RouteErrorScreen(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
