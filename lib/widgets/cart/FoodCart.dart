

import 'package:Deliciousness/widgets/cart/CartMomento.dart';

import 'Cart.dart';

class FoodCart extends CartMomento{
  Cart _state;

  FoodCart(Cart cart){
    _state = Cart.copy(cart);
  }

  Cart getState(){
    return _state;
  }
}