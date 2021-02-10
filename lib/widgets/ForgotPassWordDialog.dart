import 'package:Deliciousness/auth0/auth0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deliciousness/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Deliciousness/widgets/InfoDialogPopUp.dart';


class ForgotPassWordDialog extends StatefulWidget{
  
  final Auth0Client auth0client;
  
  ForgotPassWordDialog({this.auth0client});
  
  @override
  _ForgotPassWordDialog createState() => _ForgotPassWordDialog();
}

class _ForgotPassWordDialog extends State<ForgotPassWordDialog> {

  final myEmailController = TextEditingController();
  bool userNameValidateText = false;
  bool txtSent = false;

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

  @override
  void dispose() {
    myEmailController.dispose();
    super.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Password Reset",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(45),
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
              SizedBox(height: 15),
              SizedBox(height: 22),
              TextFormField(
                onChanged: (text) {
                  setState(() {
                    userNameValidateText = this.myEmailController.text.isEmpty;
                  });
                },
                controller: myEmailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                  errorText: userNameValidateText ? 'Email Can\'t Be Empty' : null,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ),
              SizedBox(height: 15),
              Text(
                  'Enter your email address to reset you password',
                  style: TextStyle(fontSize: 12.0),
              ),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: 95,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        onPressed: (){

                            setState(() {
                              this.userNameValidateText = this.myEmailController.text.isEmpty;
                            });

                            if(this.myEmailController.text.isNotEmpty){
                                resetEmail();
                            }

                        },
                        textColor: Colors.white,
                        color: Colors.green,
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0,0,0,0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  color: Colors.green,
                                  padding: EdgeInsets.fromLTRB(25, 4, 4, 4),
                                  child: Text('Reset',
                                    style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            )
                        )
                    )
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  void resetEmail() async {
      var params = new Map<String, dynamic>();
          params['email'] = this.myEmailController.text;
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
