import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataUrl with ChangeNotifier {
  String id;
  String openurl;
  String closeurl;

  DataUrl({@required this.id, @required this.openurl, @required this.closeurl});
}

class ProvideUrl with ChangeNotifier {
  List<DataUrl> _items = [];

  List<DataUrl> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://traders-hub-5c8f2.firebaseio.com/signal.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<DataUrl> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(DataUrl(
            id: prodId,
            openurl: prodData['openurl'],
            closeurl: prodData['closeurl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(String dataUrl, String closeurl) async {
    const url = 'https://traders-hub-5c8f2.firebaseio.com/signal.json';
    try {
      // ignore: unused_local_variable
      final response = await http.post(
        url,
        body: json.encode({
          'openurl': dataUrl,
          'closeurl': closeurl,
        }),
      );
      // ignore: missing_required_param
      final newProduct = DataUrl(openurl: dataUrl, closeurl: closeurl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://traders-hub-5c8f2.firebaseio.com/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      print("not able to delete");
    }
    existingProduct = null;
  }

  Future<void> users() async {
    const url = 'https://traders-hub-5c8f2.firebaseio.com/users.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<DataUrl> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(DataUrl(
            id: prodId,
            openurl: prodData['openurl'],
            closeurl: prodData['closeurl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
