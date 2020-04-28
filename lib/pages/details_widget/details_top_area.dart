import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  const DetailsTopArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsInfoProvider>(
      builder: (context, detailsInfo, child) {
        var goodInfo = Provider.of<DetailsInfoProvider>(context, listen: false).goodsInfo.data.goodInfo;
        if(goodInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodInfo.image1),
                _goodsName(goodInfo.goodsName),
                _goodsNum(goodInfo.goodsSerialNumber),
                _goodsPrice(goodInfo.presentPrice.toString(), goodInfo.oriPrice.toString())
              ],
            ),
          );
        }else {
          return Text('正在加载中');
        }
      },
    );
  }

  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28)
        ),
      ),
    );
  }

  Widget _goodsNum(String num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号: ${num}',
        style: TextStyle(
          color: Colors.black12
        ),
      ),
    );
  }

  Widget _goodsPrice(price, oriPrice) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Text(
              '￥${price}',
              style: TextStyle(
                color: Colors.pink,
                fontSize: ScreenUtil().setSp(30)
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text('市场价:'),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0),
            child: Text(
              oriPrice,
              style: TextStyle(
                color: Colors.black12,
                fontSize: ScreenUtil().setSp(28),
                decoration: TextDecoration.lineThrough
              ),
            ),
          )
        ],
      )
    );
  }
}