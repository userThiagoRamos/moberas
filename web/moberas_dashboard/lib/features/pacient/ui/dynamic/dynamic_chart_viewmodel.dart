import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/services/chart_service.dart';
import 'package:moberas_dashboard/features/pacient/ui/dynamic/dynamic_chart_view.dart';
import 'package:moberas_dashboard/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DynamicChartViewmodel extends FutureViewModel<List<charts.Series<MyRow, DateTime>>> {
  DynamicChartViewmodel(UserProfile user) {
    selectedPacient = user;
  }
  UserProfile selectedPacient;

  final ChartService _chartService = locator<ChartService>();

  List<charts.Series> seriesList;
  bool animate = false;

  @override
  Future<List<charts.Series<MyRow, DateTime>>> futureToRun() async {
    
    List<charts.Series<MyRow, DateTime>> data = [];
    var chartData = await _chartService.fetchChartData(selectedPacient.uid);

    chartData.forEach((key, value) {
      
      data.add(charts.Series<MyRow, DateTime>(
        id: key,
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.cost,
        displayName: key,      
        data: value,
      ));
      
    });
    return Future.value(data);
  }

  List<charts.Series<MyRow, DateTime>> _createSampleData() {
    final data = [
      new MyRow(new DateTime(2017, 9, 25), 6),
      new MyRow(new DateTime(2017, 9, 26), 8),
      new MyRow(new DateTime(2017, 9, 27), 6),
      new MyRow(new DateTime(2017, 9, 28), 9),
      new MyRow(new DateTime(2017, 9, 29), 11),
      new MyRow(new DateTime(2017, 9, 30), 15),
      new MyRow(new DateTime(2017, 10, 01), 25),
      new MyRow(new DateTime(2017, 10, 02), 33),
      new MyRow(new DateTime(2017, 10, 03), 27),
      new MyRow(new DateTime(2017, 10, 04), 31),
      new MyRow(new DateTime(2017, 10, 05), 23),
    ];

    return [
      new charts.Series<MyRow, DateTime>(
        id: 'Cost',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.cost,
        data: data,
      )
    ];
  }
}
