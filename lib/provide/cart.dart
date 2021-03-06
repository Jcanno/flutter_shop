import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';
import 'package:decimal/decimal.dart';

class CartProvider with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double allPrice = 0;
  int allGoodsCount = 0;
  bool isAllCheck = true;
  

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if(!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('cartInfo');
    cartList = [];
    print('清空完成');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    allPrice = 0;
    allGoodsCount = 0;
    isAllCheck = true;
    if(cartString == null) {
      cartList = [];
    }else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        if(item['isCheck']) {
          // allPrice += (item['count'] * item['price']);
          allPrice = getAllPrice(allPrice, item['count'], item['price']);
          allGoodsCount += item['count'];
        }else {
          isAllCheck = false;
        }
        
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  double getAllPrice(double allPrice, int count, double price) {
    var addNum = Decimal.parse(count.toString()) * Decimal.parse(price.toString());
    return (Decimal.parse(allPrice.toString()) + addNum).toDouble();
  }

  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if(item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if(todo == 'add') {
      cartItem.count++;
    }else if(cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  deleteGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if(item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }

      tempIndex++;
    });

    tempList.removeAt(delIndex);
    // print('>>>>>>${tempList[0].isCheck}')
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if(item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    List<Map> newList = [];
    for(var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}