import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/common_film_list.dart';
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
      Map<String,dynamic> params ={
        'start':_start
      };

      Response res = await NetUtils.ajax('get', ApiPath.home['doubanHot'],params: params);

      if(mounted){
        setState(() {
          _hotList.addAll(res.data['subject_collection_items']);
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
        elevation: 0,
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
      body: Container(
        margin: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
        child: CommonFilmList(
          dataType:2,
          dataList: _hotList,
          onLoading:()=>_onLoading(),
          enablePullDown: false,
          headWidget:Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(30)),
            child: Text('影视 500'),
          ),
        ),
      )
    );
  }

  // 加载
  _onLoading() async {
    if(_start + 10 < _total){
      setState(() {
        _start = _start + 10;
      });
      await _getDouBanHot();
      return 'ok';
    }else{
      return 'end';
    }
  }


}