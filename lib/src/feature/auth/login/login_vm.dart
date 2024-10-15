import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/src/core/common/flutter_toast.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_auth_repo/i_auth_repo.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/products_screen.dart';

import '../../../core/common/waiting_screen.dart';

class LoginVm extends ChangeNotifier {
  final IAuthRepo authRepository;

  LoginVm({required this.authRepository}) : super();

  void onLogin(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      FlutterToast.show(message: "All the fields are required.");
    } else {
      WaitingScreen.show(context);
      final result =
          await authRepository.login(email: email, password: password);
      result.fold((onLeft) {
        WaitingScreen.hide(context);
        FlutterToast.show(message: '$onLeft');
      }, (onRight) {
        WaitingScreen.hide(context);
        context.pushReplacementNamed(ProductsScreen.route);
      });
    }
  }
}
