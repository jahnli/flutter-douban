import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/views/doubanTop/topItems/default_top_item.dart';
import 'package:flutter_douban/weiget/base_loading.dart';

// 数据格式

class DoubanTopFiction extends StatefulWidget {
  @override
  _DoubanTopFictionState createState() => _DoubanTopFictionState();
}

class _DoubanTopFictionState extends State<DoubanTopFiction> with AutomaticKeepAliveClientMixin{

  bool get wantKeepAlive => true; 


  //  数据列表
  DoubanTopMovieModel _dataList;

  @override
  void initState() { 
    super.initState();
    // 获取榜单数据
    _getTopFictionData();
    
  }
  
  // 获取年度榜单
  _getTopFictionData()async{
    try{
      Response res = await NetUtils.ajax('get', ApiPath.home['doubanTopFiction']);
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
              DefaultTopItem(_dataList.groups[0].selectedCollections[0],showTrend:false),
              DefaultTopItem(_dataList.groups[0].selectedCollections[1]),
            ],
          ),
        ],
      )
    ):BaseLoading();
  }
}