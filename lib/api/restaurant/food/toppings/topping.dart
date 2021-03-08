part of food;

class Topping extends FoodItem{
  double _weight;

  Topping(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
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

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'Name': this.name,
    'Description': this.description,
    'ImageUrl': this.imageUrl,
    'Price': this.price,
    'Calories': this.calories,
    'Weight': this._weight,
  };
}