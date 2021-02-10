import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deliciousness/utils/constant.dart';

class CloseAccountDialogPopUp extends StatelessWidget {

  final String title;
  final String description;
  final VoidCallback voidCallback;

  CloseAccountDialogPopUp({this.title, this.description, this.voidCallback});

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
              SizedBox(height: 15),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      if(this.voidCallback == null){
                        Navigator.of(context).pop();
                      }else {
                        voidCallback;
                      }
                    },
                    child: Text('Close',style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
