part of food;

class DrinksApi {

  final String accessToken;

  DrinksApi({this.accessToken});

  Future<http.Response> _getAllDrinks() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.DRINKS_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getDrinksById(String drinkId) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.DRINKS_API,
      headers: getHeaders('application/json'),
    );
  }

  List<Drink> getAllDrinks() {
    var res;
    List<Drink> drinks = new List();
    _getAllDrinks().then((value) => {
       res = jsonDecode(value.body),
      for(var i = 0; i < res.length; i++){
        drinks.add(new Drink(res[i])),
      }
    });

    return drinks;
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}