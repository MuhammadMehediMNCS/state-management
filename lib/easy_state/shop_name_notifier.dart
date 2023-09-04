import 'package:flutter/material.dart';
import 'Item.dart';

class ShopNameNotifier extends ChangeNotifier {
  String shopName = '';

  updateShopeName(String shopName) async {
    this.shopName = shopName;
    notifyListeners();
  }
}