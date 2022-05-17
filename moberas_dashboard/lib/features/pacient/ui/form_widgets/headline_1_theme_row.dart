import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'material_picker.dart';

class Headline1Row extends ViewModelWidget<PacientThemeViewModel> {
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
                child: Center(
                  child: Text(
                    'Caixa de resposta',
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 2,
                  ),
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
                    model.primaryColor,
                    model.primaryColorChanged,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: MoberasMaterialPicker(
                    'Cor do texto',
                    model.headline1TextColor,
                    model.headline1ColorChanged,
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
                          : model.primaryColor,
                      child: Text(
                        'Tamanho texto da pergunta.',
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: model.headline1TextSize,
                            color: model.headline1TextColor),
                      ),
                    ),
                    Slider(
                      value: model.headline1TextSize,
                      onChanged: (value) =>
                          model.headline1TextSizeChanged(value),
                      min: 0,
                      max: 38,
                      label: '${model.headline1TextSize}',
                      divisions: 4,
                      onChangeEnd: (value) =>
                          model.headline1TextSizeChanged(value),
                    )
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
