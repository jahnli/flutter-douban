import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/views/doubanTop/topItems/category_top20.dart';
import 'package:flutter_douban/views/doubanTop/topItems/default_top_item.dart';
import 'package:flutter_douban/views/doubanTop/topItems/year_top_item.dart';
import 'package:flutter_douban/weiget/base_loading.dart';

// 数据格式

class DoubanTopMovie extends StatefulWidget {
  @override
  _DoubanTopMovieState createState() => _DoubanTopMovieState();
}

class _DoubanTopMovieState extends State<DoubanTopMovie> with AutomaticKeepAliveClientMixin{

  bool get wantKeepAlive => true; 


  //  数据列表
  DoubanTopMovieModel _dataList;

  @override
  void initState() { 
    super.initState();
    // 获取榜单数据
    _getTopMovieData();
    
  }
  
  // 获取年度榜单
  _getTopMovieData()async{
    try{
      Response res = await NetUtils.ajax('get', ApiPath.home['doubantopMovie']);
      if(mounted){
        setState(() {
          _dataList  = DoubanTopMovieModel.fromJson(res.data);
        });
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _dataList != null ? Container(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),0,ScreenAdapter.width(30),ScreenAdapter.width(30)),
      child: ListView(
        children: <Widget>[
          // 榜单
          Column(
            children: <Widget>[
              SizedBox(height: ScreenAdapter.height(30)),
              DefaultTopItem(_dataList.groups[0].selectedCollections[0]),
              DefaultTopItem(_dataList.groups[0].selectedCollections[1]),
              DefaultTopItem(_dataList.groups[0].selectedCollections[2],showTrend:false),
            ],
          ),
          // 豆瓣年度榜单
          Column(
            children: <Widget>[
              SizedBox(height: ScreenAdapter.height(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('豆瓣年度榜单',style: TextStyle(fontSize: 24,color:Colors.black,fontWeight: FontWeight.w600)),
                  Row(
                    children: <Widget>[
                      Text('全部',style: TextStyle(color:Colors.black87,fontSize: 16)),
                      Icon(Icons.keyboard_arrow_right,color:Colors.black87)
                    ],
                  )
                ],
              ),
              SizedBox(height: ScreenAdapter.height(20)),
              YearTopItem(_dataList.groups[1].selectedCollections[0]),
              YearTopItem(_dataList.groups[1].selectedCollections[1]),
              YearTopItem(_dataList.groups[1].selectedCollections[2]),
            ],
          ),
          // 高分榜
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
            child: Text('豆瓣高分榜',style: TextStyle(fontSize: 24,color: Colors.black))
          ),
          CategoryTop20(_dataList.groups[2].selectedCollections[0]),
          CategoryTop20(_dataList.groups[2].selectedCollections[1]),
          CategoryTop20(_dataList.groups[2].selectedCollections[2]),
          CategoryTop20(_dataList.groups[2].selectedCollections[3]),
          CategoryTop20(_dataList.groups[2].selectedCollections[4]),
          CategoryTop20(_dataList.groups[2].selectedCollections[5]),
          CategoryTop20(_dataList.groups[2].selectedCollections[6]),
          CategoryTop20(_dataList.groups[2].selectedCollections[7]),
          CategoryTop20(_dataList.groups[2].selectedCollections[8]),
          CategoryTop20(_dataList.groups[2].selectedCollections[9]),
        ],
      )
    ):BaseLoading();
  }
}