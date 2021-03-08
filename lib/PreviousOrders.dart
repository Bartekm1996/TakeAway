import 'package:Deliciousness/api/restaurant/restaurant_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deliciousness/utils/globals.dart' as globals;
import 'api/restaurant/food/food.dart';

class PreviousOrders extends StatefulWidget{

  final String accessToken;

  PreviousOrders({this.accessToken});

  @override
  _PreviousOrders createState() => _PreviousOrders();
}

class _PreviousOrders extends State<PreviousOrders>{

  List<Order> orders = [new Order('', '', 0, new List())];

  @override
  initState(){
    setState(() {
      new RestaurantApi(accessToken: this.widget.accessToken).getPastOrders().then((value) => {
        orders.addAll(value),
      });
    });
    super.initState();
  }

  Brightness _getBrightness() {
    return globals.isDark ? Brightness.dark : Brightness.light;
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Previous Orders'),
        ),
        backgroundColor: globals.isDark ? null : Colors.grey.shade200,
        body: Stack(
          children: <Widget>[
            ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildCard(orders[index]);
                }
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(Order item){
    return new Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            trailing: Text('€ ' + item.getPrice().toString()),
            title: Text('Date ' + item.getDate()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('View Ordered Items'),
                onPressed: () {

                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: Text('Reorder'),
                onPressed: () {

                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

}