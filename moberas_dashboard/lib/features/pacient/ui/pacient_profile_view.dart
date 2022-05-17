import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/response/model/milestone_response.dart';
import 'package:stacked/stacked.dart';

import 'pacient_profile_viewmodel.dart';

class PacientProfileView extends StatelessWidget {
  final UserProfile profile;
  PacientProfileView({this.profile});

  Widget createTextWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

  Widget createPacientInfoBox(BuildContext context, UserProfile pacient) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            createTextWidget('Nome: ${pacient.displayName}'),
            createTextWidget('Pontuação: ${pacient.score}'),
            createTextWidget('Passos: ${pacient.totalSteps}'),
            createTextWidget(
              _getPacientStatusString(pacient.online),
            ),
          ],
        ),
      ),
    );
  }

  String _getPacientStatusString(bool online) {
    return online ? 'Online' : 'Offline';
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PacientProfileViewModel>.reactive(
      viewModelBuilder: () => PacientProfileViewModel(profile),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Perfil'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              createPacientInfoBox(context, profile),
              Container(
                child: RaisedButton(
                  child: Text('Tema do paciente'),
                  onPressed: () => model.goToUserTheme(),
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text('Relatório questionário estático'),
                  onPressed: () => model.goToMilestoneReport(),
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text('Relatório questionário dinamico'),
                  onPressed: () => model.goToDynamicReport(),
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text('Iniciar questionário dinamico'),
                  onPressed: () => model.startDynamicSurvey(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
