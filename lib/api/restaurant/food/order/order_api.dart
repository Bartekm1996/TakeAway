part of food;

class OrderApi{

  final String accessToken;

  OrderApi({this.accessToken});

  Future<http.Response> postOrder(Cart cart) async{
    return await http.post(
      urls.TAKEAWAY_DOMAIN + urls.ORDER_API,
      headers: getHeaders('application/json'),
      body: jsonEncode(cart),
    );
  }

  Future<http.Response> getPastOrder() async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.ORDER_API,
      headers: getHeaders('application/json'),
    );
  }

  Future<http.Response> getPastOrderById(String id) async{
    return await http.get(
      urls.TAKEAWAY_DOMAIN + urls.ORDER_API,
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