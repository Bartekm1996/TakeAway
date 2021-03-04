

import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'food/food.dart' as food;

class RestaurantApi extends StatefulWidget{

  String accessToken = '';

  RestaurantApi({this.accessToken});

  @override
  _RestaurantApi createState() => _RestaurantApi();

}

class _RestaurantApi extends State<RestaurantApi>{

  Map<String, List<Widget>> foods = new Map();
  Map<String, bool> shows = new Map();
  bool drinks = true, fries = true, desserts = true, pizzas = true, burgers = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: createOptionsCards(),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  void createMenu(){

  }

  Widget createOptionsCards(){
    return new Column(
      children: [
        SizedBox(height: 10),
        if(pizzas)
        createFoodCard('Pizzas', 'assets/icons/pizza.png'),
        SizedBox(height: 10),
        if(burgers)
        createFoodCard('Burgers', 'assets/icons/burger.png'),
        SizedBox(height: 10),
        if(fries)
        createFoodCard('Fries', 'assets/icons/fries.png'),
        SizedBox(height: 10),
        if(desserts)
        createFoodCard('Desserts', 'assets/icons/desserts.jpeg'),
        SizedBox(height: 10),
        if(drinks)
        createFoodCard('Drinks', 'assets/icons/drinks.png'),
        SizedBox(height: 10),
      ],
    );
  }

  Widget createFoodCard(String foodType, String assetImagePath){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image(image: AssetImage(assetImagePath)),
            title: Text(foodType),
            subtitle: Text('Res'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('View $foodType'),
                onPressed: () {
                    //setShowsToFalse(foodType);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget createCards(List<dynamic> foods){

    return new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text('Name'),
                subtitle: Text('Res'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('LISTEN'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );

  }

  Map<String, String> parseCasts(dynamic fd){
    Map<String, String> casts = new Map();

    if(fd is FoodItem){
        casts['Id'] = fd.getId();
        casts['Name'] = fd.getName();
        casts['ImageUrl'] = fd.getImageUrl();
        casts['Description'] = fd.getDescription();
        casts['Price'] = fd.getPrice().toString();
        casts['Calories'] = fd.getCalories().toString();
    }

    if(fd is food.Dessert){
        casts['Millilitres'] = fd.getMillilitres().toString();
    }

    if(fd is food.Drink){
      casts['Millilitres'] = fd.getMillilitres().toString();
    }

    if(fd is food.Burger){
      casts['Weight'] = fd.getWeight().toString();
    }

    if(fd is food.Fries){
      casts['Weight'] = fd.getWeight().toString();
    }

    if(fd is food.Pizza){
      casts['Weight'] = fd.getWeight().toString();
    }

  }

  void createBurgersCard() async {
    List<food.Burger> burgers = food.BurgerApi(accessToken: this.widget.accessToken).getAllBurgers();

    for(food.Burger burger in burgers){

    }
  }

  List<Widget> createDrinksCard(){
    List<food.Drink> drinks = food.DrinksApi(accessToken: this.widget.accessToken).getAllDrinks();

    for(food.Drink drink in drinks){

    }
  }

  void createDessertsCard(){
    List<food.Dessert> desserts = food.DessertsApi(accessToken: this.widget.accessToken).getAllDeserts();

    for(food.Dessert dessert in desserts){

    }
  }

  void createFriesCard(){
    List<food.Fries> fries = food.FriesApi(accessToken: this.widget.accessToken).getAllFires();

    for(food.Fries fries in fries){

    }
  }


}