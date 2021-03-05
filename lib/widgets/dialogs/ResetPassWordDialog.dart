import 'package:Deliciousness/api/auth/auth.dart';
import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:Deliciousness/widgets/dialogs/InfoAlertDialog.dart';
import 'package:flutter/material.dart';

class ResetPassWordDialog extends CustomAlertDialog{

  String title;
  String body;
  String accessToken;

  ResetPassWordDialog({this.title, this.body, this.accessToken});

  @override
  Widget create(BuildContext context) {
    return _TextFieldsDialog(title: this.title, body: this.body);
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

class _TextFieldsDialog extends StatefulWidget{

  final String title;
  final String body;
  final String accessToken;

  _TextFieldsDialog({this.title, this.body, this.accessToken});

  @override
  _TextFieldsStateDialog createState() => _TextFieldsStateDialog();
}

class _TextFieldsStateDialog extends State<_TextFieldsDialog>{

  TextEditingController passwordController;
  TextEditingController confirmPassWordController;
  bool errorMessage = false;

  @override
  void initState() {
    this.passwordController = new TextEditingController();
    this.confirmPassWordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.widget.title),
      content: Column(
        children: <Widget>[
          Text(this.widget.body),
          SizedBox(height: 10),
          new TextField(
            decoration: new InputDecoration(hintText: "Enter Password"),
            controller: passwordController,
            onChanged: (text) {
              if(text == this.passwordController.text){
                setState(() {
                  this.errorMessage = false;
                });
              }
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Confirm Password"),
            controller: confirmPassWordController,
            onChanged: (text) {
              if(text == this.passwordController.text){
                setState(() {
                  this.errorMessage = false;
                });
              }
            },
          ),
          if(errorMessage)
          Text('Password don\'t match'),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
        ),
        FlatButton(
          onPressed: () {
            if(this.passwordController.text == this.confirmPassWordController.text){
              Auth().resetPassword(this.widget.accessToken, this.confirmPassWordController.text).then((value) => {
                Navigator.of(context).pop(),
              });
            }else{
              setState(() {
                errorMessage = true;
              });
            }
          },
          child: Text('Change Password'),
        )
      ],
    );
  }

}