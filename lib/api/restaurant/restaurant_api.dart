import 'dart:convert';

import 'package:Deliciousness/widgets/cart/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'food/food.dart' as food;
import 'food/food.dart';
import 'package:http/http.dart' as http;

import 'food/food_item.dart';

class RestaurantApi {

  String accessToken;

  RestaurantApi({this.accessToken});


  Future<List<food.Burger>> createBurgersCard() async{
    List<Burger> burgers = new List();
    http.Response res = await food.BurgerApi(accessToken: this.accessToken).getAllBurgers();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      burgers.add(new food.Burger(parseRes[i]));
    }

    return burgers;
  }

  Future<List<food.Drink>> createDrinksCard() async{
    List<food.Drink> drinks = new List();
    http.Response res = await food.DrinksApi(accessToken: this.accessToken).getAllDrinks();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      drinks.add(new food.Drink(parseRes[i]));
    }

    return drinks;
  }

  Future<List<food.Dessert>> createDessertsCard() async{
    List<food.Dessert> desserts = new List();
    http.Response res = await food.DessertsApi(accessToken: this.accessToken).getAllDeserts();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      desserts.add(new food.Dessert(parseRes[i]));
    }

    return desserts;

  }

  Future<List<food.Topping>> getAvailableTopics() async{
    List<food.Topping> toppings = new List();
    http.Response res = await food.ToppingApi(accessToken: this.accessToken).getAllToppings();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      print(parseRes[i]);
      toppings.add(new food.Topping(parseRes[i]));
    }

    return toppings;

  }

  Future<List<food.Fries>> createFriesCard() async{
    List<food.Fries> fries = new List();
    http.Response res = await food.FriesApi(accessToken: this.accessToken).getAllFries();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      fries.add(new food.Fries(parseRes[i]));
    }

    return fries;
  }

  Future<List<food.Pizza>> createPizzaCard() async{
    List<food.Pizza> pizzas = new List();
    http.Response res = await food.PizzaApi(accessToken: this.accessToken).getAllPizzas();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      pizzas.add(new food.Pizza.fromJson(parseRes[i]));
    }

    return pizzas;
  }

  List<FoodItem> getAllFoods() {
    List<FoodItem> list = new List();

    createBurgersCard().then((value) => {
      list.addAll(value),
    });

    createDessertsCard().then((value) => {
      list.addAll(value),
    });

    createDrinksCard().then((value) => {
      list.addAll(value),
    });

    createFriesCard().then((value) => {
      list.addAll(value),
    });

    createPizzaCard().then((value) => {
      list.addAll(value),
    });

    return list;

  }

  List<FoodItem> parseIds(List<FoodItem> foods, List<dynamic> ids){
    List<FoodItem> items = new List();

    for(var i = 0; i < foods.length; i++){
      if(foods[i].getId() == ids[i]){
        items.add(foods[i].clone());
      }
    }

    return items;
  }

  Future<List<food.Order>> getPastOrders() async {
    List<FoodItem> foods = getAllFoods();
    List<food.Order> orders = new List();
    http.Response res = await food.OrderApi(accessToken: this.accessToken).getPastOrder();
    var parseRes = jsonDecode(res.body);

    for(var i = 0; i < parseRes.length; i++){
      orders.add(new food.Order(parseRes[i]['TimeStamp'],parseRes[i]['Id'],parseRes[i]['Price'],parseIds(foods, parseRes[i]['Ids'])));
    }

    return orders;
  }

  Future<http.Response> order(Cart cart) async{
    return food.OrderApi(accessToken: this.accessToken).postOrder(cart);
  }


}