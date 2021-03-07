import 'package:Deliciousness/api/restaurant/food/food.dart';
import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:flutter/material.dart';

class FoodInfoDialog extends CustomAlertDialog{

  String title;
  String body;
  FoodItem item;

  FoodInfoDialog({this.title, this.body, this.item});

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 210,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: const Text(
                    "Name",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.getName(),
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: const Text(
                    "Description",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.getDescription(),
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: const Text(
                    "Calories",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.getCalories().toString(),
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15.0),
            foodType(),
            const SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: const Text(
                    "Calories",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.getCalories().toString(),
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Ok'),
        )
      ],
    );
  }


  Widget foodType() {
    switch (this.item.runtimeType) {
      case Burger:
        return rowWidget("Weight", (this.item as Burger).getWeight().toString());
      case Drink:
        return rowWidget("Millimeters", (this.item as Drink).getMillilitres().toString());
      case Fries:
        return rowWidget("Weight", (this.item as Fries).getWeight().toString());
      case Dessert:
        return rowWidget("Millimeters", (this.item as Dessert).getMillilitres().toString());
      case Pizza:
        return rowWidget("Weight", (this.item as Pizza).getWeight().toString());
    }
  }

  Widget rowWidget(String type, String typ){
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            type,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            typ,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
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