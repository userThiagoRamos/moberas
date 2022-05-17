import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:moberas_dashboard/database/globals.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:stacked/stacked.dart';
import 'package:latlong/latlong.dart';
import 'pacient_profile_viewmodel.dart';
import './map/zoombuttons_plugin_option.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PacientProfileView extends StatelessWidget {
  static const String route = '/plugin_zoombuttons';
  final UserProfile profile;
  PacientProfileView({this.profile});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PacientProfileViewModel>.reactive(
      viewModelBuilder: () => PacientProfileViewModel(),
      onModelReady: (model) => model.fetchPacient(profile),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Perfil'),
        ),
        body: model.selectedPacient != null
            ? Column(
                children: [
                  Text(
                    'Ícone verde = primeira posição registra - Ícone vermelho = última posição registrada \n Passe o mouse por cima do ícone, ou pressione o ícone quando utilzando o app no smartphone, para visualizar a data e hora do evento',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  map(model),
                  info(model),
                  options(model),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget map(PacientProfileViewModel model) {
    return FutureBuilder<List<Marker>>(
        future: model.fetchMapaData(),
        builder: (context, snapshot) =>
            snapshot.hasData && snapshot.data.isNotEmpty
                ? Expanded(
                    flex: 3,
                    child: FlutterMap(
                      mapController: model.mapController,
                      options: MapOptions(
                          interactive: true,
                          center: LatLng(snapshot.data[0].point.latitude,
                              snapshot.data[0].point.longitude),
                          zoom: 18.0,
                          plugins: [ZoomButtonsPlugin()]),
                      layers: [
                        new TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']),
                        new MarkerLayerOptions(
                          markers: snapshot.data,
                        ),
                        ZoomButtonsPluginOption(
                            minZoom: 4,
                            maxZoom: 19,
                            mini: true,
                            padding: 10,
                            alignment: Alignment.bottomRight)
                      ],
                    ),
                  )
                : Container());
  }

  Widget info(PacientProfileViewModel model) {
    return Container(
      child: createPacientInfoBox(model),
    );
  }

  Expanded options(PacientProfileViewModel model) {
    return Expanded(
        flex: 1,
        child: SingleChildScrollView(
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            layoutBehavior: ButtonBarLayoutBehavior.padded,
            children: [
              RaisedButton(
                child: Text(
                  'Tema do paciente',
                  textAlign: TextAlign.center,
                ),
                onPressed: () => model.goToUserTheme(),
              ),
              RaisedButton(
                child: Text(
                  'Relatório questionário estático',
                  textAlign: TextAlign.center,
                ),
                onPressed: () => model.goToMilestoneReport(),
              ),
              RaisedButton(
                child: Text(
                  'Relatório questionário dinâmico',
                  textAlign: TextAlign.center,
                ),
                onPressed: () => model.goToDynamicReport(),
              ),
              RaisedButton(
                child: Text(
                  'Questionário de validação do app',
                  textAlign: TextAlign.center,
                ),
                onPressed: () => model.goToSurveyAppView(),
              ),
            ],
          ),
        ));
  }

  Widget startSurvey(PacientProfileViewModel model) {
    return Builder(
      builder: (context) => Container(
        child: RaisedButton(
          child: Text(
            'Iniciar questionário dinamico',
            textAlign: TextAlign.center,
          ),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("Questionário dinâmico"),
                content: Text("Confirma a execução do questionário dinâmico?"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      model.startDynamicSurvey();
                    },
                    child: Text("Sim"),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Não"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget createTextWidget(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget createPacientInfoBox(PacientProfileViewModel model) {
    return Builder(
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              createTextWidget('${model.selectedPacient.displayName}'),
              createTextWidget('Pontuação: ${model.selectedPacient.score}'),
              createTextWidget(
                  'Data da internação: ${model.formatDate(model.selectedPacient.datadeinternacao)}'),
              createTextWidget(
                  'Data da cirurgia: ${model.formatDate(model.selectedPacient.datadacirurgia)}'),
              createTextWidget(
                  'Data da alta: ${model.formatDate(model.selectedPacient.dataAlta)}'),
              createTextWidget(
                _getPacientStatusString(model.selectedPacient.online),
              ),
              FutureBuilder<int>(
                  future: model.getDistance(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? createTextWidget(
                          'Distância percorrida: ${snapshot.data} metros')
                      : Center(
                          child: CircularProgressIndicator(),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  String _getPacientStatusString(bool online) {
    return online ? 'Online' : 'Offline';
  }
}
