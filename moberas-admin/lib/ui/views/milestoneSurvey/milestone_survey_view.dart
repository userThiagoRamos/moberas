import 'package:flutter/material.dart';
import 'package:mobEras/ui/views/milestoneSurvey/milestone_survey_viewmodel.dart';
import 'package:mobEras/ui/widgets/appbar/ui/moberas_appbar_widget.dart';
import 'package:mobEras/ui/widgets/milestone/milestone_card.dart';
import 'package:mobEras/ui/widgets/msg_panel/msg_panel_viewmodel.dart';
import 'package:mobEras/ui/widgets/msg_panel/msg_panel_widget.dart';
import 'package:stacked/stacked.dart';

class MilestoneSurveyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MilestoneSurveyViewModel>.reactive(
        builder: (context, model, child) => model.dataReady
            ? Scaffold(
                appBar: MoberasAppBar(),
                bottomNavigationBar: RaisedButton(
                    onPressed: () => model.initiDischargeProcedureFlow(),
                    child: Text(
                      'Clique aqui quando receber alta',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
                    )),
                body: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MsgPanelWidget(
                        msgType: MobErasMessageType.local,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: questionPanel(context, model),
                      ),
                      Expanded(
                        flex: 3,
                        child: GridView.count(
                          crossAxisCount: Theme.of(context).textTheme.headline1.fontSize >= 45 ? 2 : 3,
                          padding: EdgeInsets.all(1),
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          shrinkWrap: true,
                          children: List.generate(
                            model.data.length,
                            (index) => MilestoneCard(model.data[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        viewModelBuilder: () => MilestoneSurveyViewModel());
  }

  Container questionPanel(BuildContext context, MilestoneSurveyViewModel model) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              model.titleText,
              style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
