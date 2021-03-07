import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deliciousness/utils/globals.dart' as globals;

class PreviousOrders extends StatefulWidget{

  PreviousOrders();

  @override
  _PreviousOrders createState() => _PreviousOrders();
}

class _PreviousOrders extends State<PreviousOrders>{

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
        body: Column(),
      ),
    );
  }


}