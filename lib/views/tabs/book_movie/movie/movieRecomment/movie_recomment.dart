import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/rowTitle.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MovieRecomment extends StatefulWidget {
  @override
  _MovieRecommentState createState() => _MovieRecommentState();
}

class _MovieRecommentState extends State<MovieRecomment> {

  Map _data;

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
          _data = res.data;
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
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              String type = _data['items'][index]['card'] ??= 'null';
              switch (type) {
                case 'chart':
                  // 卡片
                  return _card( _data['items'][index]);
                  break;
               case 'doulist':
                  // 卡片
                  return _card( _data['items'][index]);
                  break;
                case 'subject':
                  // 影片
                  return _film( _data['items'][index]);
                  break;
                case 'null':
                  // 空
                  return Container();
                  break;
                default:
              }
            },
            itemCount: _data['items'].length,
          )
        ],
      ),
    ):Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
      child: BaseLoading(),
    );
  }
  // 内容区域
  Widget _film(item){
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '/filmDetail?id=${item['id']}');
      },
      child: Container(
        margin: EdgeInsets.only(top: ScreenAdapter.height(20),bottom: ScreenAdapter.height(40)),
        child:Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${item['pic']['normal']}',height: ScreenAdapter.height(Configs.thumbHeight())),
                ),
                SizedBox(width: ScreenAdapter.width(20)),
                Expanded(
                  child: Container(
                    height: ScreenAdapter.height(Configs.thumbHeight()),
                    child: Swiper(
                      itemBuilder: (BuildContext context, int swiperIndex) {
                        return  ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network('${item['photos'][swiperIndex]}',fit: BoxFit.fill,),
                        );
                      },
                      itemCount: item['photos'].length,
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomLeft,
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.white,
                          color: Color.fromRGBO(92, 98, 102, 1),
                          size: 5,
                          activeSize: 5
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
              child: Text('${item['title']} (${item['year']})',style: TextStyle(fontSize: 22)),
            ),
            BaseGrade(value: item['rating']['value']),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(20)),
              child: Text('${item['comment']['comment']} -- ${item['comment']['user']['name']}',style: TextStyle(color: Colors.grey,fontSize: 16)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), ScreenAdapter.width(10), ScreenAdapter.width(20), ScreenAdapter.width(10)),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 239, 228, 1),
                  borderRadius: BorderRadius.circular(35)
                ),
                child: Text('${item['tags'][0]['name']}',textAlign: TextAlign.start,style: TextStyle(color: Color.fromRGBO(142, 111, 63, 1))),
              ),
            )
          ],
        )
      ),
    );
  }
  // 轮播推荐
  Widget _card(_item){
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(30),bottom: ScreenAdapter.height(40)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.5,
          color: Colors.grey
        )
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(300),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
              ),
              child: Transform.scale(
                scale: 1.8,
                child: Transform.rotate(
                  angle: 6,
                  child: Image.network('${_item['cover_url']}',width: ScreenAdapter.getScreenWidth(),fit: BoxFit.fitHeight),
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
                  child: Text('${_item['subtitle']}',style: TextStyle(fontSize: 16,color:  Colors.grey))
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(10), 0, ScreenAdapter.height(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.play_circle_filled,color: Colors.black,size: 28),
                      SizedBox(width: ScreenAdapter.width(10)),
                      Container(
                        width: ScreenAdapter.getScreenWidth() - ScreenAdapter.width(170),
                        child: Text('${_item['title']}',style: TextStyle(fontSize: 22,color:Colors.black)),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('共${_item['items_count']}部',style: TextStyle(fontSize: 16,color:  Colors.grey)),
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
                      child: Text('${_data['recommend_tags'][index]}'),
                    ),
                  );
                },
                itemCount: _data['recommend_tags'].length,
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