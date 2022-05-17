import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:stacked/stacked.dart';

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
        ),
        body: SingleChildScrollView(
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
                sortAscending: model.sortAscending,
                sortColumnIndex: 2,
                columns: [
                  DataColumn(
                    label: Text('Questão'),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text('Resposta'),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text('Data'),
                    onSort: (columnIndex, ascending) =>
                        model.onSortColum(columnIndex, ascending),
                    numeric: false,
                  ),
                ],
                rows: model.data
                    .map(
                      (activity) => DataRow(
                        cells: [
                          DataCell(
                            Text(activity.activity),
                          ),
                          DataCell(
                            Text(activity.responseValue.toString()),
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
        ),
      ),
    );
  }
}
