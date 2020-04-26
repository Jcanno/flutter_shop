import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import '../api/home.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  String homeData = 'hello';
  static const data = {
    'lon': 120.14645385742188,
    'lat': 30.182287216186523
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getHomeData(data),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var data = json.decode(snapshot.data.toString());
          List<Map> swiper = (data['data']['slides'] as List).cast();
          List<Map> navigatorList = (data['data']['category'] as List).cast();
          String adPicutre = data['data']['advertesPicture']['PICTURE_ADDRESS'];
          String leaderImage = data['data']['shopInfo']['leaderImage'];
          String leaderPhone = data['data']['shopInfo']['leaderPhone'];
          List<Map> recommandList = (data['data']['recommend'] as List).cast();
          String floor1Picture = data['data']['floor1Pic']['PICTURE_ADDRESS'];
          List<Map> floor1List = (data['data']['floor1'] as List).cast();
          String floor2Picture = data['data']['floor2Pic']['PICTURE_ADDRESS'];
          List<Map> floor2List = (data['data']['floor2'] as List).cast();
          String floor3Picture = data['data']['floor3Pic']['PICTURE_ADDRESS'];
          List<Map> floor3List = (data['data']['floor3'] as List).cast();
          return Scaffold(
            appBar: AppBar(title: Text('百姓生活+'),),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiperDateList: swiper),
                  TopNavigator(navigatorList: navigatorList),
                  AdPicture(adPicture: adPicutre),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommand(recommandList: recommandList),
                  FloorTitle(pictureAddress: floor1Picture),
                  FloorContent(floorGoodsList: floor1List),
                  FloorTitle(pictureAddress: floor2Picture),
                  FloorContent(floorGoodsList: floor2List),
                  FloorTitle(pictureAddress: floor3Picture),
                  FloorContent(floorGoodsList: floor3List),
                ],
              ),
            ),
          );
        }else {
          return Center(
            child: Text('正在加载中', 
              style: TextStyle(fontSize: ScreenUtil().setSp(28, allowFontScalingSelf: false),
              ),
            )
          );
        }
      },
    );
  }
}

// 轮播组件 
class SwiperDiy extends StatelessWidget {
  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);
  final List swiperDateList;


  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 760, height: 1334);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDateList[index]['image']}", fit: BoxFit.fill);
        },
        pagination: SwiperPagination(),
        itemCount: 3,
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(80)),
          Text(item['mallCategoryName'], style: TextStyle(fontSize: ScreenUtil().setSp(20)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length > 4) {
      this.navigatorList.removeRange(4,navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(160),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      )
    );
  }
}

class AdPicture extends StatelessWidget {
  final String adPicture;

  const AdPicture({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  void _launchUrl() async{
    String url = 'tel:' + leaderPhone;
    if(await canLaunch(url)) {
      await launch(url);
    }else {
      throw 'url不能访问';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderImage),
      ),
    );
  }
}

class Recommand extends StatelessWidget {

  final List recommandList;

  const Recommand({Key key, this.recommandList}) : super(key: key);

  Widget _recommandList() {
    return Container(
      height: ScreenUtil().setHeight(360),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommandList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text('商品推荐',
        style: TextStyle(
          color: Colors.pink
        ),
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: ScreenUtil().setWidth(220),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 0.5,
              color: Colors.black12
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommandList[index]['image']),
            // Image.network(recommandList[index]['image']),
            Text('￥${recommandList[index]['mallPrice']}'),
            Text('￥${recommandList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            _titleWidget(),
            _recommandList() 
          ],
        ),
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  final String pictureAddress;

  const FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    ); 
  }
}

class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      )
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          print('点击了商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}