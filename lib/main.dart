import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provider/provider.dart';
import 'provide/child_category.dart';
import 'provide/cagegory_goods_list.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ChildCategory()),
      ChangeNotifierProvider(create: (context) => CategoryGoodsListProvider())
    ],
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage()
      ),
    );
  }
}