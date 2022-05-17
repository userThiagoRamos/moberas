import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'material_picker.dart';

class PrimaryTextThemeRow extends ViewModelWidget<PacientThemeViewModel> {
  @override
  Widget build(BuildContext context, PacientThemeViewModel model) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: MoberasMaterialPicker(
              'Texto principal',
              model.headline1TextColor,
              model.headline1ColorChanged,
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
                'Tamanho texto principal.',
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: model.headline1TextSize,
                    color: model.headline1TextColor),
              ),
            ),
            Slider(
              value: model.headline1TextSize,
              onChanged: (value) => model.headline1TextSizeChanged(value),
              min: 0,
              max: 100,
              label: '${model.headline1TextSize}',
              divisions: 10,
              onChangeEnd: (value) => model.headline1TextSizeChanged(value),
            ),
          ],
        ))
      ],
    );
  }
}
