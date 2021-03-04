part of food;

class FriesApi {

  final String accessToken;

  FriesApi({this.accessToken});

  Future<http.Response> _getAllFries() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.FRIES_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getFriesById(String friesId) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.FRIES_API,
      headers: getHeaders('application/json'),
    );
  }

  List<Fries> getAllFires() {
    var res;
    List<Fries> fries = new List();
    _getAllFries().then((value) => {
      res = jsonDecode(value.body),
      for(var i = 0; res.length; i++){
        fries.add(new Fries(res[i])),
      }
    });

    return fries;
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}