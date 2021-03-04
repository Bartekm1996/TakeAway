part of food;

class Drink extends FoodItem{

  double _millilitres;

  Drink(Map<String, dynamic> json){
    this.id = json['Id'];
    this.name = json['Name'];
    this.description = json['Description'];
    this.imageUrl = json['ImageUrl'];
    this.price = json['Price'];
    this.calories = json['Calories'];
    this._millilitres = json['Millilitres'];
  }

  void setMillilitres(double millilitres){
    this._millilitres = millilitres;
  }

  double getMillilitres(){
    return this._millilitres;
  }
}