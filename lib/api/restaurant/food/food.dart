library food;
import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:http/http.dart' as http;
import 'urls.dart' as urls;

part 'burgers/burger.dart';
part 'desserts/dessert.dart';
part 'drinks/drink.dart';
part 'fries/fries.dart';
part 'pizza/pizza.dart';
part 'burgers/burgers_api.dart';
part 'fries/fries_api.dart';
part 'toppings/toppings_api.dart';
part 'pizza/pizza_api.dart';
part 'toppings/topping.dart';
part 'desserts/desserts_api.dart';
part 'drinks/drinks_api.dart';

