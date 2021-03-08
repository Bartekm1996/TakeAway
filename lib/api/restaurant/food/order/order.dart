part of food;

class Order {

  String time;
  String id;
  double price;
  List<FoodItem> foodItems;

  Order(String time, String id, double price, List<FoodItem> foodItems){
      this.time = time;
      this.foodItems = foodItems;
      this.price = price;
      this.foodItems = foodItems;
  }

  Order.fromJson(Map<String, dynamic> json) :
        time = json['TimeStamp'],
        id = json['Id'],
        price = json['Price'];


  double getPrice(){
    return this.price;
  }

  String getDate(){
    return this.time;
  }

  List<FoodItem> getItems(){
    return this.foodItems;
  }

  Order.clone(Order order) {
    this.time = order.time;
    this.foodItems = order.foodItems;
  }

  Order clone(){
    return Order.clone(this);
  }


}