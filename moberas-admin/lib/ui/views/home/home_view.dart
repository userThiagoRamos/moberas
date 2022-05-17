import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/ui/views/home/home_viewmodel.dart';
import 'package:mobEras/ui/widgets/appbar/ui/moberas_appbar_widget.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: MoberasAppBar(),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          model.data ??
                              'Fique pelo menos 8 horas fora do leito.',
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      RaisedButton(
                        child: Text(
                          'Responder questionário dinamico',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: () async => await model.showDynamicDisplay(),
                      ),
                      RaisedButton(
                          child: Text(
                            'Responder questionário inicial',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () async => model.goToMilestone()),
                      RaisedButton(
                        child: Text(
                          'Questionário MobERAS - Validação',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: () async {
                          await model.navService
                              .navigateTo(Routes.validationSurveyView);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
