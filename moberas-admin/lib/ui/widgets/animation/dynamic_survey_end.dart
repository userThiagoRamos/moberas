import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/messages/pacient_message_impl.dart';
import 'package:mobEras/core/services/messages/pacient_message_interface.dart';

class DynamicSurveyEnd extends StatelessWidget {
  final IPacientMessageService _msgService = locator<IPacientMessageService>();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _msgService.fetchDynamicSurveyEndMessage(
                  DynamicSurveyHoursMsg.surveyEnd),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Lottie.asset('assets/lotties/watch.json', fit: BoxFit.contain)
          ],
        ));
  }
}
