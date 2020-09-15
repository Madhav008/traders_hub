import 'package:trades_club/model/closeorders.dart';
import 'package:trades_club/model/openorders.dart';

import 'package:http/http.dart' as http;

class Repository {

  Future<OpenOrders> getOpen(String id) async {
    String openUrl = id;
    var response = await http.get(openUrl);
    return openOrdersFromJson(response.body);
  }

  Future<CloseOrders> getClose(String id) async {
    var response = await http.get(id);

    return closeOrdersFromJson(response.body);
  }
  
}
