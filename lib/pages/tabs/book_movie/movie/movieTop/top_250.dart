import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/weiget/top_list.dart';

class Top250 extends StatefulWidget {
  @override
  _Top250State createState() => _Top250State();
}

class _Top250State extends State<Top250> {

  // 豆瓣电影top250
  Map _top250;
  String _requestStatus = '';
  // 过滤top列表
  List _topList = ['1-50','51-100','101-150','151-200','201-250'];
  // 当前过滤条件索引
  int _currentFilter = 0;

  @override
  void initState() { 
    super.initState();
    _getTopList();
  }

  // 获取豆瓣电影Top250
  _getTopList()async{
    try {
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_top250/items?start=0&count=250&for_mobile=1', options: Options(
      headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _top250 = res.data; 
          _requestStatus = '获取豆瓣Top250成功';
        });
      }
    }
    catch (e) {
      print(e);
      if(mounted){
        setState(() {
          _requestStatus = '获取豆瓣Top250失败';
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return TopList(
      data:_top250,
      filterList: _topList,
      currentFilterCondition: _currentFilter,
      cb:(index)=> filterHandle(index),
      requestStatus: _requestStatus,
      filterDescChar: 'Top',
      footerFieldType:'desc'
    );
  }
  // 过滤操作
  filterHandle(index){
    setState(() {
      _currentFilter = index; 
    });
  }

}