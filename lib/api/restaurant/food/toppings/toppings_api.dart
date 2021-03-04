part of food;

class ToppingApi {

  final String accessToken;

  ToppingApi({this.accessToken});

  Future<http.Response> _getAllToppings() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.TOPPINGS_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getToppingById(String toppingId) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.TOPPINGS_API,
      headers: getHeaders('application/json'),
    );
  }

  void getAllToppings() {
    List<Burger> burgers = new List();
    _getAllToppings().then((value) => {
      print(value.body),
    });
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}