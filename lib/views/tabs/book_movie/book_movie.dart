import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movie.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
class BookMoviePage extends StatefulWidget {
  @override
  _BookMoviePageState createState() => _BookMoviePageState();
}

class _BookMoviePageState extends State<BookMoviePage> with SingleTickerProviderStateMixin{
  
  // 搜索文字
  String _searchText = '';

  // tabcontroller
  TabController _tabController;
  // 
  List<String> _tabsList = [ '电影','电视','读书','原创小说','音乐','同城'];


  @override
  void initState() { 
    super.initState();
    _getSearchText();
    _tabController = TabController(length: _tabsList.length,vsync: this);
    if (Platform.isAndroid) {
     // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
  // 获取搜索文字
  _getSearchText()async{
    try {
      Response res = await NetUtils.ajax('get',ApiPath.home['bookMovieSearchText']);
      if(mounted){
        setState(() {
          _searchText = res.data['title']; 
        });
      }
    } catch (e) {
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        bottom: TabBar(
          labelColor:Colors.black,
          labelStyle: TextStyle(fontSize: 16),
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.black45,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          tabs:_tabsList.map((item){
            return Tab(text: item);
          }).toList(),
        ),
        title: _appBar(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          // 电影
          MoviePage(),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      ),
    );
  }
// appbar
  Widget _appBar(){
    return Row(
      children: <Widget>[
        Container(
          width: ScreenAdapter.getScreenWidth() - ScreenAdapter.width(160),
          height: ScreenAdapter.height(60),
          padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.search,color: Colors.black38),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Application.router.navigateTo(context,'/bookMovieSearch?searchText=${Uri.encodeComponent(_searchText)}');
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: ScreenAdapter.width(10)),
                    child: Text(_searchText,style: TextStyle(color: Color.fromRGBO(210, 210, 210, 1))),
                  )
                )
              ),
              Icon(Icons.center_focus_weak,color: Colors.black38)
            ],
          ) 
        ),
        Expanded(
          flex:1,
          child: IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.mail_outline,color: Colors.grey),
          ),
        )
      ],
    );
  }
}