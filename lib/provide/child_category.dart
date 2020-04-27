import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  
  setChildCategory(List<BxMallSubDto> list) {
    BxMallSubDto bx = BxMallSubDto();
    bx.mallSubId = '00';
    bx.mallCategoryId = '00';
    bx.comments = 'null';
    bx.mallSubName = '全部';
    childCategoryList = [bx];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}