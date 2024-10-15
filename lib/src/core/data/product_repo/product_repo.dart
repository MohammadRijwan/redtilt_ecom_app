import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:redtilt_ecom_app/src/core/data/offline_data_repo/offline_data_repo.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_product_repo/i_product_repo.dart';

import '../../domain/models/product.dart';

class ProductRepo implements IProductRepo {
  final Dio _dio;
  ProductRepo({required Dio dio}) : _dio = dio;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      log(connectivityResult.toString());
      if (connectivityResult.first == ConnectivityResult.none) {
        final savedProducts = await OfflineDataRepo.getSavedProducts();
        if (savedProducts != null) {
          return savedProducts;
        }
      }

      final response = await _dio.get('/products');
      log("Response: $response");
      if (response.statusCode == 200) {
        var products = (response.data as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        await OfflineDataRepo.saveProducts(products);
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log("Failed to get products: $e");
      rethrow;
    }
  }

  @override
  Future<Product> getProductById({required int productId}) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      log(connectivityResult.toString());
      if (connectivityResult.first == ConnectivityResult.none) {
        final savedProducts = await OfflineDataRepo.getSavedProducts();
        if (savedProducts != null) {
          final product =
              savedProducts.where((product) => product.id == productId).first;
          return product;
        }
      }
      final response = await _dio.get('/products/$productId');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      log("Failed to get products: $e");
      rethrow;
    }
  }
}
