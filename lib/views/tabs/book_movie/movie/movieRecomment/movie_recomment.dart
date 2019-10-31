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
  // 筛选标签
  List _recommendTagsList = [];
  // 筛选参数列表
  List _filterParamsList = [];
  // 数据列表
  List _dataList = [];
  bool _loading = true;
  // 筛选参数
  Map<String,dynamic> _filterParams = {
    "s":'rexxar_new',
    "device_id":'87697746e90528f98b6ef4df57178fcab999f9fb',
    "apple":'b8b42270b55ac2d084d865dd261c154d',
    "icecream":'c780d627b64c3057222c7c6102a2d1a9',
    "mooncake":'61260adfd35182c0518f765b32c8ad4b',
    "apikey":'0dad551ec0f84ed02907ff5c42e8ec70',
    "loc_id":'108296',
    "_sig":'R0Grs%2FBOc943XTM5BEEv9uFY5Qw%3D',
    "uuid":"87697746e90528f98b6ef4df57178fcab999f9fb",
    "rom":"android",
    "sugar":"46000",
    "_ts":"1572082252",
  };

  // 当前排行
  double _currentSort = 0;

  @override
  void initState() { 
    super.initState();
    _getMovieRecomment();
  }

  // 获取主页home推荐
  _getMovieRecomment() async {

    try {
      Response res = await NetUtils.ajax('get', ApiPath.home['movieRecomment'],params:_filterParams);

      if(mounted){
        setState(() {
          _data = res.data;
          _dataList = res.data['items'];
          if(res.data['bottom_recommend_tags'].length > 0){
            _recommendTagsList = res.data['bottom_recommend_tags'];
          }
          _loading = false;
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
          _filterParamsList.length > 0 ? _sortAction():Container(),
          !_loading ? _dataList.length > 0 ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              String type = _dataList[index]['type'];
              switch (type) {
                case 'movie':
                  // 影片
                  return _film( _dataList[index]);
                  break;
                case 'ad':
                  // 空
                  return Container();
                default:
                  return _card( _dataList[index]);
                  break;
              }
            },
            itemCount: _dataList.length,
          ):Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(40), 0, ScreenAdapter.height(40)),
            child:Wrap(
              children: <Widget>[
                 Text('暂无${_filterParams['tags'].replaceAll(',',' · ')}的电影，',style: TextStyle(color: Colors.grey,fontSize: 20)),
                 GestureDetector(
                   onTap: (){
                     setState(() {
                       _loading = true;
                       _filterParamsList = [];
                       _filterParams['tags'] = '';
                     });
                     _getMovieRecomment();
                   },
                   child: Text('重置',style: TextStyle(color:Color.fromRGBO(104, 203, 120, 1),fontSize: 20)),
                 )
              ],
            ),
          ):Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(40), 0, ScreenAdapter.height(40)),
            child: BaseLoading()
          )
        ],
      ),
    ):Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
      child: BaseLoading(),
    );
  }
  // 排行 区域
  _sortAction(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
      child: Container(
        height: ScreenAdapter.height(55),
        width: ScreenAdapter.width(400),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: <Widget>[    
            AnimatedPositioned(
              left: ScreenAdapter.width(_currentSort * 100),
              curve: Curves.ease,
              duration: Duration(milliseconds: 500),
              child: Opacity(
                opacity: 1,
                child: Container(
                  height: ScreenAdapter.height(55),
                  width: ScreenAdapter.width(100),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey
                    )
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[ 
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 0) return;
                    setState(() {
                      _currentSort = 0; 
                      _loading = true;
                    });
                    _getMovieRecomment();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('默认'),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 1) return;
                    setState(() {
                      _loading = true;
                      _currentSort = 1; 
                      _filterParams['sort'] = 'T'; 
                    });
                    _getMovieRecomment();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('热度'),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 2) return;
                    setState(() {
                      _loading = true;
                      _currentSort = 2; 
                      _filterParams['sort'] = 'S'; 
                    });
                    _getMovieRecomment();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('评分'),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 3) return;
                    setState(() {
                      _loading = true;
                      _currentSort = 3; 
                      _filterParams['sort'] = 'R'; 
                    });
                    _getMovieRecomment();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('时间'),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
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
            item['comment'] != null ?Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(20)),
              child: Text('${item['comment']['comment']} -- ${item['comment']['user']['name']}',style: TextStyle(color: Colors.grey,fontSize: 16)),
            ):Container(),
            item['tags'].length >  0 ? Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                children:  item['tags'].map<Widget>((tagsItem){
                  return Container(
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
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
    return _recommendTagsList.length > 0 ? Container(
      height: ScreenAdapter.height(50),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context,index){
                bool _isSelect = _filterParamsList.contains('${_recommendTagsList[index]}');
                String _tempParams = '';
                return GestureDetector(
                  onTap: (){
                    // 如果已选中，取消选中
                    if(_isSelect){
                      setState(() {
                        _filterParamsList.remove(_recommendTagsList[index]);
                      });
                    }else{
                      setState(() {
                        _filterParamsList.add(_recommendTagsList[index]);
                      });
                    }
                    for (int i = 0; i < _filterParamsList.length; i++) {
                      _tempParams += i == 0 ? '${_filterParamsList[i]}':',${_filterParamsList[i]}';
                    }
                    if(_filterParamsList.length == 0){
                      setState(() {
                        _currentSort = 0; 
                      });
                    }
                    setState(() {
                      _loading = true;
                      _filterParams['tags'] = _tempParams; 
                    });
                    _getMovieRecomment();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenAdapter.width(20),right: ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                      color:_isSelect ? Color.fromRGBO(104, 203, 120, 1):Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border:!_isSelect ? Border.all(
                        width: 1,
                        color: Colors.grey
                      ):null
                    ),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text('${_recommendTagsList[index]}',style: TextStyle(color: _isSelect ? Colors.white:Colors.black)),
                    ),
                  ),
                );
              },
              itemCount: _recommendTagsList.length,
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
    ):Container();
  }


}