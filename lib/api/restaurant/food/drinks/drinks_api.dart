part of food;

class DrinksApi {

  final String accessToken;

  DrinksApi({this.accessToken});

  Future<http.Response> getAllDrinks() async{
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

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}