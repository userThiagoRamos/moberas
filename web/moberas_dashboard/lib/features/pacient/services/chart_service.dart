import 'package:injectable/injectable.dart';
import 'package:moberas_dashboard/features/pacient/services/pacient_service_interface.dart';
import 'package:moberas_dashboard/features/pacient/ui/dynamic/dynamic_chart_view.dart';
import 'package:moberas_dashboard/locator.dart';

@Injectable()
class ChartService {

  final activitieNames = ['pain', 'wellbeing', 'nausea', 'urine', 'drinkeat', 'gas', 'evacuation'];

  final IPacientService _pacientService = locator<IPacientService>();
 

  Future<Map<String, List<MyRow>>> fetchChartData(String pacientUID) async {
    Map<String, List<MyRow>> chartData = {};
    var answers = await _pacientService.fetchDynamicResponseList(pacientUID);
    List<MyRow> chartItemData;
    activitieNames.forEach((name) {
      chartItemData = answers.where((element) => element.activity == name).map((e) => MyRow(e.responseDate, e.responseValue)).toList();
      chartData.putIfAbsent(name, () => chartItemData);
    });
    return Future.value(chartData);
  }
}
