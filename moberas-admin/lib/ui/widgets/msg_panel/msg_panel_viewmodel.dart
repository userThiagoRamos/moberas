import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/msgpanel/msg_panel_service_interface.dart';
import 'package:mobEras/core/utils/moberas_helpers_methods.dart';
import 'package:stacked/stacked.dart';

enum MobErasMessageType { push, local }

class MsgPanelViewModel extends MultipleStreamViewModel {
  final IMsgPanelService _msgPanelService = locator<IMsgPanelService>();

  @override
  Map<String, StreamData> get streamsMap => {
        enumToString(MobErasMessageType.local):
            StreamData(_msgPanelService.defaultMessage$),
        enumToString(MobErasMessageType.push):
            StreamData(_msgPanelService.fcmMessage$)
      };

  @override
  void onData(key, data) {
    super.onData(key, data);
  }
}
