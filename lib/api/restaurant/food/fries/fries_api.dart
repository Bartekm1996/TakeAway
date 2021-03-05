part of food;

class FriesApi {

  final String accessToken;

  FriesApi({this.accessToken});

  Future<http.Response> getAllFries() async{
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

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
                        headers['Content-Type'] = "$contentType";
                        headers['Authorization'] = this.accessToken;

    return headers;
  }

}