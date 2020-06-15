import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String msg;
  Function acao;
  
  TextError({this.msg, this.acao});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: acao,
      child: Center(
        child: Text(
          msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
