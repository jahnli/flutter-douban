import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/todayPlay.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/pages/tabs/book_movie/movie/movieShow/movie_show.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';

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
        Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: _todayPlay != null ? _homeCategory():Container()
        ),
        
        Container(
          margin: EdgeInsets.only(left: 15,right: 15),
          child: MovieShow(movieShowData: _homeData[4],movieSoonData: _homeData[5]),
        ),
      ],
    ):Container();
  }


  // 构建首页今日播放
  Widget _homeCategory (){
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
