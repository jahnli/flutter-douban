import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/weiget/common_film_list.dart';

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
        });
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  CommonFilmList(
      dataList: _isHotList,
      onRefresh: ()=> _onRefresh(),
      onLoading:()=>_onLoading(),
      thumbHeight:'small'
    );
  }
  // 刷新
  _onRefresh(){
    setState(() {
      _start = 0;
    });
    _getIsHot();
  }
  // 加载
  _onLoading() async{
    if(_start + 10 < _total){  
      setState(() {
        _start = _start + 10;
      });
      await _getIsHot();
      return 'ok';
    }else{
      return 'end';
    }
  }


}