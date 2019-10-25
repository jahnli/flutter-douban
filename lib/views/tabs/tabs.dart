import 'package:flutter/material.dart';
import 'package:flutter_douban/views/tabs/book_movie/book_movie.dart';
import 'package:flutter_douban/views/tabs/group/group.dart';
import 'package:flutter_douban/views/tabs/home/home.dart';
import 'package:flutter_douban/views/tabs/my/my.dart';
import 'package:flutter_douban/views/tabs/store/store.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // tab索引
  int _currentIndex = 1;
  // tab页面
  List<Widget> _pages = [
    HomePage(),
    BookMoviePage(),
    GroupPage(),
    StorePage(),
    MyPage()
  ];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // 初始化一次适配
    ScreenAdapter.init(context);
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor:Color.fromRGBO(60, 197, 0, 1),
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index; 
          });
        },
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.collections_bookmark),title: Text('书影音')),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit),title: Text('小组')),
          BottomNavigationBarItem(icon: Icon(Icons.store),title: Text('市集')),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline),title: Text('我的')),
        ] ,
      ),
    );
  }
}