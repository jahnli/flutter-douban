import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/grid_view.dart';
import 'package:flutter_douban/weiget/rowTitle.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage>  with AutomaticKeepAliveClientMixin{

  
  @override
  bool get wantKeepAlive => true;

  // 首页模块数据
  List _homeData = [];
  // 当前热播新剧索引
  int _currentHotTvIndex = 0;
  // 当前热播新剧影片数量
  int _currentHotTvCount = 0;
  // 当前热播综艺索引
  int _currentHotVarietyIndex = 0;
  // 当前热播综艺数量
  int _currentHotVarietyCount = 0;

  @override
  void initState() { 
    super.initState();
    // 获取数据
    _getHomeData();
  }

  // 获取首页数据
  _getHomeData()async{
    try {
      Response res = await NetUtils.ajax('get', ApiPath.home['tvHome']);
      if(mounted){
        setState(() {
          _homeData = res.data['modules'];
          _currentHotTvCount = _homeData[4]['data']['subject_collection_boards'][0]['subject_collection']['subject_count'];
          _currentHotVarietyCount = _homeData[10]['data']['subject_collection_boards'][0]['subject_collection']['subject_count'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _homeData.length > 0 ? Container(
      padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
      child: ListView(
        children: <Widget>[
          SizedBox(height: ScreenAdapter.height(30)),
          // 首页分类
          _homeCategory(),
          SizedBox(height: ScreenAdapter.height(30)),
          // 热播新剧
          _hotPlayTv(),
          SizedBox(height: ScreenAdapter.height(30)),
          // 热播综艺
          _hotPlayVariety()
        ],
      ),
    ):Center(
      child: BaseLoading(),
    );
  }

  // 热播综艺
  Widget _hotPlayVariety(){
    return Column(
      children: <Widget>[
        RowTitle(
          margin: 20,
          title: _homeData[3]['data']['title'],
          count: _currentHotVarietyCount,
        ),
        Row(
          children: _homeData[3]['data']['collections'].asMap().keys.map<Widget>((index){
            Map _item =  _homeData[index+10]['data']['subject_collection_boards'][0]['subject_collection'];
            return GestureDetector(
              onTap: (){
                setState(() {
                  _currentHotVarietyIndex = index;
                  _currentHotVarietyCount = _item['subject_count'];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: _currentHotVarietyIndex == index ? Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.black
                    )
                  ):null
                ),
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                padding: EdgeInsets.only(bottom: ScreenAdapter.width(10)),
                child: Text('${_item['short_name']}',style: TextStyle(color: _currentHotVarietyIndex == index ? Colors.black:Colors.grey,fontSize: ScreenAdapter.fontSize(30))),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: ScreenAdapter.height(20)),
        GridViewItems(
          data: _homeData[_currentHotVarietyIndex+10]['data']['subject_collection_boards'][0]['items'],
          itemCount:6,
          thumbHeight: 'large',
        )
      ],
    );
  }

  // 热播新剧
  Widget _hotPlayTv(){
    return Column(
      children: <Widget>[
        RowTitle(
          margin: 20,
          title: _homeData[1]['data']['title'],
          count: _currentHotTvCount,
        ),
        Row(
          children: _homeData[1]['data']['collections'].asMap().keys.map<Widget>((index){
            Map _item =  _homeData[index+4]['data']['subject_collection_boards'][0]['subject_collection'];
            return GestureDetector(
              onTap: (){
                setState(() {
                  _currentHotTvIndex = index;
                  _currentHotTvCount = _item['subject_count'];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: _currentHotTvIndex == index ? Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.black
                    )
                  ):null
                ),
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                padding: EdgeInsets.only(bottom: ScreenAdapter.width(10)),
                child: Text('${_item['short_name']}',style: TextStyle(color: _currentHotTvIndex == index ? Colors.black:Colors.grey,fontSize: ScreenAdapter.fontSize(30))),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: ScreenAdapter.height(20)),
        GridViewItems(
          data: _homeData[_currentHotTvIndex+4]['data']['subject_collection_boards'][0]['items'],
          itemCount:6,
          thumbHeight: 'large',
        )
      ],
    );
  }

  // 构建首页分类
  Widget _homeCategory(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:_homeData[0]['data']['subject_entraces'].map<Widget>((item){
        return GestureDetector(
          onTap: (){
            Application.router.navigateTo(context, '/doubanTop');
          },
          child: Column(
            children: <Widget>[
              Image.network(item['icon'],width: ScreenAdapter.width(90)),
              SizedBox(height: ScreenAdapter.height(20)),
              Text(item['title'])
            ],
          ),
        );
      }).toList(),
    );
  }



}