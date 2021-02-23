import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CustomAlertDialog{
  String getTitle();
  String getBody();
  Widget create(BuildContext context);

  Future<void> show(BuildContext context) async{
      var dialog = create(context);

      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext _){
          return dialog;
        },
      );
  }
}