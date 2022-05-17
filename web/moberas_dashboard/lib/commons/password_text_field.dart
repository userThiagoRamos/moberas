import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function validator;

  PasswordTextFormField({
    Key key,
    @required this.controller,
    @required this.focusNode,
    @required this.onFieldSubmitted,
    @required this.validator,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  Color getColor() {
    if (showPassword == false) {
      return Theme.of(context).primaryColorDark;
    }
    return Theme.of(context).primaryColorLight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        focusNode: widget.focusNode,
        obscureText: showPassword,
        textInputAction: TextInputAction.send,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          hintText: 'Senha',
          prefixIcon: Icon(Icons.lock),
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: getColor(),
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
      ),
    );
  }
}
