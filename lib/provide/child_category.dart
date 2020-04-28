import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';
  String categorySubId = '';
  int page = 1;
  String noMoreText = '';

  setChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    BxMallSubDto bx = BxMallSubDto();
    bx.mallSubId = '';
    bx.mallCategoryId = '00';
    bx.comments = 'null';
    bx.mallSubName = '全部';
    childCategoryList = [bx];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  setChildIndex(int index, String subId) { 
    page = 1;
    noMoreText = '';
    categorySubId = subId;
    childIndex = index;
    notifyListeners();
  }

  addPage() {
    page++;
    notifyListeners();
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}