import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redtilt_ecom_app/src/core/data/auth_repo/auth_repo.dart';
import 'package:redtilt_ecom_app/src/core/data/firebase_db/firebase_db.dart';
import 'package:redtilt_ecom_app/src/core/data/product_repo/product_repo.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_auth_repo/i_auth_repo.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_db/i_db.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_product_repo/i_product_repo.dart';
import 'package:redtilt_ecom_app/src/feature/auth/login/login_vm.dart';
import 'package:redtilt_ecom_app/src/feature/auth/signup/signup_vm.dart';
import 'package:redtilt_ecom_app/src/feature/cart/cart_notifier.dart';
import 'package:redtilt_ecom_app/src/feature/cart/cart_state.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/products_vm.dart';
import 'package:redtilt_ecom_app/src/feature/product_details/presentation/product_details_vm.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));
});

final firebaseDbProvider = Provider.autoDispose<IDb>((ref) {
  return FirebaseDb();
});

final authRepositoryProvider = Provider.autoDispose<IAuthRepo>(
    (ref) => AuthRepo(database: ref.read(firebaseDbProvider)));

final loginVmProvider = ChangeNotifierProvider<LoginVm>((ref) {
  return LoginVm(
    authRepository: ref.read(authRepositoryProvider),
  );
});

final singUpVmProvider = ChangeNotifierProvider<SignUpVm>((ref) {
  return SignUpVm(
    authRepository: ref.read(authRepositoryProvider),
  );
});

final productRepositoryProvider =
    Provider<IProductRepo>((ref) => ProductRepo(dio: ref.read(dioProvider)));

final productVmProvider = ChangeNotifierProvider.autoDispose<ProductsVm>((ref) {
  return ProductsVm(
      ref.watch(productRepositoryProvider), ref.read(authRepositoryProvider));
});

final productDetailsVmProvider = ChangeNotifierProvider.autoDispose
    .family<ProductDetailsVm, int>((ref, productId) {
  return ProductDetailsVm(ref.watch(productRepositoryProvider), productId);
});

final cartNotifierProvider =
    StateNotifierProvider.autoDispose<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
