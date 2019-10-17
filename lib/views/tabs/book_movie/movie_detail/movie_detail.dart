import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/api/api_config.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_actor.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_also_like.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_comment.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_grade.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_head.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_plot.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_short_comments.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie_detail/detail_trailers.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:rubber/rubber.dart';

class MovieDetail extends StatefulWidget {

  final String movieId;

  MovieDetail({this.movieId});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> with TickerProviderStateMixin{

 

  // 电影详情内容
  Map _movie;
  // 主题颜色
  String _themeColor = '';
  bool _isDark;
  String _requestStatus = '';
  // 荣耀信息
  List _honorInfo = [];
  // 滚动控制器
  ScrollController _scrollController = ScrollController();
  ScrollController _bottomSheetController = ScrollController();
  RubberAnimationController _controller;
  TabController _tabController;
  // 默认显示静态文字电影
  bool _showTitle = false;

  // 影评数量
  int _movieCommentCount = 0 ;
  @override
  void initState() { 
    super.initState();
    _getDetail();
    _getDetailTheme();
    _controller = RubberAnimationController(
      vsync: this,
      halfBoundValue: AnimationControllerValue(percentage: 0.5),
      duration: Duration(milliseconds: 200)
    );
    _tabController = TabController(length: 2,vsync: this);
    if(mounted){
      // 监听滚动
      _scrollController.addListener((){
        if(_scrollController.offset > 40){
          setState(() {
            _showTitle = true; 
          });
        }else{
          setState(() {
            _showTitle = false; 
          });
        }
      });
    }
  }
  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _scrollController.dispose();
    _tabController.dispose();
    _bottomSheetController.dispose();
    super.dispose();
  }
  // 获取电影详情
  _getDetailTheme() async{
    try{
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/movie/${widget.movieId}?ck=&for_mobile=1', options: Options(
        headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _themeColor = res.data['header_bg_color'];
          _honorInfo = res.data['honor_infos'];
          _isDark = res.data['color_scheme']['is_dark'];
        });
      }
    }
    catch(e){
      print(e);
      if(mounted){
        setState(() {
          _requestStatus = '暂无数据'; 
        });
      }
    }
  }
 
    // 获取电影详情
  _getDetail() async{
    try{
      Map<String,dynamic> params = {
        "apikey":ApiConfig.apiKey
      };
      Response res = await ApiConfig.ajax('get', ApiConfig.baseUrl + '/v2/movie/subject/${widget.movieId}', params);
      if(mounted){
        setState(() {
          _movie = res.data;  
        });
      }
    }
    catch(e){
      print(e);
      if(mounted){
        setState(() {
          _requestStatus = '暂无数据'; 
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _themeColor.isNotEmpty && _movie !=null ? Theme(
      data: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
          subhead: TextStyle(color: Colors.white),
          title: TextStyle(color: Colors.white),
        )
      ),
      child: Scaffold(
        backgroundColor:Color(int.parse('0xff' + _themeColor)),
        appBar: AppBar(
          centerTitle: true,
          title: _showTitle ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${_movie['title']}',style: TextStyle(fontSize: 14)),
              ),
              BaseGrade(value:_movie['rating']['average'], nullRatingReason:_movie['mainland_pubdate'])
            ],
          ) : Text('电影') ,
          backgroundColor: Color(int.parse('0xff' + _themeColor)),
        ),
        body: Container(
          child: RubberBottomSheet(
            scrollController: _bottomSheetController,
            lowerLayer: _content(),
            header: Container(
              decoration: BoxDecoration(
                color:Color.fromRGBO(246, 246, 246, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(15)),
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: ScreenAdapter.width(70),
                      height: ScreenAdapter.height(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(216, 216, 216, 1)
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: TextStyle(fontSize: 16),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(text: '影评 ${_movieCommentCount == 0 ? '':_movieCommentCount}'),
                      Tab(text: '小组讨论'),
                    ],
                  )
                ],
              )
            ),
            upperLayer: _bottomSheet(),
            animationController: _controller,
          )
        ),
      ),
    ):Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          title:TextStyle(color: Colors.black)
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        brightness: Brightness.light,
      ),
      body: BaseLoading(type: _requestStatus),
    );
  }
  // 内容区域
  Widget _content() {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),0,ScreenAdapter.width(30),ScreenAdapter.width(30)),
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          // 详情头部
          SizedBox(height: ScreenAdapter.height(30)),
          DetailHead(_movie,_honorInfo,_isDark),
          SizedBox(height: ScreenAdapter.height(30)),
          // 豆瓣评分
          DetailGrade(_movie,_isDark),
          SizedBox(height: ScreenAdapter.height(30)),
          // 剧情简介
          DetailPlot(_movie,_isDark),
          SizedBox(height: ScreenAdapter.height(30)),          
          // 演职员
          DetailActor(_movie,_isDark),
          // 预告片 / 剧照
          DetailTrailer(_movie,_isDark),
          SizedBox(height: ScreenAdapter.height(30)),    
          // 短评
          DetailShortComments(_movie,_isDark),
          SizedBox(height: ScreenAdapter.height(30)),    
          // 有可能喜欢
          DetailAlsoLike(_movie['genres'][0],_isDark),
          SizedBox(height: ScreenAdapter.height(50)),
        ],
      )
    );
  }
  // bottomSheet
  Widget _bottomSheet() {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
           DetailComment(widget.movieId, _bottomSheetController,setMovieCommentCount:(count)=> _setMovieCommentCount(count)),
            Text('data'),
          ],
        ),
      ),
    );
  }
  // 影评数量
  _setMovieCommentCount(count){
    if(mounted){
      setState(() {
        _movieCommentCount = count;
      });  
    }
  }

}
