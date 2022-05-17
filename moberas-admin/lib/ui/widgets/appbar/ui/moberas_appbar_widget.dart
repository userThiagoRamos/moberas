import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/services/auth/authentication_service.dart';
import 'package:mobEras/ui/widgets/appbar/ui/moberas_appbar_viewmodel.dart';
import 'package:mobEras/ui/widgets/input/input_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../cpf_cnpj_text_form_field.dart';

class MoberasAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppBarViewModel>.reactive(
        builder: (context, model, child) => model.dataReady
            ? AppBar(
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 6.0, 15.0, 0.0),
                  child: Container(),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.help_outline,
                    color: Theme.of(context).buttonColor,
                    size: 40,
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      actions: [
                        RaisedButton(
                            child: Text(
                              'ENVIAR MENSAGEM DE AJUDA',
                            ),
                            onPressed: () async => await model
                                .sendHelpMsg(model.helpMsgController.text)),
                        RaisedButton(
                          child: Text(
                            'CANCELAR',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () =>
                              locator<NavigationService>().popRepeated(1),
                        ),
                      ],
                      title: Text(
                        'Olá ${model.data.displayName}\nDigite sua dúvida na caixa de texto abaixo.',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black),
                      ),
                      content: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: model.helpMsgController,
                              keyboardType: TextInputType.multiline,
                              expands: false,
                              maxLines: 4,
                              minLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'mensagem',
                                alignLabelWithHint: true,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(color: Colors.black),
                                hintText: 'mensagem',
                                contentPadding: const EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    tooltip: 'Assistir video',
                    icon: Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).buttonColor,
                      size: 40,
                    ),
                    onPressed: () async => await locator<NavigationService>()
                        .navigateTo(Routes.mobErasVideoIntroView),
                  ),
                  model.data.admin
                      ? ButtonBar(
                          children: [
                            IconButton(
                                tooltip: 'Grant access',
                                icon: Icon(
                                  Icons.supervisor_account_rounded,
                                  color: Theme.of(context).buttonColor,
                                  size: 40,
                                ),
                                onPressed: () async => showDialog(
                                    barrierDismissible: true,
                                    useSafeArea: true,
                                    context: (context),
                                    builder: (buildContext) => Scaffold(
                                          body: SafeArea(
                                            child: Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Text(
                                                        'O usuário precisa ter realizado o login antes que o acesso seja concedido'),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          5, 40, 1, 1),
                                                      child: CpfCnpjTextField(
                                                        controller: model
                                                            .superUserCpfController,
                                                        validator: null,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton(
                                                      color: Colors.green,
                                                      onPressed: () => model
                                                          .grantAccess(true),
                                                      child: Text(
                                                          'Conceder acesso especial',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FlatButton(
                                                      color: Colors.red,
                                                      onPressed: () => model
                                                          .grantAccess(false),
                                                      child: Text(
                                                          'Remover acesso especial',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))),
                            IconButton(
                              tooltip: 'Reiniciar estatico',
                              icon: Icon(
                                Icons.repeat_one_outlined,
                                color: Theme.of(context).buttonColor,
                                size: 32,
                              ),
                              onPressed: () async => await model.resetSurvey(),
                            ),
                            IconButton(
                              tooltip: 'Reiniciar dinamico',
                              icon: Icon(
                                Icons.repeat_sharp,
                                color: Theme.of(context).buttonColor,
                                size: 32,
                              ),
                              onPressed: () async =>
                                  await model.showDynamicSurvey(),
                            ),
                            IconButton(
                                tooltip: 'Navegacao',
                                icon: Icon(
                                  Icons.alt_route,
                                  color: Theme.of(context).buttonColor,
                                  size: 32,
                                ),
                                onPressed: () async => await showDialog(
                                    barrierDismissible: true,
                                    useSafeArea: true,
                                    context: (context),
                                    builder: (buildContext) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: ListView.builder(
                                              itemCount: model.appRoutes.length,
                                              itemBuilder: (context, index) =>
                                                  FlatButton(
                                                onPressed: () =>
                                                    model.navigate(index),
                                                child: Text(
                                                  model.appRoutes.keys
                                                      .toList()[index],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )))
                          ],
                        )
                      : Container(),
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).buttonColor,
                      size: 32,
                    ),
                    onPressed: () async =>
                        await locator<AuthenticationService>().signOut(),
                  ),
                ],
              )
            : LinearProgressIndicator(),
        viewModelBuilder: () => AppBarViewModel());
  }
}
