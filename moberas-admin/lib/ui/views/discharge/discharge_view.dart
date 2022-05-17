import 'package:flutter/material.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/models/user_profile.dart';
import 'package:mobEras/ui/shared/ui_helpers.dart';
import 'package:mobEras/ui/views/discharge/discharge_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DischargeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DischargeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        Text(
                          '''	•	Continue fazendo caminhadas dentro de casa. Pelo menos 6 vezes ao longo do dia.

	•	Procure ficar pelo menos 8 horas fora da cama. 

	•	Continue fazendo todas as refeições na mesa e não na cama.

	•	Procure movimentar as pernas quando estiver deitada.

	•	Beba água e se alimente regularmente.

	•	Lembre-se: sua participação é fundamental para sua recuperação!

	•	Em caso de dúvidas, por favor nos pergunte. Se não quiser nos ligar, utilize a caixa de dúvidas.''',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        FutureBuilder<UserProfile>(
                          future: UserProfileData().getDocument(),
                          builder: (_, userData) => userData.hasData
                              ? Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Center(
                                          child: Text(
                                            'Caso tenha alguma dúvida nos mande uma mensagem atráves da caixa de mensagem.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                .copyWith(color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(
                                                child: TextFormField(
                                                  controller:
                                                      model.textController,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  expands: false,
                                                  maxLines: 20,
                                                  minLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                  decoration: InputDecoration(
                                                    helperStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .headline2
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                    labelStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .headline2
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                    labelText:
                                                        'Caixa de mensagem',
                                                    suffixStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .headline2,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: RaisedButton(
                                                  child: Text(
                                                    'Enviar mensagem de ajuda',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  onPressed: () =>
                                                      model.sendHelpMsg(model
                                                          .textController.text),
                                                ),
                                              ),
                                              verticalSpaceMedium,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Olá ${userData.data.displayName}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2
                                                      .copyWith(
                                                          color: Colors.black),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Text(
                                                'Por favor nos diga como foi a sua experiência com o Moberas clicando no botão abaixo',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .copyWith(
                                                        color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(18.0),
                                                child: Container(
                                                  child: RaisedButton(
                                                    child: Text(
                                                      'Responder questionário',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    onPressed: () => model
                                                        .goToUserExperienceSurvey(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => DischargeViewModel());
  }
}
