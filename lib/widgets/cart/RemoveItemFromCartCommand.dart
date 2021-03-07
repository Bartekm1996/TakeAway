import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'Cart.dart';

class RemoveItemFromCartCommand extends Command{

  Cart cart;
  FoodItem removedFoodItem;
  double previousPrice;

  RemoveItemFromCartCommand(FoodItem foodItem){
    this.previousPrice = cart.getTotalPriceOfCart();
    this.removedFoodItem = foodItem;
  }

  @override
  void execute() {
    this.cart.foodItems.remove(this.removedFoodItem);
    this.cart.totalPriceOfItems += this.removedFoodItem.getPrice();
  }

  @override
  void undo() {
    this.cart.foodItems.add(this.removedFoodItem);
    this.cart.totalPriceOfItems = this.previousPrice;
  }
}