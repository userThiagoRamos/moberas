import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'material_picker.dart';

class Headline2Row extends ViewModelWidget<PacientThemeViewModel> {
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
                'Caixa de push',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: MoberasMaterialPicker(
                          'Cor',
                          model.accentColor,
                          model.accentColorChanged,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: MoberasMaterialPicker(
                          'Cor do texto',
                          model.headline2TextColor,
                          model.headline2ColorChanged,
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
                        Container(
                          color: model.accentColor == Colors.white
                              ? Colors.grey
                              : model.accentColor,
                          child: Text(
                            'Tamanho texto caixa de push.',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    fontSize: model.headline2TextSize,
                                    color: model.headline2TextColor),
                          ),
                        ),
                        Slider(
                          value: model.headline2TextSize,
                          onChanged: (value) =>
                              model.headline2TextSizeChanged(value),
                          min: 0,
                          max: 80,
                          label: '${model.headline2TextSize}',
                          divisions: 10,
                          onChangeEnd: (value) =>
                              model.headline2TextSizeChanged(value),
                        ),
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
