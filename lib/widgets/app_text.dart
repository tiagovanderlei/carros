import 'package:flutter/material.dart';


class AppText extends StatelessWidget {

  String label;
  String hint;
  bool obscure;
  TextEditingController textController;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  Function onFieldSubmitted;

  AppText({
    @required this.label,
    @required this.hint,
    this.obscure: false,
    @required this.textController,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      obscureText: obscure,
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
//        border: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(16)
//        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 16),
      ),
      controller: textController,
      focusNode: focusNode,
    );
  }
}