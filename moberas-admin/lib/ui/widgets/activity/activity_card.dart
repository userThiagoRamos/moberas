import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mobEras/core/localization/localization.dart';
import 'package:mobEras/core/models/activity.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/core/services/messages/pacient_message_impl.dart';
import 'package:mobEras/ui/widgets/activity/activity_card_viewmodel.dart';
import 'package:mobEras/ui/widgets/animation/dynamic_survey_end.dart';
import 'package:mobEras/ui/widgets/pain_scale/pain_scale.dart';
import 'package:stacked/stacked.dart';

class ActivityCard extends StatelessWidget {
  final Activity _activity;

  ActivityCard(this._activity);

  @override
  Widget build(BuildContext context) {
    final _local = AppLocalizations.of(context);
    return ViewModelBuilder<ActivityCardViewModel>.reactive(
      viewModelBuilder: () => ActivityCardViewModel(_activity),
      builder: (context, model, child) => model.dataReady
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                    offset: Offset(
                      10.0,
                      10.0,
                    ))
              ]),
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Container(
                  child: !model.showReward
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: itens(model, _local, context),
                        )
                      : Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: model.lottie,
                        ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  List<Widget> itens(ActivityCardViewModel model, AppLocalizations local,
      BuildContext context) {
    Map<String, String> imageMap = model.data;
    List<Widget> list = [];
    if (_activity.name == 'final') {
      list.add(
        getEndWidget(),
      );
    } else if (_activity.name == 'intro') {
      list.add(
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      model.msgService.fetchDynamicSurveyEndMessage(
                          DynamicSurveyHoursMsg.surveyBegin),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    child: Text(
                      'Clique no botão abaixo para iniciar o questionário',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: RawMaterialButton(
                    onPressed: () async =>
                        model.dismissIntro(activity: _activity),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(Icons.play_arrow,
                        size: 150.0, color: Colors.green),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      for (MapEntry imageMapEntry in imageMap.entries) {
        if (!(imageMapEntry.key as String).contains('zerototen') &&
            !(imageMapEntry.key as String).contains('1_yes') &&
            !(imageMapEntry.key as String).contains('2_no')) {
          list.add(Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => model.registerAnswer(
                  activity: _activity,
                  response: SurveyResponse(
                      selectedValue:
                          model.getSelectedValue(imageMapEntry.key))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage(imageMapEntry.value),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                        local.translate(
                            model.getImgDescription(imageMapEntry.key)),
                        style: Theme.of(context).textTheme.headline1),
                  ),
                ],
              ),
            ),
          ));
        } else if ((imageMapEntry.key as String).contains('2_no')) {
          list.add(Expanded(
            child: GestureDetector(
              onTap: () => model.registerAnswer(
                  activity: _activity,
                  response: SurveyResponse(
                      selectedValue:
                          model.getSelectedValue(imageMapEntry.key))),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage(imageMapEntry.value),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 79.0),
                      child: Text(
                          local.translate(
                              model.getImgDescription(imageMapEntry.key)),
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  )
                ],
              ),
            ),
          ));
        } else if ((imageMapEntry.key as String).contains('1_yes')) {
          list.add(Expanded(
            child: GestureDetector(
              onTap: () => model.registerAnswer(
                  activity: _activity,
                  response: SurveyResponse(
                      selectedValue:
                          model.getSelectedValue(imageMapEntry.key))),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage(imageMapEntry.value),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                      child: Text(
                          local.translate(
                              model.getImgDescription(imageMapEntry.key)),
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  )
                ],
              ),
            ),
          ));
        } else {
          list.add(Expanded(
            flex: 1,
            child: PainScale(
              selectedCallback: (value) => model.registerAnswer(
                activity: _activity,
                response: SurveyResponse(selectedValue: value.toInt()),
              ),
            ),
          ));
        }
      }
    }

    return list;
  }

  Expanded getEndWidget() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: DynamicSurveyEnd(),
            ),
          ],
        ),
      ),
    );
  }
}
