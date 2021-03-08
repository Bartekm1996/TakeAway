part of food;

class Dessert extends FoodItem{

  double _millilitres;

  Dessert(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._millilitres = json['Millilitres'];
  }

  void setMillilitres(double millilitres){
    this._millilitres = millilitres;
  }

  double getMillilitres(){
    return this._millilitres;
  }

  Dessert.clone(Dessert source) : super.clone(source){
    _millilitres = source._millilitres;
  }

  @override
  Dessert clone() {
    return Dessert.clone(this);
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