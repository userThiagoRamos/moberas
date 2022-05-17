import 'package:intl/intl.dart';
import 'package:mobEras/core/firestore_data_wrapper.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PacientFormViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final format = DateFormat('dd/MM/yyyy');
  final Map<String, DateTime> _dataMap = {};

  @override
  void dispose() {
    _dataMap.clear();
    super.dispose();
  }

  DateTime getValueDataMap(String title) {
    return _dataMap[title];
  }

  void setValueDataMap(String title, DateTime value) {
    var aux = title.trim();
    _dataMap[aux] = value;
  }

  void setData(String title, DateTime currentValue) {
    setValueDataMap(title, currentValue);
    if (currentValue != null) {
      UserProfileData().upsert(
          {title.replaceAll(' ', '').trim().toLowerCase(): currentValue});

      formattedDate(title);
      notifyListeners();
    }
  }

  bool showConfirmButton() {
    return _dataMap['Data de internação'] != null &&
        _dataMap['Data da cirurgia'] != null;
  }

  String formattedDate(String title) {
    try {
      if (title != null) {
        return '$title ${format.format(_dataMap[title.trim()])}';
      } else {
        return 'Clique para informar a ${title}';
      }
    } catch (e) {
      Logger.e('date format', e: e);
      return 'Clique para a ${title}';
    }
  }

  String actionTitle(String title) {
    if (getValueDataMap(title) == null) {
      return ' Informar';
    } else {
      return ' Mudar';
    }
  }

  void goHome() {
    UserProfileData().upsert({'status': 'inactive','online':false});
    _navigation.navigateTo(Routes.dischargeView);
  }
}
