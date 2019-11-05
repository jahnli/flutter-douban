import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/views/doubanTop/topItems/default_top_item.dart';
import 'package:flutter_douban/views/doubanTop/topItems/year_top_item.dart';
import 'package:flutter_douban/weiget/base_loading.dart';

// 数据格式

class DoubanTopBook extends StatefulWidget {
  @override
  _DoubanTopBookState createState() => _DoubanTopBookState();
}

class _DoubanTopBookState extends State<DoubanTopBook> with AutomaticKeepAliveClientMixin{

  bool get wantKeepAlive => true; 


  //  数据列表
  DoubanTopMovieModel _dataList;

  @override
  void initState() { 
    super.initState();
    // 获取榜单数据
    _getTopBookData();
    
  }
  
  // 获取年度榜单
  _getTopBookData()async{
    try{
      Response res = await NetUtils.ajax('get', ApiPath.home['doubanTopBook']);
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
          SizedBox(height: ScreenAdapter.height(30)),
          // 榜单
          Column(
            children:_dataList.groups[0].selectedCollections.asMap().keys.map((index){
              DoubanTopMovieModelGroupsSelectedCollections item = _dataList.groups[0].selectedCollections[index];
              return GestureDetector(
                child: DefaultTopItem(item,showTrend: item.rankType == 'top250' ? false:true),
                onTap: (){
                  Application.router.navigateTo(context, '/doubanTopDetail?id=${item.id}');
                },
              );
            }).toList(),
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
              Column(
                children: _dataList.groups[1].selectedCollections.map((item){
                  return GestureDetector(
                    onTap: (){
                      Application.router.navigateTo(context, '/doubanTopDetail?id=${item.id}&showFilter=false');
                    },
                    child: YearTopItem(item),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      )
    ):BaseLoading();
  }
}