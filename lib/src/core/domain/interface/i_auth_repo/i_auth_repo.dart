import 'package:fpdart/fpdart.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/user.dart';

abstract class IAuthRepo {
  Future<Either<Exception, String>> login({
    required String email,
    required String password,
  });

  Future<Either<Exception, String>> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Exception, UserModel>> fetchUser();

  Future<void> logout();
}
