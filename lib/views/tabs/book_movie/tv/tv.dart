import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
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
        });
      }
      print(_homeData);
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
          _homeCategory()
        ],
      ),
    ):Center(
      child: BaseLoading(),
    );
  }

    // 构建首页分类
  Widget _homeCategory(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:_homeData[0]['data']['subjectEntraces'].map<Widget>((item){
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
  // 热播新剧
  Widget _hotPlayTv(){
    return Column(
      children: <Widget>[
        RowTitle(
          title: _homeData[1]['data']['title'],
          count: _homeData[4]['data']['subject_collection_boards'][0]['subject_collection']['subject_count'],
        ),
      ],
    );
  }


}