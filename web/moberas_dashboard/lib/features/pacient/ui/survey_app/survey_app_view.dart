import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/survey_app/survey_app_videmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';

class SurveyAppView extends StatelessWidget {
  final UserProfile profile;
  SurveyAppView({this.profile});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SurveyAppViewModel>.reactive(
      viewModelBuilder: () => SurveyAppViewModel(profile),
      builder: (
        BuildContext context,
        SurveyAppViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Questionário de satisfação'),
          ),
          body: model.dataReady && model.data != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Eu entendi bem as perguntas do aplicativo',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(model.data.entendimento),
                      Text(
                        'Eu achei o aplicativo fácil de navegar',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(model.data.navegacao),
                      Text(
                        'As figuras representaram bem o eu estava sentindo',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(model.data.representacaoVisual),
                      Text(
                        'O aplicativo me ajudou a caminhar mais,a me alimentar melhor e me recuperar mais rápido',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(model.data.utilidade),
                      Text(
                        'Eu indicaria o aplicativo para uso por outras pacientes',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(model.data.indicaria),
                    ],
                  ),
                )
              : Center(
                  child:
                      Text('O Questionário de satisfação não foi respondido.'),
                ),
        );
      },
    );
  }
}
