import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MovieRecommend extends StatefulWidget {
  
  List data = [];
  bool loading ;
  String tags;
  Function resetRecommend;

  MovieRecommend({this.data,this.loading,this.tags,this.resetRecommend});

  @override
  _MovieRecommendState createState() => _MovieRecommendState();
}

class _MovieRecommendState extends State<MovieRecommend> {

  @override
  Widget build(BuildContext context) {
    return !widget.loading ? widget.data.length > 0 ? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index){
          String type = widget.data[index]['type'];
          switch (type) {
            case 'movie':
              // 影片
              return _film( widget.data[index]);
              break;
            case 'ad':
              // 空
              return Container();
            default:
              return _card( widget.data[index]);
              break;
          }
        },
        itemCount: widget.data.length,
      ):Container(
        margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(40), 0, ScreenAdapter.height(40)),
        child:Wrap(
          children: <Widget>[
            Text('暂无${widget.tags.replaceAll(',',' · ')}的电影，',style: TextStyle(color: Colors.grey,fontSize: 20)),
            GestureDetector(
              onTap: widget.resetRecommend,
              child: Text('重置',style: TextStyle(color:Color.fromRGBO(104, 203, 120, 1),fontSize: 20)),
            )
          ],
        ),
      ):Container(
        margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(40), 0, ScreenAdapter.height(40)),
        child: BaseLoading()
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
            BaseGrade(value: item['rating']['value'] == 0 ? 0.0:item['rating']['value']),
            item['commend'] != null ?Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(20)),
              child: Text('${item['commend']['commend']} -- ${item['commend']['user']['name']}',style: TextStyle(color: Colors.grey,fontSize: 16)),
            ):Container(),
            item['tags'].length >  0 ? Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                children:  item['tags'].map<Widget>((tagsItem){
                  return Container(
                    margin: EdgeInsets.only(top:ScreenAdapter.width(20), right: ScreenAdapter.width(20)),
                    padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), ScreenAdapter.width(10), ScreenAdapter.width(20), ScreenAdapter.width(10)),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 239, 228, 1),
                      borderRadius: BorderRadius.circular(35)
                    ),
                    child: Text('${tagsItem['name']}',textAlign: TextAlign.start,style: TextStyle(color: Color.fromRGBO(142, 111, 63, 1)))
                  );
                }).toList(),
              ) 
            ):Container()
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
}

