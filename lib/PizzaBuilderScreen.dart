import 'package:Deliciousness/api/restaurant/food/food.dart';
import 'package:Deliciousness/widgets/cart/AddItemToCartCommand.dart';
import 'package:Deliciousness/widgets/cart/Cart.dart';
import 'package:Deliciousness/widgets/cart/CartCommandHistory.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'package:Deliciousness/widgets/cart/RemoveItemFromCartCommand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deliciousness/utils/globals.dart' as globals;

import 'api/restaurant/food/food_item.dart';

class PizzaBuilderScreen extends StatefulWidget{

  List<Topping> toppings;
  Cart cart;
  CartCommandHistory cartCommandHistory;
  double totalOfOrder;
  PizzaBuilder pizzaBuilder;

  PizzaBuilderScreen({this.toppings, this.cart, this.cartCommandHistory, this.totalOfOrder}) {
    this.pizzaBuilder = new PizzaBuilder(this.toppings);
  }

  @override
  _PizzaBuilderScreen createState() => _PizzaBuilderScreen();
}

class _PizzaBuilderScreen extends State<PizzaBuilderScreen>{

  List<Topping> pizzaToppings = new List();
  double cost = 0;
  int calories = 0;

  Brightness _getBrightness() {
    return globals.isDark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        dividerColor: Colors.transparent,
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Build Pizza'),
        ),
        backgroundColor: globals.isDark ? null : Colors.grey.shade200,
        body: Column(
            children: <Widget>[
              Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      const Text(
                        'Added Toppings',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child:  ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: this.pizzaToppings.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildCardTwo(this.pizzaToppings[index]);
                            }
                        ),
                      ),
                      Row(
                        children: <Widget>[
                         const SizedBox(width: 20.0),
                          Expanded(
                              child: Text(
                                'Pizza Calories ' + calories.toString(),
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                          ),
                          Text(
                            'Pizza Total € ' + cost.toString(),
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20.0),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 50,
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed:() {
                            addToCart(this.widget.pizzaBuilder.buildPizza());
                          },
                          child: Text(
                            'Order',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 450,
                width: MediaQuery.of(context).size.width,
                child:  ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: this.widget.toppings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCard(this.widget.toppings[index]);
                    }
                ),
              ),

            ],
          ),
        ),
    );
  }

  void addToppingLocal(Topping topping){
    setState(() {
      this.pizzaToppings.add(topping);
    });
  }

  void updateCalories(){
    setState(() {
      this.calories = this.widget.pizzaBuilder.getPizza().getCalories();
    });
  }

  void updatePrice(){
    setState(() {
      this.cost = this.widget.pizzaBuilder.getPizza().getPrice();
    });
  }

  void addTopping(Topping topping){
    switch (topping.getName()){
      case "Bacon": {
        this.widget.pizzaBuilder.addBacon();
        break;
      }
      case "BBQ Sauce": {
        this.widget.pizzaBuilder.addBbqSauce();
        break;
      }
      case "Yogurt Topping": {
        this.widget.pizzaBuilder.addYogurt();
        break;
      }
      case "Extra cheese": {
        this.widget.pizzaBuilder.addExtraCheese();
        break;
      }
      case "Onions": {
        this.widget.pizzaBuilder.addOnions();
        break;
      }
      case "Pepperoni": {
        this.widget.pizzaBuilder.addOnions();
        break;
      }
      case "Tomato Sauce": {
        this.widget.pizzaBuilder.addTomatoSauce();
        break;
      }
      case "Cheese": {
        this.widget.pizzaBuilder.addCheese();
        break;
      }
      case "Mixed Peppers": {
        this.widget.pizzaBuilder.addMixedPeppers();
        break;
      }
      case "Pineapple": {
        this.widget.pizzaBuilder.addPineApple();
        break;
      }
      case "Chicken": {
        this.widget.pizzaBuilder.addChicken();
        break;
      }
      case "Mushrooms": {
        this.widget.pizzaBuilder.addMushRooms();
        break;
      }
      case "Black Olives": {
        this.widget.pizzaBuilder.addBlackOlives();
        break;
      }
    }
    updateCalories();
    addToppingLocal(topping);
    updatePrice();
  }

  Widget buildCardTwo(FoodItem item){
    return new Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Expanded(
                child: Text(item.getName()),
              ),
              Expanded(
                child: TextButton(
                  child: const Text('Remove'),
                  onPressed: () {
                    this.widget.pizzaBuilder.returnToPreviousState();

                    setState(() {
                      this.pizzaToppings.clear();
                      this.pizzaToppings.addAll(this.widget.pizzaBuilder.getPizza().getToppings());
                    });

                    print(this.widget.pizzaBuilder.getPizza().getToppings().length);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCard(Topping item){
    return new Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fastfood),
            trailing: Text('€ ' + item.getPrice().toString()),
            title: Text(item.getName()),
            subtitle: Text(item.getDescription()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Add Topping'),
                onPressed: () {
                  addTopping(item);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  void addToCart(FoodItem foodItem){
    var command = new AddItemToCartCommand(foodItem, this.widget.cart);
    executeCommand(command);
  }

  void executeCommand(Command command){
    setState(() {
      command.execute();
      this.widget.cartCommandHistory.add(command);
      updateDisplayPrice();
    });
  }

  void updateDisplayPrice(){
    setState(() {
      this.widget.totalOfOrder = this.widget.cart.getTotalPriceOfCart();
    });
  }

}