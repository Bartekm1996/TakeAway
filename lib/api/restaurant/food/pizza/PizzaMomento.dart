part of food;

class PizzaMomento extends Momento{
  Pizza _state;

  PizzaMomento(Pizza pizza){
    _state = pizza;
  }

  Pizza getState(){
    return _state;
  }
}