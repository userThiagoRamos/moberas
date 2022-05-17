import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function validator;

  const EmailTextField({
    Key key,
    @required this.controller,
    @required this.focusNode,
    @required this.onFieldSubmitted,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(filter: {
      '#': RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
    }, mask: null);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextFormField(
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            obscureText: false,
            textInputAction: TextInputAction.send,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: const EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}
