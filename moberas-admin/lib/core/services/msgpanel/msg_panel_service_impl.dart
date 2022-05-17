import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobEras/core/services/msgpanel/msg_panel_service_interface.dart';
import 'package:rxdart/rxdart.dart';

final List<String> _defaultMessages = [
  'Faça todas as refeições na mesa e não na cama!',
  'Fique pelo menos 8 horas fora do leito!',
  'Faça pelo menos 6 caminhadas ao longo do dia!',
  'Movimente bastante as pernas!',
  'Se movimente! É a melhor forma para que sua recuperação seja mais rápida!'
];

@Singleton(as: IMsgPanelService)
class MsgService implements IMsgPanelService {
  int _staticMessagesCurrentIndex = 0;
  Timer defaultMessageFrequencyTimer;
  final BehaviorSubject<String> _defaultMessageSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _fcmMessageSubject = BehaviorSubject<String>();

  MsgService() {
    defaultMessageFrequencyTimer ??
        Timer.periodic(Duration(seconds: 60), defaultMessageSelector);
    _defaultMessageSubject.add(_defaultMessages[0]);
  }

  @override
  Stream<String> get defaultMessage$ =>
      _defaultMessageSubject.asBroadcastStream();

  @override
  Stream<String> get fcmMessage$ => _fcmMessageSubject.asBroadcastStream();

  @override
  void fcmMessageCallback(String msg) {
    _defaultMessageSubject.add(msg);
  }

  void defaultMessageSelector(Timer timer) {
    if (_staticMessagesCurrentIndex >= _defaultMessages.length) {
      _staticMessagesCurrentIndex = 0;
    }
    _defaultMessageSubject.add(_defaultMessages[_staticMessagesCurrentIndex]);
    _staticMessagesCurrentIndex++;
  }
}
