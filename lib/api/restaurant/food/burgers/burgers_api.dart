part of food;

class BurgerApi {

  final String accessToken;

  BurgerApi({this.accessToken});

  Future<http.Response> _getAllBurgers() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.BURGER_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getBurgerById(String burgerId) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.BURGER_API + '/$burgerId',
      headers: getHeaders('application/json'),
    );
  }

  List<Burger> getAllBurgers() {
    var res;
    List<Burger> burgers = new List();
    _getAllBurgers().then((value) => {
      res = jsonDecode(value.body),
      for(var i = 0; i < res.length; i++){
        burgers.add(new Burger(res[i])),
      },
    });

    return burgers;
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
    headers['Content-Type'] = "$contentType";
    headers['Authorization'] = this.accessToken;

    return headers;
  }

}