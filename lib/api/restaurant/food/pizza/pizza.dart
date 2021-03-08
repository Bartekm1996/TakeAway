part of food;

class Pizza extends FoodItem{

  double _weight;
  String _base;
  List<Topping> toppings;

  /*
  Pizza(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._weight = json['Weight'];
    this._base = json['PizzaBase'];
    this.toppings = (json['Toppings'] != null ? parseTopping(json['Toppings']) : new List());
  }
   */

  Pizza.fromJson(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']) {
    this._weight = json['Weight'];
    this._base = json['PizzaBase'];
    this.toppings = (json['Toppings'] != null ? parseTopping(json['Toppings']) : new List());
  }

  Pizza(String id, String name, String desc, String img, double price, int cal, double weight, String pizzaBase, List<Topping> toppings) :
        super(id, name, desc, img, price, cal) {
    this._weight = weight;
    this._base = _base;
    this.toppings = toppings;
  }

  Pizza.copy(Pizza pizza) : this(pizza.id, pizza.name, pizza.description, pizza.imageUrl, pizza.price, pizza.calories, pizza._weight, pizza._base, pizza.toppings);

  List<Topping> parseTopping(dynamic json){
    List<Topping> toppings = new List();
    var res = jsonDecode(json);
    print(res);

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
    this.calories += calories;
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


  Map<String, dynamic> toJson() => {
    'Id': this.id,
    'Name': this.name,
    'Description': this.description,
    'ImageUrl': this.imageUrl,
    'Price': this.price,
    'Calories': this.calories,
    'Weight': this._weight,
    'PizzaBase': this._base,
    'Toppings' : this.toppings,
  };


}