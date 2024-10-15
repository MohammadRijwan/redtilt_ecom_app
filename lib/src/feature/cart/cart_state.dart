import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';

class CartState {
  final List<Product> products;

  CartState({this.products = const []});

  CartState copyWith({List<Product>? products}) => CartState(
        products: products ?? this.products,
      );
}
