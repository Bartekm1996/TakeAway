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


  FoodItem(this.id, this.name, this.description, this.imageUrl, this.price, this.calories);

  FoodItem.clone(FoodItem source){
    id = source.id;
    name = source.name;
    description = source.description;
    imageUrl = source.imageUrl;
    price = source.price;
    calories = source.calories;
  }

  FoodItem clone();

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