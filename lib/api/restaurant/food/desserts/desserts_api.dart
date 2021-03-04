part of food;

class DessertsApi {

  final String accessToken;

  DessertsApi({this.accessToken});

  Future<http.Response> _getAllDeserts() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.DESSERT_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getDessertById(String dessertId) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.DESSERT_API,
      headers: getHeaders('application/json'),
    );
  }

  List<Dessert> getAllDeserts() {
    var res;
    List<Dessert> deserts = new List();
    _getAllDeserts().then((value) => {
      res = jsonDecode(value.body),
      for(var i =  0; i < res.length; i++){
        deserts.add(new Dessert(res[i])),
      },
    });

    return deserts;
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}