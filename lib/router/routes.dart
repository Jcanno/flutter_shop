import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';
import '../pages/index_page.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('找不到路由');
      }
    );

    router.define(detailsPage, handler: detailsHandler);
    router.define(root, handler: Handler(
      handlerFunc: (context, params) => IndexPage()
    ));
  }
}
