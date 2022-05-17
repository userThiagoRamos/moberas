import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:moberas_dashboard/features/response/model/activity_response.dart';
import 'package:moberas_dashboard/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../locator.dart';

class DynamicReportViewModel extends StreamViewModel<List<ActivityResponse>> {
  DynamicReportViewModel(UserProfile user) {
    selectedPacient = user;
  }
  UserProfile selectedPacient;
  final IPacientService _pacientService = locator<IPacientService>();
  final NavigationService _navService = locator<NavigationService>();
  @override
  Stream<List<ActivityResponse>> get stream => streamDynamic();

  bool sortAscending = true;

  Stream<List<ActivityResponse>> streamDynamic() {
    return _pacientService.streamDynamicResponseList(selectedPacient.uid);
  }

  @override
  void onData(List<ActivityResponse> data) {
    super.onData(data);
    onSortColum(2,true);
  }

  void onSortColum(int columnIndex, bool ascending) {
    sortAscending = !sortAscending;
    if (columnIndex == 2) {
      if (ascending) {
        data.sort((a, b) => a.responseDate.compareTo(b.responseDate));
      } else {
        data.sort((a, b) => b.responseDate.compareTo(a.responseDate));
      }
    }
    notifyListeners();
  }

  String processAnswer(int responseValue, String activity) {
    String answer = '';
    switch (activity) {
      case 'pain':
        answer = responseValue.toString();
        break;
      case 'wellbeing':
        answer = wellbeingResponseTranslation(responseValue);
        break;
      case 'nausea':
        answer = nauseResponseTranslation(responseValue);
        break;
      case 'urine':
        answer = urineResponseTranslation(responseValue);
        break;
      case 'drinkeat':
        answer = drinkeatResponseTranslation(responseValue);
        break;
      case 'gas':
        answer = responseValue == 1 ? 'Sim' : 'Não';
        break;
      case 'evacuation':
        answer = responseValue == 1 ? 'Sim' : 'Não';
        break;
      default:
    }
    return answer;
  }

   String processActivityName(String activity) {
    String answer = '';
    switch (activity) {
      case 'intro':
        answer = 'Chamada para questionário foi apresentada na tela';
        break;
      case 'pain':
        answer = 'Nível de dor';
        break;
      case 'wellbeing':
        answer = 'Bem-estar geral';
        break;
      case 'nausea':
        answer = 'Nível de náuseas e vômitos';
        break;
      case 'urine':
        answer = 'Volume de urina';
        break;
      case 'drinkeat':
        answer = 'O quanto conseguiu comer e beber';
        break;
      case 'gas':
        answer = 'Eliminou gases?';
        break;
      case 'evacuation':
        answer = 'Evacuou?';
        break;
      default:
    }
    return answer;
  }

  String wellbeingResponseTranslation(int responseValue) {
    String wellbeing = '';
    switch (responseValue) {
      case 1:
        wellbeing = 'Muito Bem';
        break;
      case 2:
        wellbeing = 'Bem';
        break;
      case 3:
        wellbeing = 'Mais ou menos';
        break;
      case 4:
        wellbeing = 'Mal';
        break;
      case 5:
        wellbeing = 'Muito mal';
        break;
      default:
    }
    return wellbeing;
  }

  String nauseResponseTranslation(int responseValue) {
    String nausea = '';
    switch (responseValue) {
      case 1:
        nausea = 'Sem náuseas';
        break;
      case 2:
        nausea = 'Pouco nauseada';
        break;
      case 3:
        nausea = 'Nauseada';
        break;
      case 4:
        nausea = 'Muito nauseada';
        break;
      case 5:
        nausea = 'Vomitei';
        break;
      default:
    }
    return nausea;
  }

  String urineResponseTranslation(int responseValue) {
    String urine = '';
    switch (responseValue) {
      case 1:
        urine = 'Urinei muito';
        break;
      case 2:
        urine = 'Urinei normal';
        break;
      case 3:
        urine = 'Urinei pouco';
        break;
      case 4:
        urine = 'Urinei muito pouco';
        break;
      case 5:
        urine = 'Urinei nada';
        break;
      default:
    }
    return urine;
  }

  String drinkeatResponseTranslation(int responseValue) {
    String drinketa = '';
    switch (responseValue) {
      case 1:
        drinketa = 'Bem';
        break;
      case 2:
        drinketa = 'Mais ou menos';
        break;
      case 3:
        drinketa = 'Pouco';
        break;
      case 4:
        drinketa = 'Muito pouco';
        break;
      case 5:
        drinketa = 'Nada';
        break;
      default:
    }
    return drinketa;
  }

  generateChart() {
    _navService.navigateTo(Routes.dynamicChartView);
  }
}
