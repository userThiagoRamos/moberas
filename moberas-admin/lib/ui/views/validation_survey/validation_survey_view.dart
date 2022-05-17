
import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'validation_survey_view_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ValidationSurveyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ValidationSurveyViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('MobERAS - Validação'),
              ),
              bottomNavigationBar: RaisedButton(
                  onPressed: () async => model.insert(),
                  child: Text(
                    'Enviar',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  )),
              body: SafeArea(
                  child: ListView(
                children: [
                  FormBuilder(
                    key: model.fbKey,
                    readOnly: false,
                    child: Column(
                      children: [
                        Text(
                          'Eu entendi bem as perguntas do aplicativo',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        validationQuestion(model,
                            title: 'Eu entendi bem as perguntas do aplicativo',
                            attribute: 'entendimento'),
                        Text(
                          'Eu achei o aplicativo fácil de navegar',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        validationQuestion(model,
                            title: 'Eu achei o aplicativo fácil de navegar',
                            attribute: 'navegacao'),
                        Text(
                          'As figuras representaram bem o eu estava sentindo',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        validationQuestion(model,
                            title:
                                'As figuras representaram bem o eu estava sentindo',
                            attribute: 'representacao_visual'),
                        Text(
                          'O aplicativo me ajudou a caminhar mais,a me alimentar melhor e me recuperar mais rápido',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        validationQuestion(model,
                            title:
                                'O aplicativo me ajudou a caminhar mais, a me alimentar melhor e me recuperar mais rápido',
                            attribute: 'utilidade'),
                        Text(
                          'Eu indicaria o aplicativo para uso por outras pacientes',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        validationQuestion(model,
                            title:
                                'Eu indicaria o aplicativo para uso por outras pacientes',
                            attribute: 'indicaria'),
                      ],
                    ),
                  )
                ],
              )),
            ),
        viewModelBuilder: () => ValidationSurveyViewModel());
  }

  Widget validationQuestion(ValidationSurveyViewModel model,
      {@required String title, @required attribute}) {
    return Builder(
      builder: (context) => FormBuilderRadioGroup(
        orientation: GroupedRadioOrientation.vertical,
        attribute: attribute,
        wrapSpacing: 90.0,
        options: model.options
            .map((answer) => FormBuilderFieldOption(
                  value: answer,
                  child: Text(
                    '$answer',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontSize: 24),
                  ),
                ))
            .toList(growable: false),
      ),
    );
  }
}
