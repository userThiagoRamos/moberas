import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:mobEras/core/models/survey_response.dart';
import 'package:mobEras/ui/widgets/milestone/milestone_card_viewmodel.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';

class MilestoneCard extends StatefulWidget {
  final Milestone _milestone;

  const MilestoneCard(this._milestone);

  @override
  _MilestoneCardState createState() => _MilestoneCardState();
}

class _MilestoneCardState extends State<MilestoneCard> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MilestoneCardViewModel>.reactive(
      viewModelBuilder: () => MilestoneCardViewModel(),
      builder: (context, model, child) => !model.isBusy
          ? GestureDetector(
              onTap: () async {
                await model.audioService.open();
                final dateTimeResponse = await showDatePicker(
                  context: context,
                  locale: const Locale('pt', 'BR'),
                  firstDate: DateTime(2000),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2050),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.dark(),
                      child: child,
                    );
                  },
                );
                if (dateTimeResponse != null) {
                  await model.audioService.buttonClick();
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    },
                  );

                  if (time != null) {
                    await model.audioService.buttonClick();
                  }
                  unawaited(
                    model.registerResponse(
                      milestone: widget._milestone,
                      surveyResponse: SurveyResponse(
                        dateTime: DateTimeField.combine(dateTimeResponse, time),
                      ),
                    ),
                  );
                  await model.audioService.answered();
                }
              },
              child: Container(
                margin: EdgeInsets.all(2.0),
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    widget._milestone.description.toUpperCase(),
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
