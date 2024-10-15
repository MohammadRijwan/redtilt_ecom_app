import 'package:flutter/material.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_product_repo/i_product_repo.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';

class ProductDetailsVm extends ChangeNotifier {
  late Product product;

  final IProductRepo _productRepository;

  final int productId;

  bool isLoading = false;
  ProductDetailsVm(this._productRepository, this.productId) {
    loadProducts();
  }

  loadProducts() async {
    isLoading = true;
    notifyListeners();
    await _productRepository.getProductById(productId: productId).then((value) {
      product = value;
    });
    isLoading = false;
    notifyListeners();
  }
}
