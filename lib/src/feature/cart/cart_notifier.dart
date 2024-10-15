import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_state.dart';

class CartNotifier extends StateNotifier<CartState> {
  final loggedInUser = FirebaseAuth.instance.currentUser;
  CartNotifier() : super(CartState()) {
    loadCart();
  }

  loadCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final cart = prefs.getString('cart_${loggedInUser!.uid}');
    if (cart != null) {
      state = CartState(
        products: List<Product>.from(productFromJson(cart)),
      );
    }
  }

  void addToCart(Product product) {
    final existingProductIndex =
        state.products.indexWhere((p) => p.id == product.id);

    if (existingProductIndex != -1) {
      state = state.copyWith(
        products: [
          ...state.products.sublist(0, existingProductIndex),
          state.products[existingProductIndex]
              .copyWith(qty: state.products[existingProductIndex].qty + 1),
          ...state.products.sublist(existingProductIndex + 1),
        ],
      );
    } else {
      state = state.copyWith(
        products: [...state.products, product.copyWith(qty: 1)],
      );
    }
    _saveCart();
    Fluttertoast.showToast(
      msg: 'Product added to cart',
    );
  }

  void removeFromCart(Product product) {
    final index = state.products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      if (state.products[index].qty > 1) {
        state = state.copyWith(
          products: [
            ...state.products.sublist(0, index),
            state.products[index].copyWith(qty: state.products[index].qty - 1),
            ...state.products.sublist(index + 1),
          ],
        );
      } else {
        state = state.copyWith(
          products: [
            ...state.products.sublist(0, index),
            ...state.products.sublist(index + 1),
          ],
        );
        Fluttertoast.showToast(
          msg: 'Product removed from cart',
        );
      }
    }
    _saveCart();
  }

  void clearCart() {
    state = CartState();
    _saveCart();
  }

  double calculateTotalPrice() {
    return state.products.fold(
      0,
      (total, product) => total + (product.price! * product.qty),
    );
  }

  getQuantity(int? id) {
    final index = state.products.indexWhere((p) => p.id == id);
    if (index == -1) return 0;
    return state.products[index].qty;
  }

  _saveCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cart_${loggedInUser!.uid}', productToJson(state.products));
  }

  void search(String text) {
    log("Searching::::::::$text ");

    state = CartState(products: []);
  }
}
