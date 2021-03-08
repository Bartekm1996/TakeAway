part of food;

class PizzaApi {

  final String accessToken;

  PizzaApi({this.accessToken});

  Future<http.Response> getAllPizzas() async{
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
  /*
  Pizza(Map<String, dynamic> json) : super(json['Id'], json['Name'], json['Description'], json['ImageUrl'] ,json['Price'], json['Calories']){
    this._weight = json['Weight'];
    this._base = json['PizzaBase'];
    this.toppings = (json['Toppings'] != null ? parseTopping(json['Toppings']) : new List());
  }
   */

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }


}