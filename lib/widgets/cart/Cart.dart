import 'package:Deliciousness/api/restaurant/food/food_item.dart';

class Cart{

  List<FoodItem> foodItems;
  double totalPriceOfItems;

  Cart(){
    foodItems = new List();
    totalPriceOfItems = 0;
  }

  double getTotalPriceOfCart(){
    return this.totalPriceOfItems;
  }


}