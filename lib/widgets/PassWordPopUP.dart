import 'dart:convert';

import 'package:Deliciousness/auth0/auth0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deliciousness/utils/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'InfoDialogPopUp.dart';


final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class PassWordDialogPopUp extends StatefulWidget {


  final String title;
  final String description;
  final String accessToken;
  final String email;
  final String sub;
  final Auth0Client auth0client;
  final VoidCallback voidCallback;

  PassWordDialogPopUp({this.title, this.description, this.voidCallback, this.accessToken, this.email, this.auth0client, this.sub});

  @override
  _PassWordDialogPopUp createState() => _PassWordDialogPopUp();
}

class _PassWordDialogPopUp extends State<PassWordDialogPopUp>{
  bool isGoogleTwoFactorEnabled = false;
  String mfaToken;
  String recoveryCode;
  String phoneNumber = "Not Enrolled";

  @override
  void initState() {
    super.initState();
  }

  Future<String> getMfaToken() async {
    return await secureStorage.read(key: 'mfa_token');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  resetEmail();
                },
                child: Text('Send Password reset email'),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                        Navigator.of(context).pop();
                    },
                    child: Text('Close',style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void resetEmail() async {
    var params = new Map<String, dynamic>();
    params['email'] = this.widget.email;
    params['connection'] = 'Username-Password-Authentication';

    final result = await this.widget.auth0client.resetPassword(params);

    if(result != null){
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBoxState(title: 'Email Sent',description: 'Please check your inbox for instructions how to reset your password');
          }
      );
    }
  }


}
