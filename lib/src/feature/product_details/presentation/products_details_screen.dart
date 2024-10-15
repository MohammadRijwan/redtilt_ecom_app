import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redtilt_ecom_app/src/core/common/cache_network_widget.dart';
import 'package:redtilt_ecom_app/src/core/common/spinkit_widget.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/widgets/add_remove_button.dart';

class ProductDetailsScreen extends ConsumerWidget {
  static String route = 'product_details';
  final int productId;

  const ProductDetailsScreen({required this.productId, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailsVm = ref.watch(productDetailsVmProvider(productId));
    final cartNotifier = ref.watch(cartNotifierProvider.notifier);
    ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: productDetailsVm.isLoading
          ? const Center(child: SpinKitWidget())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  CacheNetworkWidget(
                    imageUrl: productDetailsVm.product.image!,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    productDetailsVm.product.title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    productDetailsVm.product.description!,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${productDetailsVm.product.price}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  AddRemoveProductButton(
                      quantity:
                          cartNotifier.getQuantity(productDetailsVm.product.id),
                      addProduct: () {
                        cartNotifier.addToCart(productDetailsVm.product);
                      },
                      removeProduct: () {
                        cartNotifier.removeFromCart(productDetailsVm.product);
                      }),
                ],
              ).animate().scale(delay: 100.ms, duration: 900.ms),
            ),
    );
  }
}
