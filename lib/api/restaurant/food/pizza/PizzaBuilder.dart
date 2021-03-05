import '../../restaurant_api.dart';
import '../food.dart';

class PizzaBuilder{

  Pizza pizza;
  String accessToken;
  Map<String, Topping> _addToppings;

  PizzaBuilder({this.accessToken}){
    this.accessToken = accessToken;
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

  void createPizza(){
    pizza = new Pizza(initPizza());
  }

  Pizza getPizza(){
    return this.pizza;
  }

  void setPrice(){
    this.pizza.increasePrice(pr);
  }

  void addBacon(){

    this.pizza.addTopping(_addToppings['Bacon']);
  }

  void addBlackOlives(){
    this.pizza.addTopping(_addToppings['Black olives']);
  }

  void addMushRooms(){
    this.pizza.addTopping(_addToppings['Mushrooms']);
  }

  void addChicken(){
    this.pizza.addTopping(_addToppings['Chicken']);
  }

  void addPineApple(){
    this.pizza.addTopping(_addToppings['Pineapple']);
  }

  void addMixedPeppers(){
    this.pizza.addTopping(_addToppings['Mixed Peppers']);
  }

  void addCheese(){
    this.pizza.addTopping(_addToppings['Cheese']);
  }

  void addTomatoSauce(){
    this.pizza.addTopping(_addToppings['Tomato Sauce']);
  }

  void addPepperoni(){
    this.pizza.addTopping(_addToppings['Pepperoni']);
  }

  void addOnions() {
    this.pizza.addTopping(_addToppings['Onions']);
  }

  void addBbqSauce(){
    this.pizza.addTopping(_addToppings['BBQ Sauce']);
  }

  void addExtraCheese(){
    this.pizza.addTopping(_addToppings['Extra cheese']);
  }

  void addYogurt(){
    this.pizza.addTopping(_addToppings['Yogurt Topping']);
  }


}