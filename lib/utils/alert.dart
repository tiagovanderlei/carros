import 'package:flutter/material.dart';

alert({BuildContext context, String msg}){

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
          child: AlertDialog(
            title: Text('Carros'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          onWillPop: () async => false
      );
    }
  );

}