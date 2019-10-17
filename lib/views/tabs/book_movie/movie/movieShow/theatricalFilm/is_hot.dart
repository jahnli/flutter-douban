import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_douban/weiget/custom_scroll_header.dart';
import 'package:flutter_douban/weiget/film_row_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IsHot extends StatefulWidget {
  @override
  _IsHotState createState() => _IsHotState();
}

class _IsHotState extends State<IsHot> with SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin{

  // 保持状态
  bool get wantKeepAlive => true;

  // 正在热映列表
  List _isHotList = [];
  // 分页
  int _start = 0;
  // 总数量
  int _total = 0;

  String _requestStatus = '';

  RefreshController _controller = RefreshController();


  @override
  void initState() { 
    super.initState();
    _getIsHot();
  }

  // 获取正在热映列表数据
  _getIsHot() async {
    try {
      Map<String,dynamic> params ={
        'start':_start
      };
      Response res = await NetUtils.ajax('get', ApiPath.home['movieIsHot'],params: params);
      if(mounted){
        setState(() {
          if(_start == 0 ){
            _isHotList = []; 
          }
          _isHotList.addAll(res.data['subjects']);
          _total = res.data['total'];
          _requestStatus = '获取热映数据成功';
        });
      }
    }
    catch (e) {
      print(e);
      setState(() {
          _requestStatus = '获取热映数据失败';
      });
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SmartRefresher(
      controller: _controller,
      enablePullUp: true,
      enablePullDown: true,
      header: CustomScrollHeader(),
      footer: CustomScrollFooter(),
      onRefresh: () async {
        _controller.resetNoData();
        setState(() {
          _start = 0;
        });
        await _getIsHot();
        _controller.refreshCompleted();
      },
      onLoading: () async {
        if(_start + 10 < _total){
          setState(() {
            _start = _start + 10;
          });
          await _getIsHot();
          _controller.loadComplete();
        }else{
          _controller.loadNoData();
        }
      },
      child: _isHotList.length > 0 ? ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context,index){
          return FilmRowItem(_isHotList[index]);
        },
        itemCount: _isHotList.length,
      ):BaseLoading(type: _requestStatus),
    );
  }
}