import 'package:mobEras/core/services/messages/pacient_message_impl.dart';

abstract class IPacientMessageService {
  String get hours;
  void set hours(String hours);
  String fetchDynamicSurveyEndMessage(DynamicSurveyHoursMsg type);
}
