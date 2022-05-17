/// Example of timeseries chart with a custom number of ticks
///
/// The tick count can be set by setting the [desiredMinTickCount] and
/// [desiredMaxTickCount] for automatically adjusted tick counts (based on
/// how 'nice' the ticks are) or [desiredTickCount] for a fixed tick count.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/ui/dynamic/dynamic_chart_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DynamicChartView extends StatelessWidget {
  final UserProfile profile;
  DynamicChartView({this.profile});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DynamicChartViewmodel>.reactive(
        viewModelBuilder: () => DynamicChartViewmodel(profile),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Graficos'),
              ),
              body: model.dataReady
                  ? Container(
                      child: charts.TimeSeriesChart(
                        model.data,
                        // dateTimeFactory: const charts.LocalDateTimeFactory(),
                        animate: true,
                        behaviors: [
                          new charts.SeriesLegend(
                            // Positions for "start" and "end" will be left and right respectively
                            // for widgets with a build context that has directionality ltr.
                            // For rtl, "start" and "end" will be right and left respectively.
                            // Since this example has directionality of ltr, the legend is
                            // positioned on the right side of the chart.
                            position: charts.BehaviorPosition.end,
                            // For a legend that is positioned on the left or right of the chart,
                            // setting the justification for [endDrawArea] is aligned to the
                            // bottom of the chart draw area.
                            outsideJustification: charts.OutsideJustification.startDrawArea,
                            // By default, if the position of the chart is on the left or right of
                            // the chart, [horizontalFirst] is set to false. This means that the
                            // legend entries will grow as new rows first instead of a new column.
                            horizontalFirst: false,
                            // By setting this value to 2, the legend entries will grow up to two
                            // rows before adding a new column.
                            desiredMaxRows: 2,
                            // This defines the padding around each legend entry.
                            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 14.0),
                            // Render the legend entry text with custom styles.
                            entryTextStyle: charts.TextStyleSpec(color: charts.Color(r: 127, g: 63, b: 191), fontFamily: 'Georgia', fontSize: 22),
                          )
                        ],
                      ),
                    )
                  // primaryMeasureAxis:  charts.NumericAxisSpec(
                  //   tickProviderSpec:  charts.BasicNumericTickProviderSpec(desiredTickCount: 1),
                  // ),
                  // secondaryMeasureAxis:  charts.NumericAxisSpec(
                  //   tickProviderSpec:  charts.BasicNumericTickProviderSpec(desiredTickCount: 1),
                  // ),

                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ));
  }

  /// Create one series with sample hard coded data.

}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int cost;
  MyRow(this.timeStamp, this.cost);
}
