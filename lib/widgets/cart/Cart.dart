

class Cart{

  List<dynamic> foodItems;
  double totalPriceOfItems;


  Cart(this.foodItems, this.totalPriceOfItems);

  Cart.initial(){
    foodItems = new List();
    totalPriceOfItems = 0;
  }

  Cart.copy(Cart cart)  : this(cart.foodItems, cart.totalPriceOfItems);


}