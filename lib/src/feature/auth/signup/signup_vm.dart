import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/src/core/common/flutter_toast.dart';
import 'package:redtilt_ecom_app/src/core/common/waiting_screen.dart';
import 'package:redtilt_ecom_app/src/core/domain/interface/i_auth_repo/i_auth_repo.dart';
import 'package:redtilt_ecom_app/src/feature/product/presentation/products_screen.dart';

class SignUpVm extends ChangeNotifier {
  final IAuthRepo authRepository;

  SignUpVm({required this.authRepository});

  void onSignUp(
      String name, String email, String password, BuildContext context) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      FlutterToast.show(message: "All the fields are required.");
    } else {
      WaitingScreen.show(context);
      final result = await authRepository.signUp(
          email: email, password: password, name: name);
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
