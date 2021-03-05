import 'package:Deliciousness/api/restaurant/food/food.dart';
import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:flutter/material.dart';

class PizzaToppingsInfoDialog extends CustomAlertDialog{

  String title;
  String body;
  List<Topping> toppings;

  PizzaToppingsInfoDialog({this.title, this.body, this.toppings});

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: Column(
        children: <Widget>[
        ],
      ),
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