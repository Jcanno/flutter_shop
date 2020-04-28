import 'package:flutter/material.dart';
import '../model/details.dart';
import '../api/details.dart';
import 'dart:convert';

class DetailsInfoProvider with ChangeNotifier {
  DetailsModel goodsInfo;

  bool isLeft = true;
  bool isRight = false;

  changeLeftAndRight(String changeState) {
    if(changeState == 'left') {
      isLeft = true;
      isRight = false;
    }else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  getGoodsInfo(String id) async{
    var data = {'goodId': id};
    await getGoodDetailsById(data).then((res) {
      var data = json.decode(res.toString());
      print(data);
      goodsInfo = DetailsModel.fromJson(data);
      notifyListeners();
    });
  }
}