import 'package:Deliciousness/api/restaurant/food/food_item.dart';

abstract class Command{
  void execute();
  void undo();
}