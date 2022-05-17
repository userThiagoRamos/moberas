import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/models/milestone.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'mlt_confirm_dialog_viewlmodel.dart';


enum DialogType { base, form }
void setupDialogUi() {
  var dialogService = locator<DialogService>();
  Map<String, dynamic> responseData = {
    'timeOfDay': TimeOfDay.now(),
    'day': 'HOJE'
  };

  dialogService.registerCustomDialogBuilder(
      variant: DialogType.base,
      builder: (context, DialogRequest dialogRequest) {
        var customData = dialogRequest.customData;
        Milestone _mlt = customData['mlt'];
        return ViewModelBuilder<MltConfirmDialogViewModel>.reactive(
            viewModelBuilder: () => MltConfirmDialogViewModel(),
            builder: (context, model, child) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_mlt.description.trim()}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                        ToggleButtons(
                          selectedColor: Theme.of(context).buttonColor,
                          children: <Widget>[
                            Text(
                              ' HOJE ',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(' ONTEM ',
                                style: Theme.of(context).textTheme.headline4),
                            Text(' ANTEONTEM',
                                style: Theme.of(context).textTheme.headline4)
                          ],
                          onPressed: (int index) {
                            model.markDaySeletion(index);
                          },
                          isSelected: model.isDaySelected,
                        ),
                        RaisedButton(
                            child: Text(
                              'Informe o horário',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            onPressed: () async {
                              responseData['timeOfDay'] = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              model.notifyListeners();
                            }),
                        ButtonBar(
                          children: [
                            RaisedButton(
                                child: Text(
                                  'Cancelar',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onPressed: () => dialogService.completeDialog(
                                    DialogResponse(confirmed: false))),
                            Visibility(
                              visible: model.isDaySelected.contains(true),
                              child: RaisedButton(
                                  child: Text(
                                    'Confirmar',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  onPressed: () async {
                                    await dialogService.completeDialog(
                                        DialogResponse(
                                            confirmed: true,
                                            responseData: responseData));
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      });
}
