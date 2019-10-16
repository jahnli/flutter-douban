import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class MovieHotDetail extends StatefulWidget {
  @override
  _MovieHotDetailState createState() => _MovieHotDetailState();
}

class _MovieHotDetailState extends State<MovieHotDetail> {
 // 豆瓣500热映列表
  List _hotList = [];
  // 分页
  int _start = 0;
  // 总数量
  int _total = 500;
  // 筛选
  String _requestStatus = '';
  // 搜索类型切换
  AlignmentGeometry _alignment = Alignment.centerLeft;
  // 刷新控制器
  RefreshController _controller = RefreshController();

    @override
  void initState() { 
    super.initState();
    _getDouBanHot();
  }

  // 获取豆瓣热门500列表数据
  _getDouBanHot() async {
    try {
      Options options = Options(
        headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      );
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_hot_gaia/items?os=ios&for_mobile=1&callback=jsonp1&start=$_start&count=10&loc_id=0&_=1571127238352',options:options);

      if(mounted){
        setState(() {
          _hotList.addAll(json.decode(res.data.substring(8,res.data.length - 2))['subject_collection_items']);
        });
      }
    }
    catch (e) {
      print(e);
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('豆瓣热门',style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          title:TextStyle(color: Colors.black)
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        brightness: Brightness.light,
      ),
      body: SmartRefresher(
        controller: _controller,
        enablePullUp: true,
        enablePullDown: false,
        footer: CustomScrollFooter(),
        onLoading: () async {
          if(_start + 10 < _total){
            setState(() {
              _start = _start + 10;
            });
            await _getDouBanHot();
            _controller.loadComplete();
          }else{
            _controller.loadNoData();
          }
        },
        child: _hotList.length > 0 ? ListView(
          children: <Widget>[
            Container(
              height: ScreenAdapter.height(80),
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('影视 $_total',style: TextStyle(fontSize: 16)),
                  // 类型切换
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30),top: ScreenAdapter.height(30)),
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Colors.grey[300],
                      )
                    )
                  ),
                  child:GestureDetector(
                    onTap: (){
                      Application.router.navigateTo(context, '/movieDetail?id=${_hotList[index]['id']}');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // 缩略图
                        _thumb(_hotList[index]), 
                        // 中间信息区域
                        SizedBox(width: ScreenAdapter.width(30)),
                        _info(_hotList[index]),
                        SizedBox(width: ScreenAdapter.width(30)),
                        // 右侧操作区域
                        _actions(_hotList[index])
                      ],
                    ),
                  )
                );
              },
              itemCount: _hotList.length,
            )
          ],
        ):BaseLoading(type: _requestStatus),
      )
    );
  }
  
  // 左侧缩略图
  Widget _thumb(item){
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network('${item['cover']['url']}',width: ScreenAdapter.width(200),height: ScreenAdapter.height(220),fit: BoxFit.cover,),
    );
  }
  // 中间信息区域
  Widget _info(item){
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: ScreenAdapter.height(220)
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
              child: Wrap(
                spacing: ScreenAdapter.width(10),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text('${item['title']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
                  Text('(${item['year']})',style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w400))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                RatingBarIndicator(
                  rating:item['rating']['value'] / 2,
                  alpha:0,
                  unratedColor:Colors.grey,
                  itemPadding: EdgeInsets.all(0),
                  itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 11,
                ),
                SizedBox(width: ScreenAdapter.width(15)),
                Text('${item['rating']['value']}',style: TextStyle(color: Colors.grey,fontSize: 12))
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(10)),
              alignment: Alignment.centerLeft,
              child: Text('${item['card_subtitle']}',maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 14)),
            )
          ],
        ),
      ), 
    );
  }
  // 右侧操作区域
  Widget _actions(item){
    return Container(
      height: ScreenAdapter.height(240),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){

            },
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){

                  },
                  child: Image.network('http://cdn.jahnli.cn/favorite.png',width: ScreenAdapter.width(40)),
                ),
                SizedBox(height: ScreenAdapter.height(10)),
                Text('想看',style: TextStyle(fontSize: 12,color: Colors.orange))
              ],
            ),
          ),
        ],
      )
    );
  }
 

}