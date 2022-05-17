import 'package:flutter/material.dart';
import 'package:moberas_dashboard/commons/busy_overlay.dart';
import 'package:moberas_dashboard/commons/cpf_cnpj_text_form_field.dart';
import 'package:moberas_dashboard/database/firestore.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';
import 'pacient_viewmodel.dart';

class PacientView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PacientViewModel>.reactive(
        viewModelBuilder: () => PacientViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('mobEras - Dashboard'),
              ),
              body: BusyOverlay(
                show: model.isBusy,
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: model.nameController,
                          keyboardType: TextInputType.name,
                          enableSuggestions: true,
                          decoration:
                              InputDecoration(labelText: 'Nome do paciente'),
                        ),
                      ),
                      CpfCnpjTextField(
                          controller: model.cpfController, validator: null),
                      RaisedButton(
                        elevation: 2,
                        onPressed: () => model.findPacientByNameOrCpf(),
                        child: Text(
                          'Pesquisar',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                        ),
                        color:
                            Theme.of(context).buttonTheme.colorScheme.primary,
                      ),
                      Visibility(
                        visible:
                            model.pacients != null && model.pacients.isNotEmpty,
                        child: Expanded(child: _PacientList()),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _PacientList extends ViewModelWidget<PacientViewModel> {
  _PacientList({Key key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, PacientViewModel viewModel) =>
      viewModel.pacients != null && viewModel.pacients.isNotEmpty
          ? Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.pacients?.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${viewModel.pacients[index]?.displayName} - ${viewModel.pacients[index]?.cpf}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            onPressed: () => _messageModalBottomSheet(
                                context, viewModel.pacients[index]),
                            child: Text(' Enviar Mensagem ')),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          onPressed: () {
                            viewModel.goToProfile(viewModel.pacients[index]);
                          },
                          child: Text(' Visualizar perfil '),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          : Container();

  void _messageModalBottomSheet(BuildContext context, UserProfile userProfile) {
    var msgTextController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: msgTextController,
                          keyboardType: TextInputType.name,
                          enableSuggestions: true,
                          decoration: InputDecoration(labelText: 'Mensagem'),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    children: [
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancelar')),
                      FlatButton(
                        onPressed: () async {
                          locator<IPacientService>()
                              .sendMsg(userProfile.uid, msgTextController.text);
                          Navigator.of(context).pop();
                        },
                        child: Text('Enviar'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  savetemplate() {
    Document(path: '/preferences/textTheme')
        .upsert(ThemeCfg.defaultTheme().toJson());
  }
}
