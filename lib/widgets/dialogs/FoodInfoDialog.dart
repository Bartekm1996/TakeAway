import 'package:Deliciousness/api/restaurant/food/food.dart';
import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:flutter/material.dart';

class FoodInfoDialog extends CustomAlertDialog{

  String title;
  String body;
  dynamic item;

  FoodInfoDialog({this.title, this.body, this.item});

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: Column(
        children: <Widget>[
          Text(foodType()),
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


  dynamic foodType() {
    switch (this.item.runtimeType) {
      case Burger:
        return (this.item as Burger).getWeight().toString();
      case Drink:
        return (this.item as Drink).getMillilitres().toString();
      case Fries:
        return (this.item as Fries).getWeight().toString();
      case Dessert:
        return (this.item as Dessert).getMillilitres().toString();
      case Pizza:
        return (this.item as Pizza).getWeight().toString();
    }
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