import '../../provide/details_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  const DetailsTabbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsInfoProvider>(
      builder: (context, detailsInfo, child) {
        var isLeft = detailsInfo.isLeft;
        var isRight = detailsInfo.isRight;

        return Container(
          padding: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _tabbarLeft(context, isLeft),
              _tabbarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }

  Widget _tabbarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: (){
        Provider.of<DetailsInfoProvider>(context, listen: false).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _tabbarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: (){
        Provider.of<DetailsInfoProvider>(context, listen: false).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
