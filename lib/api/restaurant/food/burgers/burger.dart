part of food;

class Burger extends FoodItem{

  double _weight;

  Burger(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
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

  Map<String, dynamic> toJson() => {
    'Id': this.id,
    'Name': this.name,
    'Description': this.description,
    'ImageUrl': this.imageUrl,
    'Price': this.price,
    'Calories': this.calories,
    'Weight': this._weight,
  };

}