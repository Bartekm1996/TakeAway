import 'dart:collection';

import 'package:Deliciousness/widgets/cart/CartCommand.dart';

class CartCommandHistory{

  final ListQueue<CartCommand> _commandList = ListQueue<CartCommand>();

  bool get isEmpty => _commandList.isEmpty;

  void add(CartCommand command){
    _commandList.add(command);
  }

  void undo(){
    if(_commandList.isNotEmpty){
      var command = _commandList.removeLast();
      command.undo();
    }
  }
}