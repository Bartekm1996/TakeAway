import 'package:Deliciousness/LoginScreen.dart';
import 'package:Deliciousness/MenuScreen.dart';
import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:flutter/material.dart';

class ActionAlertDialog extends CustomAlertDialog{

  String title;
  String body;
  String buttonOne;
  String buttonTwo;

  ActionAlertDialog({this.title, this.body, this.buttonOne, this.buttonTwo});

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: Text(getBody()),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(this.buttonTwo),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(this.buttonOne),
        )
      ],
    );
  }

  @override
  String getBody(){
    return this.body;
  }

  @override
  String getTitle() {
    return this.title;
  }

}