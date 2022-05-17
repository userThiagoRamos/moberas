import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/locator.dart';
import 'package:moberas_dashboard/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:js' as js;
import 'dynamic_report_viewmodel.dart';

class DynamicReportView extends StatelessWidget {
  final UserProfile profile;
  DynamicReportView({this.profile});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DynamicReportViewModel>.reactive(
      viewModelBuilder: () => DynamicReportViewModel(profile),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(profile.displayName),
          actions: [
            IconButton(icon: Icon(Icons.print), onPressed: () => js.context.callMethod('print', [])),
            IconButton(icon: Icon(Icons.bar_chart), onPressed: () => locator<NavigationService>().navigateTo(Routes.dynamicChartView,arguments: DynamicChartViewArguments(profile: profile)))
          ],
        ),
        body: model.dataReady
            ? dataTable(context, model)
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  SingleChildScrollView dataTable(BuildContext context, DynamicReportViewModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Relatório questionário dinâmico',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          DataTable(
            showBottomBorder: true,
            
            sortAscending: model.sortAscending,
            sortColumnIndex: 2,
            columns: [
              DataColumn(
                label: Text('Questão'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Resposta'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Data'),
                onSort: (columnIndex, ascending) => model.onSortColum(columnIndex, ascending),
                numeric: false,
              ),
            ],
            rows: model.data
                .map(
                  (activity) => DataRow(
                    cells: [
                      DataCell(
                        Text(model.processActivityName(activity.activity)),
                      ),
                      DataCell(
                        Text(model.processAnswer(activity.responseValue, activity.activity)),
                      ),
                      DataCell(
                        Text(activity.formatedDate),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
