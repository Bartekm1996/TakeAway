part of food;

class PizzaMomento extends Momento{
  Pizza _state;

  PizzaMomento(Pizza pizza){
    _state = Pizza.copy(pizza);
  }

  Pizza getState(){
    return _state;
  }
}