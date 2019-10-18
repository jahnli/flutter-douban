import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/views/doubanTop/douban_top_list_detail.dart';


class MovieTopDetail extends StatefulWidget {

  int index;
  MovieTopDetail(this.index);
  
  @override
  _MovieTopDetailState createState() => _MovieTopDetailState();
}

class _MovieTopDetailState extends State<MovieTopDetail> {

  // 数据
  Map _data;
  // 过滤条件
  List _filterList = [];
  int _currentFilter = 0; 
  // 定义请求url列表
  List<String> _urlList = [
    'https://m.douban.com/rexxar/api/v2/subject_collection/movie_weekly_best/items?start=0&count=20&for_mobile=1',
    'https://m.douban.com/rexxar/api/v2/subject_collection/movie_top250/items?start=0&count=250&for_mobile=1',
    'https://m.douban.com/rexxar/api/v2/subject_collection/movie_hot_weekly/items?start=0&count=20&for_mobile=1'
  ];

  // 定义显示
  List<String> _filterDescCharList = ['更新时间','Top','更新时间'];
  List<String> _footerFieldTypeList = [ 'evaluate','desc','evaluate'];

  @override
  void initState() { 
    super.initState();
    
    _getData();
    // 如果不是top250 就请求筛选日期数据
    if(widget.index != 1){
      _getFillterDate();
    }else{
      setState(() {
         _filterList = ['1-50','51-100','101-150','151-200','201-250'];
      });
    }
  }
  // 获取数据
  _getData()async{
    String url = _urlList[widget.index];
    if(widget.index != 1){
      String updatedAt = '';
      updatedAt = _filterList.length > 0 ? '${DateTime.now().year}-${_filterList[_currentFilter]}':''; 
      url = url + '&updated_at=' + updatedAt;
    }
    try {
      Response res = await Dio().get(url, options: Options(
      headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _data = res.data; 
        });
      }
    }
    catch (e) {
      print(e);
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
          _filterList =res.data['data'].map((item)=>item.substring(5,10)).toList(); 
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
      data:_data,
      filterList: _filterList,
      currentFilterCondition: _currentFilter,
      cb:(index)=> filterHandle(index),
      filterDescChar: _filterDescCharList[widget.index],
      footerFieldType:_footerFieldTypeList[widget.index]
    );
  }
  // 过滤操作
  filterHandle(index){
    setState(() {
      _currentFilter = index; 
    });
    if(widget.index != 1){
      _getData();
    }
  }






}
