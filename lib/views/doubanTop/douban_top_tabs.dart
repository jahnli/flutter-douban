import 'package:flutter/material.dart';
import 'package:flutter_douban/views/doubanTop/book.dart';
import 'package:flutter_douban/views/doubanTop/fiction.dart';
import 'package:flutter_douban/views/doubanTop/movie.dart';
import 'package:flutter_douban/views/doubanTop/tv.dart';

class DoubanTopTabs extends StatefulWidget {
  final int index;
  DoubanTopTabs({this.index});
  @override
  _DoubanTopTabsState createState() => _DoubanTopTabsState();
}


class _DoubanTopTabsState extends State<DoubanTopTabs> with SingleTickerProviderStateMixin{

  // tab控制器
  TabController _tabController;

  // tab列表
  List tabs = ['电影','电视','读书','原创小说'];

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: tabs.length,vsync: this,initialIndex: widget.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme:TextTheme(
          body1:  TextStyle(color: Colors.white)
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('豆瓣榜单',style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            title:TextStyle(color: Colors.black)
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          brightness: Brightness.light,
          bottom:TabBar(
            unselectedLabelColor:Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            controller: _tabController,
            tabs:tabs.map((item) => Tab(text: item)).toList(),
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // 电影榜单 - 电影页
            DoubanTopMovie(),
            // 电影榜单 - 电视页
            DoubanTopTv(),
            // 电影榜单 - 读书页
            DoubanTopBook(),
            // 电影榜单 - 小说原创页
            DoubanTopFiction()
          ],
        ),
      ),
    );
  }
}