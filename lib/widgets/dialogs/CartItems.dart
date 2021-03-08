import 'package:Deliciousness/LoginScreen.dart';
import 'package:Deliciousness/MenuScreen.dart';
import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/api/restaurant/restaurant_api.dart';
import 'package:Deliciousness/widgets/cart/AddItemToCartCommand.dart';
import 'package:Deliciousness/widgets/cart/Cart.dart';
import 'package:Deliciousness/widgets/cart/CartCommandHistory.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'package:Deliciousness/widgets/cart/RemoveItemFromCartCommand.dart';
import 'package:Deliciousness/widgets/dialogs/AlertDialog.dart';
import 'package:flutter/material.dart';

class CartItems extends CustomAlertDialog{

  String title;
  String body;
  double orderTotal;
  Cart cart;
  CartCommandHistory cartCommandHistory;
  String accessToken;


  CartItems({this.title, this.body, this.cart, this.orderTotal, this.cartCommandHistory, this.accessToken});

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content:  new CartItemsDialog(title: this.title, cart: this.cart, cartCommandHistory: this.cartCommandHistory, oderTotoal: this.orderTotal),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context, this.cart.getTotalPriceOfCart());
          },
          child: Text('Close'),
        ),
        FlatButton(
          onPressed: () {
            new RestaurantApi(accessToken: this.accessToken).order(cart).then((value) => {
              print(value),
            });
          },
          child: Text('Order'),
        )
      ],
    );
  }




  @override
  String getBody(){
    return this.body;
  }

  @override
  String getTitle() {
    return this.title;
  }

}

class CartItemsDialog extends StatefulWidget{
  final String title;
  double oderTotoal;
  final Cart cart;
  final CartCommandHistory cartCommandHistory;

  CartItemsDialog({this.title, this.cart, this.oderTotoal, this.cartCommandHistory});

  @override
  _CartItemsDialog createState() => _CartItemsDialog();
}

class _CartItemsDialog extends State<CartItemsDialog> {

  @override
  Widget build(BuildContext context) {
   return Container(
     height: 300.0,
     width: 300.0,
     child: ListView.builder(
         padding: const EdgeInsets.all(8),
         itemCount: this.widget.cart.getCartItems().length,
         itemBuilder: (BuildContext context, int index) {
           return buildCard(this.widget.cart.getCartItems()[index]);
         }
     ),
   );
  }

  Widget buildCard(FoodItem item){
    return new Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fastfood),
            trailing: Text('€ ' + item.getPrice().toString()),
            title: Text(item.getName()),
            subtitle: Text(item.getDescription()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Remove'),
                onPressed: () {
                  removeFromCart(item);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }


  void addToCart(FoodItem foodItem){
    var command = new AddItemToCartCommand(foodItem, this.widget.cart);
    executeCommand(command);
  }

  void removeFromCart(FoodItem foodItem){
    var command = new RemoveItemFromCartCommand(foodItem, this.widget.cart);
    executeCommand(command);
  }

  void executeCommand(Command command){
    setState(() {
      command.execute();
      this.widget.cartCommandHistory.add(command);
    });
  }

  void undo(){
    setState(() {
      this.widget.cartCommandHistory.undo();
    });
  }



}