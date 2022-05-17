import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobEras/ui/views/pacient_form/pacient_form_viewmodel.dart';
import 'package:mobEras/ui/widgets/appbar/ui/moberas_appbar_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class PacientFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PacientFormViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              appBar: MoberasAppBar(),
              persistentFooterButtons: model.showConfirmButton()
                  ? [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.green,
                          child: RaisedButton(
                            color: Colors.transparent,
                            onPressed: () => model.goHome(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            child: Text('Confirmar'),
                          ),
                        ),
                      )
                    ]
                  : null,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Informe as datas',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    BasicDateField('Data de internação'),
                    BasicDateField('Data da cirurgia')
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => PacientFormViewModel());
  }
}

class BasicDateField extends HookViewModelWidget<PacientFormViewModel> {
  final String title;
  BasicDateField(this.title, {Key key}) : super(key: key, reactive: true);
  @override
  Widget buildViewModelWidget(
      BuildContext context, PacientFormViewModel model) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 10)),
                  lastDate: DateTime.now().add(
                    Duration(days: 365),
                  ),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.dark(),
                      child: child,
                    );
                  },
                );
                if (date != null) {
                  var timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    },
                  );
                  if (timeOfDay != null) {
                    date = Jiffy(date)
                        .add(duration: Duration(hours: timeOfDay.hour));
                    date = Jiffy(date)
                        .add(duration: Duration(minutes: timeOfDay.minute));
                    await model.setData(title, date);
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 28.0,
                                color: Colors.teal,
                              ),
                              Text(
                                ' ${model.formattedDate(title)}',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
