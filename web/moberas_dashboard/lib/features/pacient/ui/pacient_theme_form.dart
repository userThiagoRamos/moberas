import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:moberas_dashboard/features/pacient/ui/form_widgets/headline_2_theme_row.dart';
import 'package:moberas_dashboard/features/pacient/ui/pacient_theme_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'form_widgets/headline_1_theme_row.dart';
import 'form_widgets/headline_3_theme_row.dart';
import 'form_widgets/moberas_button_theme.dart';

class PacientThemeForm extends ViewModelWidget<PacientThemeViewModel> {
  @override
  Widget build(BuildContext context, PacientThemeViewModel model) {
    return Scaffold(
        bottomNavigationBar: RaisedButton(
          onPressed: () => model.updateTheme(),
          color: Colors.green,
          child: Text(
            'Atualizar tema',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
                key: model.formKey,
                autovalidate: true,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Headline2Row(),
                        Headline3Row(),
                        Headline1Row(),
                        MobErasButtonTheme()
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }

  Widget materialPicker(
      String label, Color pickerColor, Function(Color) onChanged) {
    return Builder(
        builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$label', style: Theme.of(context).textTheme.headline5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.white)),
                      elevation: 3.0,
                      child: Text(label),
                      color: pickerColor,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'Selecione a cor principal para o formulário'),
                              content: SingleChildScrollView(
                                child: MaterialPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (value) => onChanged(value),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ));
  }

  Widget colorPickerFormField(
      String label, Color pickerColor, Function(Color) onChanged) {
    return Builder(
      builder: (context) => Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headline3,
          ),
          ColorPicker(
            labelTextStyle: Theme.of(context).textTheme.headline3,
            pickerColor: pickerColor,
            onColorChanged: (value) => onChanged(value),
            pickerAreaHeightPercent: 0.7,
            displayThumbColor: false,
            showLabel: false,
            paletteType: PaletteType.hsl,
            pickerAreaBorderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(2.0),
              topRight: const Radius.circular(2.0),
            ),
          ),
        ],
      ),
    );
  }
}
