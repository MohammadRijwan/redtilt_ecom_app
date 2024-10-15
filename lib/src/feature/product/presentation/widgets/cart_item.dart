import 'package:flutter/material.dart';
import 'package:redtilt_ecom_app/src/core/common/cache_network_widget.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/widgets/add_remove_button.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final Function addProduct;
  final Function removeProduct;
  final Function onCartTapped;

  const CartItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.addProduct,
    required this.removeProduct,
    required this.onCartTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCartTapped(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          child: Column(
            children: [
              ListTile(
                leading: CacheNetworkWidget(
                  imageUrl: product.image ?? '',
                ),
                title: Text(
                  product.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Price: \$${product.price!}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' x $quantity  :  ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${(product.price! * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      product.description!,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, right: 15.0),
                child: AddRemoveProductButton(
                    quantity: quantity,
                    addProduct: addProduct,
                    removeProduct: removeProduct),
              )
            ],
          ),
        ),
      ),
    );
  }
}
