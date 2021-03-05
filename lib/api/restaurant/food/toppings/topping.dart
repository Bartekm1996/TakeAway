part of food;

class Topping extends FoodItem{
  double _weight;

  Topping(Map<String, dynamic> json) : super(json['id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._weight = json['Weight'];
  }

  void setWeight(double weight){
    this._weight = weight;
  }

  double getWeight(){
    return this._weight;
  }

  Topping.clone(Topping source) : super.clone(source){
    _weight = source._weight;
  }

  @override
  Topping clone() {
    return Topping.clone(this);
  }

}