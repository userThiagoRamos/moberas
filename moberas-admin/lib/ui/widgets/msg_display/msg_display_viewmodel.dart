import 'package:stacked/stacked.dart';

class MsgDisplayViewModel extends BaseViewModel {
  double altura = 150.0;
  double largura = 300.0;
  double maxHeight;
  double maxWidht;

  String info = '⚠';

  void setMaxValues(double height, double width) {
    maxHeight = height;
    maxWidht = width;
  }

  void aumentaLargura() {
    largura = maxHeight;
    notifyListeners();
  }

  bool displayMsgs() {
    return false;
  }
}
