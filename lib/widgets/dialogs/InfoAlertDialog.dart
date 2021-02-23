import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:flutter/material.dart';

class InfoAlertDialog extends CustomAlertDialog{

  String title;
  String body;

  InfoAlertDialog({this.title, this.body});

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: Text(getBody()),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Ok'),
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