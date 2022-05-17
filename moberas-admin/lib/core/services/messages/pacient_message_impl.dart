import 'package:injectable/injectable.dart';
import 'package:mobEras/core/services/messages/pacient_message_interface.dart';

enum DynamicSurveyHoursMsg { surveyEnd, surveyBegin, surveyInProgress }

@Singleton(as: IPacientMessageService)
class PacientMessageImpl implements IPacientMessageService {
  String _hours = '4 horas';
  @override
  String get hours => _hours;
  @override
  set hours(String hours) {
    _hours = hours;
  }

  final String hoursKey = '#hours#';
  final Map<DynamicSurveyHoursMsg, String> msg = {
    DynamicSurveyHoursMsg.surveyEnd:
        'Obrigado por nos dizer como você passou! Daqui a #hours# vamos querer saber novamente como você está. Você receberá um alerta!',
    DynamicSurveyHoursMsg.surveyInProgress:
        'Nos diga como você passou as últimas #hours#',
    DynamicSurveyHoursMsg.surveyBegin:
        'Como você passou as últimas #hours#? Clique na figura ou número que serão apresentados que melhor representam as suas últimas #hours#'
  };

  @override
  String fetchDynamicSurveyEndMessage(DynamicSurveyHoursMsg type) =>
      msg[type].replaceAll(hoursKey, hours);
}
