import 'package:flutter/cupertino.dart';

abstract class FoodItem {

  @protected
  String id;
  @protected
  String name;
  @protected
  String description;
  @protected
  String imageUrl;
  @protected
  double price;
  @protected
  int calories;


  int getCalories(){
    return calories;
  }
  
  double getPrice(){
    return price;
  }

  String getId(){
    return this.id;
  }

  String getImageUrl(){
    return imageUrl;
  }

  String getDescription(){
    return description;
  }

  String getName(){
    return name;
  }

}