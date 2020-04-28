import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {
  const DetailsExplain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(top: 10.0),
      width: ScreenUtil().setWidth(750),
      child: Text(
        '说明: > 急速到达 > 正品保证',
        style: TextStyle(
          color: Colors.red,
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }
}