part of food;

class Burger extends FoodItem{

  double _weight;

  Burger(Map<String, dynamic> json){
    this.id = json['Id'];
    this.name = json['Name'];
    this.description = json['Description'];
    this.imageUrl = json['ImageUrl'];
    this.price = json['Price'];
    this.calories = json['Calories'];
    this._weight = json['Weight'];
  }

  void setWeight(double weight){
    this._weight = weight;
  }

  double getWeight(){
    return this._weight;
  }


}