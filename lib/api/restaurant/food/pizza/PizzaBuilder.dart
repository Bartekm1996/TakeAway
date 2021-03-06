part of food;

class PizzaBuilder{

  Pizza pizza;
  String accessToken;
  Map<String, Topping> _addToppings;
  PizzaOriginator pizzaOrginator;
  List<PizzaMomento> snapshots;

  PizzaBuilder({this.accessToken}){
    this.accessToken = accessToken;
    this.snapshots = new List();
    this.pizzaOrginator = new PizzaOriginator();
    initToppingsMap();
  }

  void initToppingsMap(){
    this._addToppings = new Map();
    new RestaurantApi(accessToken: this.accessToken).getAvailableTopics().then((value) => {
      for(var i = 0; i < value.length; i++){
        _addToppings[value[i].getName()] = value[i],
      }
    });
  }

  Map<String, dynamic> initPizza(){
    Map<String, dynamic> pz = new Map();
    pz['id'] = "0000-0000-0000-0001";
    pz['Name'] = "Custom Build Pizza";
    pz['Description'] = "A Custom Build Pizza By Customer";
    pz['ImageUrl'] = null;
    pz['Price'] = 0;
    pz['Calories'] = 0;
    pz['Weight'] = 0;
    pz['PizzaBase'] = "RegularBase";
  }


  Momento getSnapShot(int index){
    return this.snapshots[index];
  }

  void returnToPreviousState(){
    this.pizza = this.snapshots.last.getState();
  }

  void addSnapShot(Pizza pizza) {
    this.pizzaOrginator.setPizzaState(pizza);
    this.snapshots.add(this.pizzaOrginator.savePizzaStateToMomento());
  }

  void createPizza(){
    pizza = new Pizza(initPizza());
  }

  Pizza buildPizza(){
    return this.pizza;
  }

  void setPrice(Topping tps){
    this.pizza.increasePrice(this.pizza.getPrice() + tps.getPrice());
  }

  void addBacon(){
    this.pizza.addTopping(_addToppings['Bacon']);
    addSnapShot(pizza);
  }

  void addBlackOlives(){
    this.pizza.addTopping(_addToppings['Black olives']);
    addSnapShot(pizza);
  }

  void addMushRooms(){
    this.pizza.addTopping(_addToppings['Mushrooms']);
    addSnapShot(pizza);
  }

  void addChicken(){
    this.pizza.addTopping(_addToppings['Chicken']);
    addSnapShot(pizza);
  }

  void addPineApple(){
    this.pizza.addTopping(_addToppings['Pineapple']);
    addSnapShot(pizza);
  }

  void addMixedPeppers(){
    this.pizza.addTopping(_addToppings['Mixed Peppers']);
    addSnapShot(pizza);
  }

  void addCheese(){
    this.pizza.addTopping(_addToppings['Cheese']);
    addSnapShot(pizza);
  }

  void addTomatoSauce(){
    this.pizza.addTopping(_addToppings['Tomato Sauce']);
    addSnapShot(pizza);
  }

  void addPepperoni(){
    this.pizza.addTopping(_addToppings['Pepperoni']);
    addSnapShot(pizza);
  }

  void addOnions() {
    this.pizza.addTopping(_addToppings['Onions']);
    addSnapShot(pizza);
  }

  void addBbqSauce(){
    this.pizza.addTopping(_addToppings['BBQ Sauce']);
    addSnapShot(pizza);
  }

  void addExtraCheese(){
    this.pizza.addTopping(_addToppings['Extra cheese']);
    addSnapShot(pizza);
  }

  void addYogurt(){
    this.pizza.addTopping(_addToppings['Yogurt Topping']);
    addSnapShot(pizza);
  }


}