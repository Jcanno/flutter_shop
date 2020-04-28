import '../../provide/details_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  const DetailsWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provider.of<DetailsInfoProvider>(context, listen: false).goodsInfo.data.goodInfo.goodsDetail;

    return Consumer<DetailsInfoProvider>(
      builder: (context, detailsInfo, child) {
        var isLeft = detailsInfo.isLeft;
        if(isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        }else {
          return Container(
            width: ScreenUtil().setWidth(750),
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }
}