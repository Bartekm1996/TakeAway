import 'package:Deliciousness/PizzaBuilderScreen.dart';
import 'package:Deliciousness/PreviousOrders.dart';
import 'package:Deliciousness/SettingsScreen.dart';
import 'package:Deliciousness/api/restaurant/food/food.dart';
import 'package:Deliciousness/api/restaurant/food/food_item.dart';
import 'package:Deliciousness/api/restaurant/restaurant_api.dart';
import 'package:Deliciousness/auth0/auth0.dart';
import 'package:Deliciousness/widgets/cart/AddItemToCartCommand.dart';
import 'package:Deliciousness/widgets/cart/Cart.dart';
import 'package:Deliciousness/widgets/cart/CartCommandHistory.dart';
import 'package:Deliciousness/widgets/cart/Command.dart';
import 'package:Deliciousness/widgets/cart/RemoveItemFromCartCommand.dart';
import 'package:Deliciousness/widgets/dialogs/CartItems.dart';
import 'package:Deliciousness/widgets/dialogs/FoodInfoDialog.dart';
import 'package:Deliciousness/widgets/dialogs/PizzaToppingsInfoDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:Deliciousness/utils/constant.dart';
import 'package:Deliciousness/widgets/profile_list_item.dart';
import 'package:Deliciousness/LoginScreen.dart';
import 'package:Deliciousness/utils/globals.dart' as globals;

import 'api/auth/auth.dart';

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

