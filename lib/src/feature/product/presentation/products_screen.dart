import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/src/core/common/spinkit_widget.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';
import 'package:redtilt_ecom_app/src/feature/auth/login/login_screen.dart';
import 'package:redtilt_ecom_app/src/feature/cart/cart_screen.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/widgets/product_card.dart';
import 'package:redtilt_ecom_app/src/feature/product_details/presentation/products_details_screen.dart';

class ProductsScreen extends ConsumerWidget {
  final TextEditingController controller = TextEditingController();
  static String route = 'products_screen';

  ProductsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsVm = ref.watch(productVmProvider);
    ref.watch(cartNotifierProvider);
    ref.watch(cartNotifierProvider.notifier);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Icon(Icons.person, size: 100),
            Text(
              productsVm.loggedInUser?.name ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(productsVm.loggedInUser?.email ?? ''),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                ref.read(authRepositoryProvider).logout().then(
                  (value) {
                    context.goNamed(LoginScreen.route);
                  },
                );
              },
              child: const Text('Logout'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1)
          ],
        ),
      ),
      appBar: AppBar(
        title:
            const Text('E-commerce App', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.pushNamed(CartScreen.route);
            },
          ),
        ],
      ),
      body: productsVm.isLoading
          ? const Center(child: SpinKitWidget())
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      productsVm.search(value);
                    },
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: productsVm.filteredProducts.length,
                      itemBuilder: (_, index) {
                        final product = productsVm.filteredProducts[index];
                        return ProductCard(
                          product: product,
                          onProductTapped: () {
                            context.pushNamed(ProductDetailsScreen.route,
                                extra: product.id);
                          },
                        ).animate().scale(delay: 100.ms, duration: 900.ms);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
