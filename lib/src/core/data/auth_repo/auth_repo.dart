import 'package:fpdart/fpdart.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_db/i_db.dart';
import 'package:redtilt_ecom_app/src/core/domain/models/user.dart';

import '../../domain/interface/i_auth_repo/i_auth_repo.dart';

class AuthRepo implements IAuthRepo {
  final IDb _database;
  AuthRepo({required IDb database}) : _database = database;

  @override
  Future<Either<Exception, String>> login(
      {required String email, required String password}) async {
    return await _database.login(email: email, password: password);
  }

  //section signup
  @override
  Future<Either<Exception, String>> signUp(
      {required String email,
      required String password,
      required String name}) async {
    return await _database.signUp(email: email, password: password, name: name);
  }

  @override
  Future<Either<Exception, UserModel>> fetchUser() async {
    return await _database.fetchUser();
  }

  //logout
  @override
  Future<void> logout() async {
    await _database.logout();
  }
}
