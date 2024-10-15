import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redtilt_ecom_app/src/core/common/cache_network_widget.dart';
import 'package:redtilt_ecom_app/src/core/common/spinkit_widget.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';

class OrderCheckOutScreen extends ConsumerWidget {
  static String route = 'order_checkout';
  const OrderCheckOutScreen({super.key});

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
        title:
            const Text('Order Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: productVm.isLoading
          ? const Center(child: SpinKitWidget())
          : cartItems.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (_, index) {
                    final product = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          leading: CacheNetworkWidget(
                            imageUrl: product.image ?? '',
                          ),
                          title: Text(
                            product.title ?? '',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  'Qty: ${cartNotifier.getQuantity(product.id)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                              Text('Price: ${product.price}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                              Text(
                                  'Total Price: ${product.price! * cartNotifier.getQuantity(product.id)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                          subtitle: Text(
                            '${cartState.products[index].description}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ).animate().scale(delay: 100.ms, duration: 900.ms);
                  },
                )
              : const Center(child: Text('Cart is empty')),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'G.Total : \$${cartNotifier.calculateTotalPrice().toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => Dialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 50),
                              const Text('Order Placed Successfully',
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 12.0),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.green,
                                  side: const BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).popUntil(
                                    (route) => route.isFirst,
                                  );
                                  cartNotifier.clearCart();
                                },
                                child: const Text('Continue Shopping'),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ).animate().scale(delay: 100.ms, duration: 900.ms),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
