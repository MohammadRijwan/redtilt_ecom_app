import 'package:redtilt_ecom_app/src/core/domain/models/product.dart';

abstract class IProductRepo {
  Future<List<Product>> getProducts();
  Future<Product> getProductById({required int productId});
}
