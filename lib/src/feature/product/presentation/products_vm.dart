import 'package:flutter/material.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_auth_repo/i_auth_repo.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_product_repo/i_product_repo.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/user.dart';

class ProductsVm extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> filteredProducts = [];
  final IProductRepo _productRepository;
  final IAuthRepo _authRepository;

  UserModel? loggedInUser;
  bool isLoading = false;
  ProductsVm(this._productRepository, this._authRepository) {
    loadData();
  }
  loadData() async {
    isLoading = true;
    notifyListeners();
    final result = await _authRepository.fetchUser();
    result.fold((l) => loggedInUser = null, (r) => loggedInUser = r);
    _products = await _productRepository.getProducts();
    filteredProducts = _products;
    isLoading = false;
    notifyListeners();
  }

  loadUser() async {}

  loadProducts() async {
    await _productRepository.getProducts().then((value) async {
      _products = value;
      filteredProducts = _products;
    });
  }

  void search(String value) {
    filteredProducts = _products
        .where((element) =>
            element.title!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
