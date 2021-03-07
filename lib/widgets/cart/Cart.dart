import 'package:Deliciousness/api/restaurant/food/food_item.dart';

class Cart{

  List<FoodItem> _foodItems;
  double _totalPriceOfItems;

  Cart(){
    _foodItems = new List();
    _totalPriceOfItems = 0;
  }

  void addToCart(FoodItem item){
    this._foodItems.add(item);
  }

  void removeFromCart(FoodItem item){
    this._foodItems.remove(item);
  }

  void increasePrice(double cost){
    this._totalPriceOfItems += cost;
  }

  void decreasePrice(double cost){
    this._totalPriceOfItems -= cost;
  }

  void setPrice(double cost){
    this._totalPriceOfItems = cost;
  }

  List<FoodItem> getCartItems(){
    return this._foodItems;
  }

  double getTotalPriceOfCart(){
    return this._totalPriceOfItems;
  }

  int getNumberOfProducts(){
    return this._foodItems.length;
  }


}