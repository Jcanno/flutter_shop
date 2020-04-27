import '../model/categoryGoodsList.dart';
import 'package:flutter/material.dart';

class CategoryGoodsListProvider with ChangeNotifier {
  List<CategoryGoodsList> goodsList = [];
  
  setGoodsList(List<CategoryGoodsList> list) {
    goodsList = list;
    notifyListeners(); 
  }
}