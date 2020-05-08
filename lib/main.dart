import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provider/provider.dart';
import 'provide/child_category.dart';
import 'provide/cagegory_goods_list.dart';
import 'provide/details_info.dart';
import 'provide/cart.dart';
import 'provide/current_index.dart';
import 'package:fluro/fluro.dart';
import 'router/routes.dart';
import 'application.dart';

void main(){
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChildCategory()),
        ChangeNotifierProvider(create: (context) => CategoryGoodsListProvider()),
        ChangeNotifierProvider(create: (context) => DetailsInfoProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CurrentIndexProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          
        ),
        home: IndexPage()
      ),
    );
  }
}