import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/views/doubanTop/douban_top_list_detail.dart';

class WeekHot extends StatefulWidget {
  @override
  _WeekHotState createState() => _WeekHotState();
}

class _WeekHotState extends State<WeekHot> {

   // 一周热门电影榜
  Map _weekHot;
  String _requestStatus = '';
  // 过滤日期列表
  List _dateList = [];
  // 当前过滤条件索引
  int _currentFilterDate = 0;

  @override
  void initState() { 
    super.initState();
    _getWeekHotList();
    _getFillterDate();
  }

  // 获取一周口碑电影榜
  _getWeekHotList()async{
    try {
      String filterDate = _dateList.length > 0 ? '${DateTime.now().year}-${_dateList[_currentFilterDate]}':'';
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_hot_weekly/items?start=0&count=20&for_mobile=1&updated_at=${filterDate}', options: Options(
      headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _weekHot = res.data; 
          _requestStatus = '获取豆瓣榜单详情页成功';
        });
      }
    }
    catch (e) {
      print(e);
      if(mounted){
        setState(() {
          _requestStatus = '获取豆瓣榜单详情页失败';
        });
      }
    }
  }
  // 获取筛选日期
  _getFillterDate()async{
    try {
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_hot_weekly/dates?for_mobile=1', options: Options(
      headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _dateList =res.data['data'].map((item)=>item.substring(5,10)).toList(); 
        });
      }
    }
    catch (e) {
      print(e);
    }
  }
  

  @override
  Widget build(BuildContext context) {
      return DoubanTopListDetail(
        data:_weekHot,
        filterList: _dateList,
        currentFilterCondition: _currentFilterDate,
        cb:(index)=> filterHandle(index),
        filterDescChar:'更新时间',
        footerFieldType:'evaluate'
      );
    }
    // 过滤操作
    filterHandle(index){
      _currentFilterDate = index;
      _getWeekHotList();
    }
}