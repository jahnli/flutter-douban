import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/movieRecomment.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/rowTitle.dart';
class MovieRecomment extends StatefulWidget {
  @override
  _MovieRecommentState createState() => _MovieRecommentState();
}

class _MovieRecommentState extends State<MovieRecomment> {

  MovieRecommentModel _data;

  @override
  void initState() { 
    super.initState();
    _getMovieRecomment();
  }

  // 获取主页home推荐
  _getMovieRecomment() async {
    try {

      Response res = await NetUtils.ajax('get', ApiPath.home['movieRecomment']);

      if(mounted){
        setState(() {
          _data = MovieRecommentModel.fromJson(res.data);
        });
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _data != null ? Container(
      child: Column(
        children: <Widget>[
          RowTitle(
            title: '为你推荐',
            showRightAction: false,
          ),
          // 筛选区域
          _filterAction(),
          // 轮播推荐
          _carousel()
          // 内容区域
          _content()
        ],
      ),
    ):Container();
  }
  // 内容区域
  Widget _content(){
    return Container(
      child: ,
    );
  }
  // 轮播推荐
  Widget _carousel(){
    var _item = _data.items[0];
    Color _baseTextColor = _item.color_scheme.is_dark ? Colors.white38:Colors.black;
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse('0xff' + _item.color_scheme.primary_color_dark)),
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(300),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Transform.scale(
                scale: 1.8,
                child: Transform.rotate(
                  angle: 6,
                  child: Image.network('${_item.cover_url}',width: ScreenAdapter.getScreenWidth(),fit: BoxFit.fitHeight),
                ),
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('${_item.subtitle}',style: TextStyle(fontSize: 16,color: _baseTextColor))
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(10), 0, ScreenAdapter.height(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.play_circle_filled,color: Colors.white,size: 28),
                      Text('${_item.title}',style: TextStyle(fontSize: 22,color:Colors.white))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('共${_item.items_count}部',style: TextStyle(fontSize: 16,color: _baseTextColor)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 筛选区域
  Widget _filterAction(){
    return Container(
        height: ScreenAdapter.height(50),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Container(
                    padding: EdgeInsets.only(left: ScreenAdapter.width(20),right: ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey
                      )
                    ),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text('${_data.recommend_tags[index]}'),
                    ),
                  );
                },
                itemCount: _data.recommend_tags.length,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: ScreenAdapter.width(90),
              child: Row(
                children: <Widget>[
                  Image.network('http://cdn.jahnli.cn/filter.png',width: ScreenAdapter.width(25)),
                  Text('筛选',style: TextStyle(fontSize: 14))
                ],
              )
            )
          ],
        )
      );
  }


}