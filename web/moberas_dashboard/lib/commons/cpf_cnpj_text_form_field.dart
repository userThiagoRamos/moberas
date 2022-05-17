import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CpfCnpjTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function validator;

  const CpfCnpjTextField({
    Key key,
    @required this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(
        mask: '###.###.###-###', filter: {'#': RegExp(r'[0-9]')});

    return TextFormField(
      inputFormatters: [maskFormatter],
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      obscureText: false,
      onChanged: (value) => value != null && value.length > 14
          ? controller.value = maskFormatter.updateMask(
              mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')})
          : controller.value = maskFormatter.updateMask(
              mask: '###.###.###-###', filter: {'#': RegExp(r'[0-9]')}),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headline5,
      decoration: InputDecoration(
        labelText: 'CPF do paciente',
        alignLabelWithHint: true,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        hintText: 'CPF',
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
