import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redtilt_ecom_app/src/core/common/cache_network_widget.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';

import 'add_remove_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onProductTapped;
  const ProductCard(
      {super.key, required this.product, required this.onProductTapped});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, _) {
      final cartNotifier = ref.watch(cartNotifierProvider.notifier);
      return GestureDetector(
        onTap: () => onProductTapped(),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: size.width,
                  child: CacheNetworkWidget(
                    imageUrl: product.image!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Price: \$${product.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description!,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                AddRemoveProductButton(
                    quantity: cartNotifier.getQuantity(product.id),
                    addProduct: () {
                      cartNotifier.addToCart(product);
                    },
                    removeProduct: () {
                      cartNotifier.removeFromCart(product);
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
