import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/movieShow.dart';
import 'package:flutter_douban/model/home/todayPlay.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/pages/tabs/book_movie/movie/movieShow/movie_show.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/film_item.dart';
import 'package:flutter_douban/weiget/grid_view.dart';
import 'package:flutter_douban/weiget/rowTitle.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with AutomaticKeepAliveClientMixin{

  // 首页模块数据
  List _homeData = [] ;
  TodayPlayModel _todayPlay;

  @override
  void initState() { 
    super.initState();
    // 获取数据
    _getHomeData();
    _getTodayPlay();
  }

  // 获取首页数据
  _getHomeData()async{
    Response res = await NetUtils.ajax('get', ApiPath.home['home']);
    if(mounted){
      setState(() {
        _homeData = res.data['modules'];
      });
    }
  }
  // 获取今日播放
  _getTodayPlay()async{
    Response res = await NetUtils.ajax('get', ApiPath.home['todayPlay']);
    if(mounted){
      setState(() {
        _todayPlay = TodayPlayModel.fromJson(res.data);
      });
    }
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _homeData.length >  0 ? ListView(
      children: <Widget>[
        SizedBox(height: ScreenAdapter.height(30)),
        // 分类
        _marginContainer(_homeCategory()),
        // 今日播放
        _marginContainer(_todayPlay != null ? _homeTodayPlay():Container()),
        // 影院热映
        _marginContainer(MovieShow(_homeData[4],_homeData[5])),
        // 豆瓣热门
        _marginContainer(_doubanHot(_homeData[7]['data'])),
      ],
    ):Container();
  }
  // 构建豆瓣热门
  Widget _doubanHot(data){
    data = data['subject_collection_boards'][0];
    return Column(
      children: <Widget>[
        RowTitle(title: '豆瓣热门',count: data['subject_collection']['subject_count']),
        GridViewItems(
          data: data['items'],
          itemCount: 6,
        )
      ],
    );
  }
  // 边距容器
  Widget _marginContainer(child){
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenAdapter.height(30), ScreenAdapter.height(0), ScreenAdapter.height(30), ScreenAdapter.height(30)),
      child: child,
    );
  }
  // 构建首页分类
  Widget _homeCategory(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:_homeData[0]['data']['subject_entraces'].map<Widget>((item){
        return GestureDetector(
          onTap: (){
            Application.router.navigateTo(context, '/doubanTop');
          },
          child: Column(
            children: <Widget>[
              Image.network(item['icon'],width: ScreenAdapter.width(90)),
              SizedBox(height: ScreenAdapter.height(20)),
              Text(item['title'])
            ],
          ),
        );
      }).toList(),
    );
  }

  // 构建首页今日播放
  Widget _homeTodayPlay (){
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
      height: ScreenAdapter.height(250),
      child:  Stack(
        alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
                color: Utils.colorTransform(_todayPlay.videos[0].colorScheme.primaryColorDark),
              ),
              width: double.infinity,
              height: ScreenAdapter.height(210),
            ),
            Positioned(
              left: ScreenAdapter.width(160),
              bottom: ScreenAdapter.height(40),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${_todayPlay.videos[2].pic.normal}',fit: BoxFit.fill),
                ),
                width:ScreenAdapter.width(180),
                height: ScreenAdapter.height(180),
              ),
            ),
            Positioned(
              left: ScreenAdapter.width(100),
              bottom: ScreenAdapter.height(40),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${_todayPlay.videos[1].pic.normal}',fit: BoxFit.fill),
                ),
                width:ScreenAdapter.width(180),
                height: ScreenAdapter.height(190),
              ),
            ),
            Positioned(
              left: ScreenAdapter.width(40),
              bottom: ScreenAdapter.height(40),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${_todayPlay.videos[0].pic.normal}',fit: BoxFit.fill),
                ),
                width:ScreenAdapter.width(180),
                height: ScreenAdapter.height(200),
              ),
            ),
            Positioned(
              right: ScreenAdapter.width(10),
              top: ScreenAdapter.width(100),
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(280),
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                    child: Text('${_todayPlay.title}',style: TextStyle(color: Colors.white,fontSize: 16)),
                  ),
                  Container(
                    width: ScreenAdapter.width(280),
                    child: Row(
                      children: <Widget>[
                        Text('全部 ${_todayPlay.total}',style: TextStyle(color: Colors.white,fontSize: 14)),
                        Icon(Icons.keyboard_arrow_right,size:17,color:Colors.white)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: ScreenAdapter.width(15),
              bottom: ScreenAdapter.width(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.movie_filter,color: Colors.white,size: 17),
                  SizedBox(width: ScreenAdapter.width(6)),
                  Text('看电影',style: TextStyle(color: Colors.white,fontSize: 12))
                ],
              ),
            ),
          ],
        ),
      );
    }


  }
