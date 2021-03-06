part of food;

class PizzaOriginator {

  Pizza _state;

  void setPizzaState(Pizza state){
    this._state = state;
  }

  Pizza getPizzaState(){
    return this._state;
  }

  PizzaMomento savePizzaStateToMomento(){
    return new PizzaMomento(this._state);
  }

  void getPizzaStateFromMomento(PizzaMomento pizzaMomento){
      this._state = pizzaMomento.getState();
  }
}