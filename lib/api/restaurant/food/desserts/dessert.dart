part of food;

class Dessert extends FoodItem{

  double _millilitres;

  Dessert(Map<String, dynamic> json) : super(json['id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
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

}