import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'material_picker.dart';

class MobErasButtonTheme extends ViewModelWidget<PacientThemeViewModel> {
  @override
  Widget build(BuildContext context, PacientThemeViewModel model) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Botão',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MoberasMaterialPicker(
                    'Cor',
                    model.buttonColor,
                    model.buttonColorChanged,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: MoberasMaterialPicker(
                    'Cor do texto',
                    model.buttonTextColor,
                    model.buttonTextColorChanged,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    FlatButton(
                      color: model.buttonColor,
                      textColor: model.buttonTextColor,
                      onPressed: () => null,
                      child: Text(
                        'Botão moberas',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: model.buttonTextColor,
                            fontSize: model.buttonTexSize),
                      ),
                    ),
                    Slider(
                      value: model.buttonTexSize,
                      onChanged: (value) => model.buttonTextSizeChanged(value),
                      min: 0,
                      max: 80,
                      label: '${model.buttonTexSize}',
                      divisions: 10,
                      onChangeEnd: (value) =>
                          model.buttonTextSizeChanged(value),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
