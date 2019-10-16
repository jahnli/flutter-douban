import 'package:flutter/material.dart';
import 'package:flutter_douban/pages/tabs/book_movie/movie/doubanTop/movie.dart';

class DoubanTop extends StatefulWidget {
  @override
  _DoubanTopState createState() => _DoubanTopState();
}


class _DoubanTopState extends State<DoubanTop> with SingleTickerProviderStateMixin{

  // tab控制器
  TabController _tabController;

  // tab列表
  List tabs = ['电影','电视','读书','原创小说'];

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: tabs.length,vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
            Text('data'),
            Text('data'),
            Text('data'),
          ],
        ),
      ),
    );
  }
}