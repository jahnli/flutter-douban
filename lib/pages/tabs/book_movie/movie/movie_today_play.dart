import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
class MovieTodayPlay extends StatefulWidget {


  @override
  _MovieTodayPlayState createState() => _MovieTodayPlayState();
}

class _MovieTodayPlayState extends State<MovieTodayPlay> {

  // 今日播放
  Map _todayPlay;

  String _requestStatus = '';

  @override
  void initState() { 
    super.initState();
    // 获取今日播放
    _getTodayMovie();
  }

  // 获取今日播放
  _getTodayMovie()  async{
    try{
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/skynet/playlist/recommend/event_videos?count=3&out_skynet=true&for_mobile=1', options: Options(
        headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if (mounted) {
        if(res.data['count'] > 0){
          setState(() {
            _todayPlay= res.data; 
          });
        }else{
          setState(() {
            _requestStatus = '暂无今日播放'; 
          });
        }        
      }

    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _todayPlay !=null ? Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
      height: ScreenAdapter.height(250),
      child:  Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
              color: Color(int.parse('0xff' + _todayPlay['videos'][0]['header_bg_color'])),
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
                child: Image.network('${_todayPlay['videos'][2]['pic']['normal']}',fit: BoxFit.fill),
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
                child: Image.network('${_todayPlay['videos'][1]['pic']['normal']}',fit: BoxFit.fill),
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
                child: Image.network('${_todayPlay['videos'][0]['pic']['normal']}',fit: BoxFit.fill),
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
                  child: Text('${_todayPlay['title']}',style: TextStyle(color: Colors.white,fontSize: 16)),
                ),
                Container(
                  width: ScreenAdapter.width(280),
                  child: Row(
                    children: <Widget>[
                      Text('全部 ${_todayPlay['total']}',style: TextStyle(color: Colors.white,fontSize: 14)),
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
    ):Container(
      height: ScreenAdapter.height(350),
      child: BaseLoading(type:_requestStatus),
    );
  }
}