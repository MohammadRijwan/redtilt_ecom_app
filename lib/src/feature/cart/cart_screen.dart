import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/src/core/common/spinkit_widget.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/widgets/cart_item.dart';
import 'package:redtilt_ecom_app/src/feature/product_details/presentation/products_details_screen.dart';

import '../order_checkout/presentation/order_checkout_screen.dart';

class CartScreen extends ConsumerWidget {
  static String route = "cart_screen";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(cartNotifierProvider.notifier);
    final productVm = ref.watch(productVmProvider);
    final cartState = ref.watch(cartNotifierProvider);
    final List<Product> cartItems = cartState.products
        .map((entry) =>
            productVm.filteredProducts.firstWhere((p) => p.id == entry.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              onPressed: () {
                cartNotifier.clearCart();
              },
              icon: const Icon(Icons.delete_outline_outlined),
            ),
        ],
      ),
      body: productVm.isLoading
          ? const Center(child: SpinKitWidget())
          : cartItems.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 80.0),
                  itemCount: cartItems.length,
                  itemBuilder: (_, index) {
                    final product = cartItems[index];
                    return CartItem(
                      product: product,
                      quantity: cartState.products
                          .firstWhere((element) => element.id == product.id)
                          .qty,
                      addProduct: () {
                        cartNotifier.addToCart(product);
                      },
                      removeProduct: () {
                        cartNotifier.removeFromCart(product);
                      },
                      onCartTapped: () {
                        context.pushNamed(ProductDetailsScreen.route,
                            extra: product.id);
                      },
                    ).animate().scale(delay: 100.ms, duration: 900.ms);
                  },
                )
              : const Center(child: Text('Cart is empty')),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Total Amount : \$${cartNotifier.calculateTotalPrice().toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: cartItems.isNotEmpty
          ? GestureDetector(
              onTap: () {
                context.pushNamed(OrderCheckOutScreen.route);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Process Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
