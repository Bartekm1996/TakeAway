

import 'package:Deliciousness/widgets/cart/Momento.dart';

import 'Cart.dart';

class FoodCart extends Momento{
  Cart _state;

  FoodCart(Cart cart){
    _state = Cart.copy(cart);
  }

  Cart getState(){
    return _state;
  }
}