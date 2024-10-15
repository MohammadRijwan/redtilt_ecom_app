import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';
import 'package:redtilt_ecom_app/src/feature/auth/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(builder: (context, ref, _) {
          final _vm = ref.watch(loginVmProvider);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome to E-Commerce Application',
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login to your account',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email address',
                      ),
                      name: 'email',
                      controller: emailController,
                      onChanged: (val) {
                        _formKey.currentState!.fields['email']!.validate();
                        setState(() {});
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FormBuilderTextField(
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColor,
                        border: const OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                      name: 'password',
                      controller: passwordController,
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onChanged: (val) {
                        !_formKey.currentState!.fields['password']!.validate();
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.saveAndValidate()) {
                        _vm.onLogin(emailController.text,
                            passwordController.text, context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Center(
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(SignUpScreen.route);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
