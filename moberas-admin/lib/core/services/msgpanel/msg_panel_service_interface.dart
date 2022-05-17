abstract class IMsgPanelService {
  Stream<String> get defaultMessage$;
  void fcmMessageCallback(String msg);
  Stream<String> get fcmMessage$;
}
