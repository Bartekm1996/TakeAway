import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'food/food.dart' as food;
import 'food/food.dart';
import 'package:http/http.dart' as http;

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


}