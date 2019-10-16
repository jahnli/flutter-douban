import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';

class MovieTop extends StatefulWidget {
  @override
  _MovieTopState createState() => _MovieTopState();
}


class _MovieTopState extends State<MovieTop> {

  // 一周口碑电影榜
  Map _weekMovie;
  // 豆瓣电影top250
  Map _topMovie;
  // 一周热映榜
  Map _hotMovie;

  String _requestStatus = '';

  // 获取数据
  _getData()async{
    try{
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/movie/modules?for_mobile=1', options: Options(
      headers: {
        HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
      },
      ));
      if(mounted){
        setState(() {
          _weekMovie = res.data['modules'][8]['data']['selected_collections'][0]; 
          _topMovie = res.data['modules'][8]['data']['selected_collections'][1]; 
          _hotMovie = res.data['modules'][8]['data']['selected_collections'][2]; 
          _requestStatus = '获取豆瓣榜单成功';
        });   
      }
    }
    catch(e){
      if(mounted){
        setState(() {
          _requestStatus = '获取豆瓣榜单失败'; 
        });
      }
    }
  }

 

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('豆瓣榜单',style: TextStyle(fontSize: 24,color:Colors.black,fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: (){
                  Application.router.navigateTo(context, '/doubanTop');
                },
                child: Row(
                  children: <Widget>[
                    Text('全部',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.w600)),
                    Icon(Icons.chevron_right)
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: ScreenAdapter.height(30)),
        _requestStatus.isNotEmpty ? Container(
          height: ScreenAdapter.height(420),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Application.router.navigateTo(context, '/movieTopDetail?index=0');
                },
                child: Container(
                  margin: EdgeInsets.only(left: ScreenAdapter.width(30)),
                  child: _weekMovie !=null  ? _item(_weekMovie,'weekMovie'):BaseLoading(type:_requestStatus),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Application.router.navigateTo(context, '/movieTopDetail?index=1');
                },
                child: Container(
                  margin: EdgeInsets.only(left: ScreenAdapter.width(30)),
                  child:  _topMovie !=null  ? _item(_topMovie,'topMovie'):BaseLoading(type:_requestStatus),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Application.router.navigateTo(context, '/movieTopDetail?index=2');
                },
                child: Container(
                  margin: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
                  child: _hotMovie  !=null  ? _item(_hotMovie,'hotMovie'):BaseLoading(type:_requestStatus),
                ),
              ),
            ],
          ),
        ):BaseLoading(type: _requestStatus)
      ],
    );
  }
  // 单独块
  Widget _item(data,type){
    return Container(
      width: ScreenAdapter.width(450),
      decoration: BoxDecoration(
        color: Color(int.parse('0xff'+'${data['background_color_scheme']['primary_color_dark']}')),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.6,
                  child: ClipRRect(
                      child: Image.network('${data['header_bg_image']}',width:  ScreenAdapter.width(450),height: ScreenAdapter.height(220),fit: BoxFit.cover),borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight:Radius.circular(8) )
                  ),
                ),
                Positioned(
                  bottom: ScreenAdapter.height(30),
                  left: ScreenAdapter.width(30),
                  child: Text('${data['name']}',style: TextStyle(fontSize: 24,color: Colors.white)),
                ),
                Positioned(
                  top: ScreenAdapter.height(40),
                  right: ScreenAdapter.width(30),
                  child: Text('${data['description']}',style: TextStyle(fontSize: 13,color: Colors.white)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Column(
              children: data['items'].asMap().keys.map<Widget>((index){
                return Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(350),
                      child:Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('${index+1}. ${data['items'][index]['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,height:1.5)),
                          ),
                          Container(
                            width: ScreenAdapter.width(50),
                            child:  Text('${data['items'][index]['rating']['value']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.orange,height:1.5)),
                          )
                        ],
                      ) ,
                    ),
                    type != 'topMovie' ? Icon(data['items'][index]['trend_up'] == true ? Icons.arrow_upward : Icons.arrow_downward,color: Colors.grey,size: 16) : Text('')
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}