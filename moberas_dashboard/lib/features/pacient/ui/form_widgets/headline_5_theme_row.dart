import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'material_picker.dart';

class Headline5Row extends ViewModelWidget<PacientThemeViewModel> {
  @override
  Widget build(BuildContext context, PacientThemeViewModel model) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: MoberasMaterialPicker(
              'Caixa de mensagens',
              model.accentColor,
              model.accentColorChanged,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: MoberasMaterialPicker(
              'Texto Caixa de mensagens',
              model.headline5TextColor,
              model.headline5ColorChanged,
            ),
          ),
        ),
        Expanded(
            child: Column(
          children: [
            Container(
              color: model.accentColor == Colors.white
                  ? Colors.grey
                  : model.accentColor,
              child: Text(
                'Tamanho texto caixa de mensagem.',
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: model.headline5TextSize,
                    color: model.headline5TextColor),
              ),
            ),
            Slider(
              value: model.headline5TextSize,
              onChanged: (value) => model.headline5TextSizeChanged(value),
              min: 0,
              max: 80,
              label: '${model.headline5TextSize}',
              divisions: 10,
              onChangeEnd: (value) => model.headline5TextSizeChanged(value),
            ),
          ],
        ))
      ],
    );
  }
}
