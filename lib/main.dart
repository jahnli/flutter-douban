import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/views/launchPage/launch_page.dart';
import 'package:flutter_douban/views/tabs/tabs.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/routes/routes.dart';
// 引入Provider
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // 初始化fluro实例
   final router = Router();
   Routes.configureRoutes(router);
   Application.router = router;
    return MultiProvider(
      // 配置对应类
      providers: [
        // 电影是否上映
      ],
      child: MaterialApp(
        home: Tabs(),
        // 去掉debug
        debugShowCheckedModeBanner: false,
      )
    ); 
  }
}

