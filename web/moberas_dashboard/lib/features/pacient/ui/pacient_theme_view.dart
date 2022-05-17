import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_form.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PacientThemeView extends StatelessWidget {
  final UserProfile profile;
  PacientThemeView({this.profile});

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
            createTextWidget('Nome: ' + pacient.displayName),
            createTextWidget('Pontuação: ' + pacient.score.toString()),
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
    return ViewModelBuilder<PacientThemeViewModel>.reactive(
      viewModelBuilder: () => PacientThemeViewModel(profile),
      builder: (context, model, child) => !model.isBusy
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Perfil'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  createPacientInfoBox(context, profile),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: PacientThemeForm(),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
