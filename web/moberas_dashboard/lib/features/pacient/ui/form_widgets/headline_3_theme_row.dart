import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'material_picker.dart';

class Headline3Row extends ViewModelWidget<PacientThemeViewModel> {
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
              Expanded(
                child: Text(
                  'Caixa de título da pergunta',
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 3,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MoberasMaterialPicker(
                    'Cor da caixa',
                    model.cardColor,
                    model.cardColorChanged,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: MoberasMaterialPicker(
                    'Cor do texto',
                    model.headline3TextColor,
                    model.headline3ColorChanged,
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
                          : model.cardColor,
                      child: Text(
                        'Título da pergunta.',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            fontSize: model.headline3TextSize,
                            color: model.headline3TextColor),
                      ),
                    ),
                    Slider(
                      value: model.headline3TextSize,
                      onChanged: (value) =>
                          model.headline3TextSizeChanged(value),
                      min: 12,
                      max: 38,
                      label: '${model.headline3TextSize}',
                      divisions: 5,
                      onChangeEnd: (value) =>
                          model.headline3TextSizeChanged(value),
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
