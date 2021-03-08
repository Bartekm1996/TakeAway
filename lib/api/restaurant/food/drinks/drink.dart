part of food;

class Drink extends FoodItem{

  double _millilitres;

  Drink(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._millilitres = json['Millilitres'];
  }

  void setMillilitres(double millilitres){
    this._millilitres = millilitres;
  }

  double getMillilitres(){
    return this._millilitres;
  }

  Drink.clone(Drink source) : super.clone(source){
    _millilitres = source._millilitres;
  }

  @override
  Drink clone() {
    return Drink.clone(this);
  }

  Map<String, dynamic> toJson() => {
    'Id': this.id,
    'Name': this.name,
    'Description': this.description,
    'ImageUrl': this.imageUrl,
    'Price': this.price,
    'Calories': this.calories,
    'Millilitres': this._millilitres,
  };
}