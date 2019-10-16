import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieGuide extends StatefulWidget {
  @override
  _MovieGuideState createState() => _MovieGuideState();
}

class _MovieGuideState extends State<MovieGuide> with AutomaticKeepAliveClientMixin{

  bool get wantKeepAlive => true;

  String _requestStatus = '';

  // 观影指南列表
  List _guideList = [];

  @override
  void initState() { 
    super.initState();
    _getMovieGuide();
  }
  // 获取观影指南数据
  _getMovieGuide()async{
     try{
      Options option = Options(
        headers: {
          HttpHeaders.refererHeader: 'https://frodo.douban.com',
        },
      );
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_monthly_recommend/items?&for_mobile=1&callback=jsonp1&start=0&count=18',options:option);
      
      if(mounted){
        setState(() {
          _requestStatus = '获取年度豆瓣榜单成功';
          _guideList = json.decode(res.data.substring(8,res.data.length - 2))['subject_collection_items'];
        });   
      }
    }
    catch(e){
      print(e);
      if(mounted){
        setState(() {
          _requestStatus = '获取年度豆瓣榜单失败'; 
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            color: Color(int.parse('0xffFFF3E0')),
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Text('豆瓣为你整理出当月最值得看的院线电影。点击"想看"来收藏喜欢的电影，当影片上映、有播放源时会通知你。',style: TextStyle(color: Colors.grey[600])),
          ),
          _guideList.length > 0 ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _guideList.length,
            itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30),top: ScreenAdapter.height(30)),
                padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                child:GestureDetector(
                  onTap: (){
                    Application.router.navigateTo(context, '/movieDetail?id=${_guideList[index]['id']}');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 缩略图
                      _thumb(_guideList[index]), 
                      // 中间信息区域
                      SizedBox(width: ScreenAdapter.width(30)),
                      _info(_guideList[index]),
                      SizedBox(width: ScreenAdapter.width(30)),
                      // 右侧操作区域
                      _actions(_guideList[index])
                    ],
                  ),
                )
              );
            },
          ):BaseLoading(type: _requestStatus)
        ],
      ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
              child: Text('${item['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
            ),
            item['rating'] != null ? Row(
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
            ):Container(
              alignment: Alignment.centerLeft,
              child: Text('${item['wish_count']}人想看',style: TextStyle(color: Colors.grey,fontSize: 12)),
            ),
            Text('${item['card_subtitle']}',maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 12)),
            Text('${item['description']}',maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12))
          ],
        ),
      ), 
    );
  }
  // 右侧操作区域
  Widget _actions(item){
    return Container(
      height: ScreenAdapter.height(180),
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
                  child: Image.network('http://cdn.jahnli.cn/favorite.png',width: ScreenAdapter.width(40))
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