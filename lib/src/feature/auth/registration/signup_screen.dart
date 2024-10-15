import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:redtilt_ecom_app/src/core/provider/app_providers.dart';

class SignUpScreen extends StatefulWidget {
  static String route = 'signup_screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, ref, _) {
          final _vm = ref.watch(singUpVmProvider);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
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
                      'Create an account to continue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FormBuilderTextField(
                      decoration: const InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your Full Name',
                      ),
                      name: 'fullName',
                      controller: nameController,
                      onChanged: (val) {
                        _formKey.currentState!.fields['fullName']!.validate();
                        setState(() {});
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.name,
                    ),
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
                      decoration: const InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                      name: 'password',
                      obscureText: true,
                      controller: passwordController,
                      onChanged: (val) {
                        _formKey.currentState!.fields['password']!.validate();
                        setState(() {});
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.saveAndValidate()) {
                          _vm.onSignUp(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              context);
                        }
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(6.0)),
                        child: Center(
                          child: Text(
                            'Sign Up',
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
                  const SizedBox(height: 40.0),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
