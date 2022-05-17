import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/ui/milestone/milestone_report_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MilestoneReportView extends StatelessWidget {
  final UserProfile profile;
  MilestoneReportView({this.profile});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MilestoneReportViewModel>.reactive(
      viewModelBuilder: () => MilestoneReportViewModel(profile),
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
                  'Relatório questionário estático',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              DataTable(
                sortAscending: model.sortAscending,
                sortColumnIndex: 1,
                columns: [
                  DataColumn(
                    label: Text('Questão'),
                    numeric: false,
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
                      (milestone) => DataRow(
                        cells: [
                          DataCell(
                            Text(milestone.milestone),
                          ),
                          DataCell(
                            Text(milestone.formatedDate),
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
