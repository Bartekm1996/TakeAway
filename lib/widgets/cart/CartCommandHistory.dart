import 'dart:collection';

import 'package:Deliciousness/widgets/cart/Command.dart';

class CartCommandHistory{

  final ListQueue<Command> _commandList = ListQueue<Command>();

  bool get isEmpty => _commandList.isEmpty;

  void add(Command command){
    _commandList.add(command);
  }

  void undo(){
    if(_commandList.isNotEmpty){
      var command = _commandList.removeLast();
      command.undo();
    }
  }
}