import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {Key key,
      this.controller,
      this.onFieldSubmitted,
      this.validator,
      this.hintText,
      this.prefixIcon,
      this.textInputAction,
      this.textInputType,
      this.inputFormatters,
      this.maxLenght,
      this.focusNode,
      this.label})
      : super(key: key);

  final TextEditingController controller;
  final Function onFieldSubmitted;
  final Function validator;
  final String hintText;
  final Icon prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final int maxLenght;
  final FocusNode focusNode;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      maxLength: maxLenght,
      keyboardType: textInputType,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label ?? hintText,
        alignLabelWithHint: true,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
