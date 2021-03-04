part of food;

class PizzaApi {

  final String accessToken;

  PizzaApi({this.accessToken});

  Future<http.Response> _getAllPizzas() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.PIZZA_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getPizzaById(String pizzaId) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.PIZZA_API,
      headers: getHeaders('application/json'),
    );
  }

  List<Pizza> getAllPizzas() {
    var res;
    List<Pizza> pizzas = new List();
    _getAllPizzas().then((value) => {
      for(var i = 0; i < res.length; i++){
        pizzas.add(new Pizza(res[i])),
      }
    });

    return pizzas;
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }


}