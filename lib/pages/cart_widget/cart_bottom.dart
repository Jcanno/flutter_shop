import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  const CartBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Consumer<CartProvider>(
        builder: (context, cartInfo, child) {
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context)
            ],
          );
        },
      )
      
      
    );
  }

  Widget selectAllBtn(context) {
    bool isAllCheck = Provider.of<CartProvider>(context, listen: false).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provider.of<CartProvider>(context, listen: false).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget allPriceArea(context) {
    double allPrice = Provider.of<CartProvider>(context, listen: false).allPrice;

    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(280),
                alignment: Alignment.centerRight,
                child: Text(
                  '合计: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(28)
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥ ${allPrice}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: ScreenUtil().setSp(28)
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            // width: ScreenUtil().setWidth(430),
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget goButton(context) {
    int allGoodsCount = Provider.of<CartProvider>(context, listen: false).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(26)
            ),
          ),
        ),
      ),
    );
  }
}