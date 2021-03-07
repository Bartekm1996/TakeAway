part of food;

class OrderApi{

  final String accessToken;

  OrderApi({this.accessToken});

  Future<http.Response> postOrder(List<FoodItem> foods) async{
    return await http.post(
      urls.TAKEAWAY_DOMAIN + urls.ORDER_API,
      headers: getHeaders('application/json'),
      body: parseOrderCost(foods),
    );
  }

  Map<String, dynamic> parseOrderCost(List<FoodItem> foods){
    Map<String, dynamic> body = new Map();
    List<String> uids = new List();
    double price = 0;

    for(var i = 0; i < foods.length; i++){
      uids.add(foods[i].getId());
      price += foods[i].getPrice();
    }

    body['ordered_items'] = uids;
    body['price'] = price;

    return body;
  }

  Map<String, String> getHeaders(String contentType) {
    Map<String, String> headers = new Map<String, String>();
    headers['Content-Type'] = "$contentType";
    headers['Authorization'] = this.accessToken;

    return headers;
  }
}