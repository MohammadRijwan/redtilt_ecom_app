import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/product.dart';

class OfflineDataRepo {
  static const String cacheKey = 'product_cache';

  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(products));
  }

  static Future<List<Product>?> getSavedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      List<Product> products = [];
      log('Cached Data: $cachedData');
      final decodedData = jsonDecode(cachedData);
      products = (decodedData as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    }
    return null;
  }
}
