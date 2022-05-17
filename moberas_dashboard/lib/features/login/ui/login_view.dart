import 'package:flutter/material.dart';
import 'package:moberas_dashboard/commons/busy_overlay.dart';
import 'package:moberas_dashboard/commons/email_text_field.dart';
import 'package:moberas_dashboard/commons/login_button.dart';
import 'package:moberas_dashboard/commons/password_text_field.dart';
import 'package:moberas_dashboard/commons/ui_helpers.dart';
import 'package:moberas_dashboard/commons/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget with Validators {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController;
  FocusNode emailFocusNode;

  TextEditingController passwordController;
  FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: 'moberas.dev@moberas.com');
    emailFocusNode = FocusNode();
    passwordController = TextEditingController(text: '123456');
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String validateEmail(String value) {
    if (!isEmail(value.trim())) {
      return 'LocalKeys.invalid_email';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'LocalKeys.password_empty';
    } else if (value.length < 6) {
      return 'LocalKeys.password_short';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => BusyOverlay(
              show: model.isBusy,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Theme.of(context).primaryColor,
                        Colors.white
                      ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          EmailTextField(
                            key: ValueKey('emailinput'),
                            controller: emailController,
                            focusNode: emailFocusNode,
                            validator: (value) => validateEmail(value),
                            onFieldSubmitted: (_) {
                              emailFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(passwordFocusNode);
                            },
                          ),
                          verticalSpaceMedium,

                          PasswordTextFormField(
                              key: ValueKey('passwordinput'),
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              onFieldSubmitted: (_) => null,
                              validator: (value) => validatePassword(value)),
                          verticalSpaceMedium,
                          LoginButton(
                            key: ValueKey('loginbutton'),
                            icon: Icons.transit_enterexit,
                            color: Color.fromARGB(255, 51, 173, 200),
                            text: 'Login',
                            loginMethod: () async {
                              if (!formKey.currentState.validate()) {
                                return Future.value(null);
                              } else {
                                return model.login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          verticalSpaceMedium,
                          // InkWell(
                          //     child: Text('Recuperar senha'),
                          //     onTap: () => print('Clicou para recuperar a senha')),
                        ],
                      ),
//                  loginMethod: () async {
//                    if (!formKey.currentState.validate()) {
//                      return Future.value(null);
//                    } else {
//                      return model.login(
//                      crm: crmController.text,
//                      password: passwordController.text);
//                    }
//                  },
                    ),
                  ),
                ),
              ),
            ));
  }
}
