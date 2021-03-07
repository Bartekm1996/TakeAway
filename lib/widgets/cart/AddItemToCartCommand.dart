import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'Cart.dart';

class AddItemToCartCommand extends Command{

  Cart cart;
  FoodItem addedFoodItem;
  double previousPrice;

  AddItemToCartCommand(FoodItem foodItem, Cart cart){
    this.cart = cart;
    this.previousPrice = cart.getTotalPriceOfCart();
    this.addedFoodItem = foodItem;
  }

  @override
  void execute() {
    this.cart.addToCart(this.addedFoodItem);
    this.cart.increasePrice(this.addedFoodItem.getPrice());
  }

  @override
  void undo() {
    this.cart.removeFromCart(this.addedFoodItem);
    this.cart.setPrice(this.previousPrice);
  }

}