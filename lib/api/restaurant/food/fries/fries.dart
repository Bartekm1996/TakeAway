part of food;

class Fries extends FoodItem{

  double _weight;

  Fries(Map<String, dynamic> json) : super(json['id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._weight = json['Weight'];
  }

  void setWeight(double weight){
    this._weight = weight;
  }

  double getWeight(){
    return this._weight;
  }

  Fries.clone(Fries source) : super.clone(source){
    _weight = source._weight;
  }

  @override
  Fries clone() {
    return Fries.clone(this);
  }

}