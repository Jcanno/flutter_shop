import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import '../api/home.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String homeData = 'hello';
  static const data = {
    'lon': 120.14645385742188,
    'lat': 30.182287216186523
  };
  @override
  void initState() {
    
    // getHomeData(data).then((res){
    //   setState(() {
    //     homeData = res.toString();
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHomeData(data),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var data = json.decode(snapshot.data.toString());
          List<Map> swiper = (data['data']['slides'] as List).cast();
          return Column(
            children: <Widget>[
              SwiperDiy(swiperDateList: swiper)
            ],
          );
        }else {
          return Center(child: Text('正在加载中'),);
        }
      },
    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('百姓生活+'),),
    //   body: SingleChildScrollView(
    //     child: Text(homeData),
    //   ),
    // );
  }
}

class SwiperDiy extends StatelessWidget {
  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);
  final List swiperDateList;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDateList[index]['image']}");
        },
        pagination: SwiperPagination(),
        itemCount: 3,
        autoplay: true,
      ),
    );
  }
}