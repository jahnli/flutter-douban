import './route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  // 配置路径
  // tab
  static String root = "/";
  static String theatricalFilm = "/theatricalFilm";
  static String movieHotDetail = "/movieHotDetail";
  static String doubanTopDetail = "/doubanTopDetail";
  static String doubanTop = "/doubanTop";
  static String doubanYearTop = "/doubanYearTop";
  static String filmDetail = "/filmDetail";
  
  // 路由配置
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    // 配置 对应路径名称和routerHnalde.dart
    router.define(root, handler:tabHandler);
    router.define(theatricalFilm, handler:theatricalFilmHandler);
    router.define(movieHotDetail, handler:movieHotDetailHandler);
    router.define(doubanTopDetail, handler:doubanTopDetailHandler);
    router.define(doubanTop, handler:doubanTopHandler);
    router.define(filmDetail, handler:filmDetailHandler);
    router.define(doubanYearTop, handler:doubanYearTopHandler);

  }
}