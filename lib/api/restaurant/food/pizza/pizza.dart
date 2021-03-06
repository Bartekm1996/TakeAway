part of food;

class Pizza extends FoodItem{

  double _weight;
  String _base;
  List<Topping> toppings;

  Pizza(Map<String, dynamic> json) : super(json['id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._weight = json['Weight'];
    this._base = json['PizzaBase'];
    this.toppings = parseTopping(json['Toppings']);
  }


  List<Topping> parseTopping(dynamic json){
    List<Topping> toppings = new List();
    var res = jsonDecode(json);
    for(var i = 0; i < res.length; i++){
      toppings.add(res[i]);
    }
    return toppings;
  }

  void addTopping(Topping topping){
    increasePrice(topping.getPrice());
    increaseCalories(topping.getCalories());
    increaseWeight(topping.getWeight());
    this.toppings.add(topping);
  }

  List<Topping> getToppings(){
    return this.toppings;
  }

  void increaseCalories(int calories){
    this.calories = calories;
  }

  void increaseWeight(double weight){
    this._weight += weight;
  }

  void increasePrice(double pr){
    this.price += pr;
  }

  void setBase(String base){
    this._base = base;
  }

  String getBase(){
    return this._base;
  }

  void setWeight(double weight){
    this._weight = weight;
  }

  double getWeight(){
    return this._weight;
  }

  Pizza.clone(Pizza source) : super.clone(source){
    _weight = source._weight;
  }

  @override
  Pizza clone() {
    return Pizza.clone(this);
  }

}