import 'package:flutter/material.dart';
import 'package:mobEras/core/services/messages/pacient_message_impl.dart';
import 'package:mobEras/ui/views/dynamicSurvey/dynamic_survey_viewmodel.dart';
import 'package:mobEras/ui/widgets/activity/activity_card.dart';
import 'package:mobEras/ui/widgets/appbar/ui/moberas_appbar_widget.dart';
import 'package:stacked/stacked.dart';

class DynamicSurveyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DynamicSurveyViewModel>.reactive(
        viewModelBuilder: () => DynamicSurveyViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: MoberasAppBar(),
              body: model.dataReady
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Visibility(
                          visible: model.data.name != 'intro' && model.data.name != 'final',
                          child: Container(
                            color: Theme.of(context).accentColor,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(model.msgService.fetchDynamicSurveyEndMessage(DynamicSurveyHoursMsg.surveyInProgress),
                                        textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: model.data.name != 'intro' && model.data.name != 'final',
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(model.data.question, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 6, child: ActivityCard(model.data))
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ));
  }
}
