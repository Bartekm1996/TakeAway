import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'Cart.dart';

class AddItemToCartCommand extends Command{

  Cart cart;
  FoodItem addedFoodItem;
  double previousPrice;

  AddItemToCartCommand(FoodItem foodItem){
    this.previousPrice = cart.getTotalPriceOfCart();
    this.addedFoodItem = foodItem;
  }

  @override
  void execute() {
    this.cart.foodItems.add(this.addedFoodItem);
    this.cart.totalPriceOfItems += this.addedFoodItem.getPrice();
  }

  @override
  void undo() {
    this.cart.foodItems.remove(this.addedFoodItem);
    this.cart.totalPriceOfItems = this.previousPrice;
  }

}