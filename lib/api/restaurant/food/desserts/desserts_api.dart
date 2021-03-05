part of food;

class DessertsApi {

  final String accessToken;

  DessertsApi({this.accessToken});

  Future<http.Response> getAllDeserts() async{
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

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}