class MenuScreen extends StatefulWidget {
  final String accessToken;
  MenuScreen({this.accessToken});
  
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<MenuScreen> {

  final CartCommandHistory cartCommandHistory = new CartCommandHistory();
  final Cart cart = new Cart();
  List<Card> cards = <Card>[new Card()];
  double totalOfOrder = 0;

  Brightness _getBrightness() {
    return globals.isDark ? Brightness.dark : Brightness.light;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        dividerColor: Colors.transparent,
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Menu')),
        backgroundColor: globals.isDark ? null : Colors.grey.shade200,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage('assets/icons/Deliciousness.png')),
                    Row(
                      children: <Widget>[
                        Expanded(child:
                          FlatButton(
                            onPressed: (){
                                new CartItems(title: 'Cart', body: '', cart: cart, orderTotal: this.totalOfOrder,cartCommandHistory: cartCommandHistory, accessToken: this.widget.accessToken)
                                    .show(context).then((value) => {
                                      updateDisplayPrice(),
                                });
                            },
                            child:
                            Text(
                              'View Cart',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Total € ' + totalOfOrder.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ExpansionTile(
                title: const Text('Menu'),
                leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                children: <Widget>[
                  ListTile(
                    title: Text('Burgers'),
                    contentPadding: EdgeInsets.only(left: 40.0),
                    leading: Icon(FontAwesomeIcons.hamburger, color: Colors.blueAccent),
                    onTap: () {
                      new RestaurantApi(accessToken: this.widget.accessToken).createBurgersCard().then((value) => {
                          setState((){
                              cards.clear();
                              for(var i = 0; i < value.length; i++){
                                cards.add(buildCard(value[i]));
                              }
                          }),
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Pizza'),
                    contentPadding: EdgeInsets.only(left: 40.0),
                    leading: Icon(FontAwesomeIcons.pizzaSlice, color: Colors.blueAccent),
                    onTap: () {
                      new RestaurantApi(accessToken: this.widget.accessToken).createFriesCard().then((value) => {
                        setState((){
                          cards.clear();
                          for(var i = 0; i < value.length; i++){
                            cards.add(buildCard(value[i]));
                          }
                        }),
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Fries'),
                    contentPadding: EdgeInsets.only(left: 40.0),
                    leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                    onTap: () {
                      new RestaurantApi(accessToken: this.widget.accessToken).createFriesCard().then((value) => {
                        setState((){
                          cards.clear();
                          for(var i = 0; i < value.length; i++){
                            cards.add(buildCard(value[i]));
                          }
                        }),
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Desserts'),
                    contentPadding: EdgeInsets.only(left: 40.0),
                    leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                    onTap: () {
                      new RestaurantApi(accessToken: this.widget.accessToken).createDessertsCard().then((value) => {
                        setState((){
                          cards.clear();
                          for(var i = 0; i < value.length; i++){
                            cards.add(buildCard(value[i]));
                          }
                        }),
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Drinks'),
                    contentPadding: EdgeInsets.only(left: 40.0),
                    leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                    onTap: () {
                      new RestaurantApi(accessToken: this.widget.accessToken).createDrinksCard().then((value) => {
                        setState((){
                          cards.clear();
                          for(var i = 0; i < value.length; i++){
                            cards.add(buildCard(value[i]));
                          }
                        }),
                      });
                    },
                  ),
                ],
              ),
              ListTile(
                title: Text('Build Pizza'),
                leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                onTap: () {
                  new RestaurantApi(accessToken: this.widget.accessToken).getAvailableTopics().then((value) => {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PizzaBuilderScreen(toppings: value, cartCommandHistory: this.cartCommandHistory, cart: this.cart, totalOfOrder: this.totalOfOrder)
                        )),
                  });
                },
              ),
              ListTile(
                title: Text('Previous Orders'),
                leading: Icon(Icons.fastfood, color: Colors.blueAccent),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreviousOrders()));
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(),
              ),
              ListTile(
                title: Text('Account & Settings'),
                leading: Icon(Icons.account_circle_outlined, color: Colors.blueAccent),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(accessToken: this.widget.accessToken)));
                },
              ),
              ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.logout, color: Colors.blueAccent),
                onTap: () {
                  Auth().logOut(this.widget.accessToken).then((value) => {
                    secureStorage.delete(key: 'access_token'),
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                  });
                },
              ),
              //LogOutPopUp(auth0client: this.widget.auth0client),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return cards[index];
                }
            )
          ],
        ),
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
                child: Text('Info'),
                onPressed: () {
                  if(item is Pizza){
                    PizzaToppingsInfoDialog().show(context);
                  }else{
                    FoodInfoDialog(title: 'Information', body: 'Hello', item: item).show(context);
                  }
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Buy'),
                onPressed: () {
                  addToCart(item);
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
    var command = new AddItemToCartCommand(foodItem, this.cart);
    executeCommand(command);
  }

  void removeFromCart(FoodItem foodItem){
    var command = new RemoveItemFromCartCommand(foodItem, this.cart);
    executeCommand(command);
  }

  void executeCommand(Command command){
    setState(() {
      command.execute();
      cartCommandHistory.add(command);
      updateDisplayPrice();
    });
  }

  void undo(){
    setState(() {
      cartCommandHistory.undo();
    });
  }

  void updateDisplayPrice(){
    setState(() {
      this.totalOfOrder = cart.getTotalPriceOfCart();
    });
  }


  dynamic foodType(dynamic item) {
    switch (item.runtimeType) {
      case Burger:
        return (item as Burger).clone();
      case Drink:
        return (item as Drink).clone();
      case Fries:
        return (item as Fries).clone();
      case Dessert:
        return (item as Dessert).clone();
      case Pizza:
        return (item as Pizza).clone();
    }
  }
}

class LogOutPopUp extends StatelessWidget {

  final Auth0Client auth0client;

  const LogOutPopUp({this.auth0client});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.logout,
        color: Colors.blueAccent,
      ),
      title: Text("Log Out"),
      onTap: () {
        showLogOutDialog(context);
      },
    );
  }

  showLogOutDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Log Out'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are You Sure You Want To Log Out"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          textColor: Theme
              .of(context)
              .primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {
            logoutAction();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false);
          },
          textColor: Theme
              .of(context)
              .primaryColor,
          child: const Text('Log Out'),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    await secureStorage.delete(key: 'mfa_token');
  }
}
