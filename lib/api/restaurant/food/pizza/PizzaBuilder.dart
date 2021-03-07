part of food;

class PizzaBuilder{

  Pizza pizza;
  Map<String, Topping> addToppings;
  PizzaOriginator pizzaOrginator;
  List<PizzaMomento> snapshots;

  PizzaBuilder(List<Topping> toppings){
    this.snapshots = new List();
    this.pizzaOrginator = new PizzaOriginator();
    this.addToppings = initToppingsMap(toppings);
    initPizza();
  }

  Map<String, Topping> initToppingsMap(List<Topping> tps){
    Map<String, Topping> toppings = new Map();
    for(var i = 0; i < tps.length; i++){
      toppings[tps[i].getName()] = tps[i];
    }

    return toppings;
  }

  Map<String, dynamic> initPizza(){
    Map<String, dynamic> pz = new Map();
    pz['id'] = "0000-0000-0000-0001";
    pz['Name'] = "Custom Build Pizza";
    pz['Description'] = "A Custom Build Pizza By Customer";
    pz['ImageUrl'] = null;
    pz['Price'] = 0.0;
    pz['Calories'] = 0;
    pz['Weight'] = 0.0;
    pz['PizzaBase'] = "RegularBase";

    this.pizza = new Pizza(pz);

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

  Pizza getPizza(){
    return this.pizza;
  }

  Pizza buildPizza(){
    return this.pizza;
  }

  void setPrice(Topping tps){
    this.pizza.increasePrice(this.pizza.getPrice() + tps.getPrice());
  }

  void addBacon(){
    this.pizza.addTopping(addToppings['Bacon']);
    addSnapShot(pizza);
  }

  void addBlackOlives(){
    this.pizza.addTopping(addToppings['Black olives']);
    addSnapShot(pizza);
  }

  void addMushRooms(){
    this.pizza.addTopping(addToppings['Mushrooms']);
    addSnapShot(pizza);
  }

  void addChicken(){
    this.pizza.addTopping(addToppings['Chicken']);
    addSnapShot(pizza);
  }

  void addPineApple(){
    this.pizza.addTopping(addToppings['Pineapple']);
    addSnapShot(pizza);
  }

  void addMixedPeppers(){
    this.pizza.addTopping(addToppings['Mixed Peppers']);
    addSnapShot(pizza);
  }

  void addCheese(){
    this.pizza.addTopping(addToppings['Cheese']);
    addSnapShot(pizza);
  }

  void addTomatoSauce(){
    this.pizza.addTopping(addToppings['Tomato Sauce']);
    addSnapShot(pizza);
  }

  void addPepperoni(){
    this.pizza.addTopping(addToppings['Pepperoni']);
    addSnapShot(pizza);
  }

  void addOnions() {
    this.pizza.addTopping(addToppings['Onions']);
    addSnapShot(pizza);
  }

  void addBbqSauce(){
    this.pizza.addTopping(addToppings['BBQ Sauce']);
    addSnapShot(pizza);
  }

  void addExtraCheese(){
    this.pizza.addTopping(addToppings['Extra cheese']);
    addSnapShot(pizza);
  }

  void addYogurt(){
    this.pizza.addTopping(addToppings['Yogurt Topping']);
    addSnapShot(pizza);
  }


}