import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobEras/core/constants/local_keys.dart';
import 'package:mobEras/core/constants/month.dart';
import 'package:mobEras/core/localization/localization.dart';
import 'package:mobEras/ui/shared/ui_helpers.dart';
import 'package:mobEras/ui/widgets/busy_overlay.dart';
import 'package:mobEras/ui/widgets/cpf_cnpj_text_form_field.dart';
import 'package:mobEras/ui/widgets/input/input_text_field.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var dayOfMonth = MaskTextInputFormatter(
      mask: '#?', filter: {'#': RegExp(r'[0-3]'), '9': RegExp(r'[1-3]')});
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController birthdayDayController;
  TextEditingController birthdayMonthController;
  TextEditingController birthdayYearController;
  TextEditingController cpfController;

  FocusNode nameFocusNode;
  FocusNode monthNode;
  FocusNode dayNode;
  FocusNode yearNode;

  @override
  void dispose() {
    nameController.dispose();
    birthdayDayController.dispose();
    birthdayMonthController.dispose();
    birthdayYearController.dispose();
    cpfController.dispose();

    nameFocusNode.dispose();
    dayNode.dispose();
    monthNode.dispose();
    yearNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    birthdayDayController = TextEditingController();
    birthdayMonthController = TextEditingController();
    birthdayYearController = TextEditingController();
    cpfController = TextEditingController();
    nameFocusNode = FocusNode();
    dayNode = FocusNode();
    monthNode = FocusNode();
    yearNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => BusyOverlay(
        title: local.translate(LocalKeys.busy_overlay_title),
        show: model.isBusy,
        child: Semantics(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(local.translate(LocalKeys.login_appbar_title)),
            ),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Semantics(
                          label:
                              'Bem vindo ao MobERAS. Vamos precisar do seu nome e sua data de nascimento. Clique duas vezes para iniciar o cadastro.',
                          child: ExcludeSemantics(
                            child: Text(
                              local.translate(LocalKeys.label_input_name),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                        verticalSpaceSmall,
                        Semantics(
                          label: local
                              .translate(LocalKeys.semantics_label_login_name),
                          child: ExcludeSemantics(
                            child: InputTextField(
                              prefixIcon: Icon(Icons.perm_identity),
                              hintText: local.translate(LocalKeys.name_hint),
                              textInputAction: TextInputAction.done,
                              controller: nameController,
                              onFieldSubmitted: (_) {},
                              textInputType: TextInputType.text,
                              validator: (_) => local.translate(
                                  model.validateFullName(nameController.text)),
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        Text(
                          'Por favor informe o cpf',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        CpfCnpjTextField(
                            controller: cpfController,
                            validator: (_) =>
                                model.validateCpf(cpfController.text)),
                        verticalSpace(20),
                        Text(
                          local.translate(LocalKeys.label_input_birthday),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        verticalSpaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Semantics(
                                excludeSemantics: true,
                                hint: 'Informe o dia do mês do seu nascimento?',
                                child: InputTextField(
                                  maxLenght: 2,
                                  focusNode: dayNode,
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                          decimal: false, signed: false),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    
                                  ],
                                  hintText: local
                                      .translate(LocalKeys.birtdhday_day_hint),
                                  textInputAction: TextInputAction.next,
                                  controller: birthdayDayController,
                                  onFieldSubmitted: (_) {
                                    dayNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(monthNode);
                                  },
                                  validator: (_) => local.translate(model
                                      .validateFullName(nameController.text)),
                                ),
                              ),
                            ),
                            horizontalSpaceSmall,
                            Expanded(
                              flex: 2,
                              child: Focus(
                                focusNode: monthNode,
                                child: DropdownButtonFormField<String>(
                                  value: model.month,
                                  hint: Text(local.translate(
                                      LocalKeys.birtdhday_month_hint)),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0.0)),
                                  onChanged: (String newValue) {
                                    model.setMonth(newValue);
                                    monthNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(yearNode);
                                  },
                                  items: Month.monthList.map((String month) {
                                    return DropdownMenuItem<String>(
                                      value: month,
                                      child: Text(
                                        month,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            horizontalSpaceSmall,
                            Expanded(
                              flex: 2,
                              child: InputTextField(
                                focusNode: yearNode,
                                maxLenght: 4,
                                textInputType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                hintText: local
                                    .translate(LocalKeys.birtdhday_year_hint),
                                textInputAction: TextInputAction.done,
                                controller: birthdayYearController,
                                validator: (_) => local.translate(model
                                    .validateFullName(nameController.text)),
                              ),
                            )
                          ],
                        ),
                        verticalSpace(80),
                        LoginButton(
                          text: local.translate(LocalKeys.login_txt),
                          loginMethod: () async {
                            if (!formKey.currentState.validate()) {
                              return Future.value(null);
                            } else {
                              return model.login(
                                  nameController.text,
                                  '${birthdayDayController.text}${model.month}${birthdayYearController.text}',
                                  cpfController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key, this.text, this.loginMethod}) : super(key: key);

  final Function loginMethod;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        color: Theme.of(context).buttonColor,
        onPressed: () async => await loginMethod(),
        child: Text(
          '$text',
          textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}


