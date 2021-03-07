import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'Cart.dart';

class RemoveItemFromCartCommand extends Command{

  Cart cart;
  FoodItem removedFoodItem;
  double previousPrice;

  RemoveItemFromCartCommand(FoodItem foodItem, Cart cart){
    this.cart = cart;
    this.previousPrice = cart.getTotalPriceOfCart();
    this.removedFoodItem = foodItem;
  }

  @override
  void execute() {
    this.cart.removeFromCart(this.removedFoodItem);
    this.cart.decreasePrice(this.removedFoodItem.getPrice());
  }

  @override
  void undo() {
    this.cart.addToCart(this.removedFoodItem);
    this.cart.setPrice(this.previousPrice);
  }
}