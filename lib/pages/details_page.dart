import 'package:flutter/material.dart';
import '../provide/details_info.dart';
import 'package:provider/provider.dart';
import 'details_widget/details_top_area.dart';
import 'details_widget/details_explain.dart';
import 'details_widget/detaols_tabbar.dart';
import 'details_widget/details_web.dart';
import 'details_widget/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getDetailsInfo(context),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          }else {
            return Text('加载中...');
          }
        },
      ),
    );
  }

  Future _getDetailsInfo(BuildContext context) async{
    await Provider.of<DetailsInfoProvider>(context, listen: false).getGoodsInfo(goodsId);
    return 1;
  }
}