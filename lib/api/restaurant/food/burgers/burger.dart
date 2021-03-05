part of food;

class Burger extends FoodItem{

  double _weight;

  Burger(Map<String, dynamic> json) : super(json['id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._weight = json['Weight'];
  }

  void setWeight(double weight){
    this._weight = weight;
  }

  double getWeight(){
    return this._weight;
  }

  Burger.clone(Burger source) : super.clone(source){
    _weight = source._weight;
  }

  @override
  Burger clone() {
    return Burger.clone(this);
  }


}