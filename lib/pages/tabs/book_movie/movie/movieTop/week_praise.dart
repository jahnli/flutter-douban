import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/weiget/top_list.dart';
class WeekPraise extends StatefulWidget {
  @override
  _WeekPraiseState createState() => _WeekPraiseState();
}

class _WeekPraiseState extends State<WeekPraise> {
  // 一周口碑电影榜
  Map _weekPraise;
  String _requestStatus = '';
  // 过滤日期列表
  List _dateList = [];
  // 当前过滤条件索引
  int _currentFilterDate = 0;

  @override
  void initState() { 
    super.initState();
    _getWeekPraiseList();
    _getFillterDate();
  }

  // 获取一周口碑电影榜
  _getWeekPraiseList()async{
    try {
      String filterDate = _dateList.length > 0 ? '${DateTime.now().year}-${_dateList[_currentFilterDate]}':'';
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_weekly_best/items?start=0&count=20&for_mobile=1&updated_at=${filterDate}', options: Options(
      headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _weekPraise = res.data; 
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
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_weekly_best/dates?for_mobile=1', options: Options(
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
    return TopList(
      data:_weekPraise,
      filterList: _dateList,
      currentFilterCondition: _currentFilterDate,
      cb:(index)=> filterHandle(index),
      requestStatus: _requestStatus,
      filterDescChar:'更新时间',
      footerFieldType:'evaluate'
    );
  }
  // 过滤操作
  filterHandle(index){
    _currentFilterDate = index;
    _getWeekPraiseList();
  }

}