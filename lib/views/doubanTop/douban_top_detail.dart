import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/views/doubanTop/douban_top_list_detail.dart';

String baseParams = '&udid=b176e8889c7eb022716e7c4195eceada4be0be40&rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&s=rexxar_new&channel=Douban&device_id=b176e8889c7eb022716e7c4195eceada4be0be40&os_rom=android&apple=f177f7210511568811cc414dd5ed6f50&icecream=7a77f8513a214ec8aaabf90e4ca99089&mooncake=3117c7243ba057a6c140fe27cee889a8&sugar=46000&loc_id=108288&_sig=GRYsUGyd89RDqLTQzMLqjISvmU8%3D&_ts=1572833298';

class DoubanTopDetail extends StatefulWidget {

  int index;
  int dataType;
  bool showFilter;
  
  //  1:默认日期  2:top筛选
  DoubanTopDetail({this.index,this.dataType = 1,this.showFilter = true});
  
  @override
  _DoubanTopDetailState createState() => _DoubanTopDetailState();
}

class _DoubanTopDetailState extends State<DoubanTopDetail> {

  // 数据
  Map _data;
  // 过滤条件
  List _filterList = [];
  int _currentFilter = 0; 

  // 定义请求url列表
  List<String> _urlList = [
    // 书影音 - 豆瓣榜单
    // 一周口碑
    'https://frodo.douban.com/api/v2/subject_collection/movie_weekly_best/items?start=0&count=20$baseParams',
    // top250
    'https://frodo.douban.com/api/v2/subject_collection/movie_top250/items?start=0&count=250$baseParams',
    // 一周热门电影
    'https://frodo.douban.com/api/v2/subject_collection/movie_hot_weekly/items?start=0&count=20$baseParams',
    // 豆瓣榜单 - 评分最高华语电影
    'https://frodo.douban.com/api/v2/subject_collection/2018_movie_1/items?start=0&count=20$baseParams',
  ];


  @override
  void initState() { 
    super.initState();
    print('${widget.index} ${widget.dataType}');
    _getData();
    // 如果不是top250 就请求筛选日期数据
    if(widget.dataType == 1){
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
    if(widget.dataType == 1){
      String updatedAt = '';
      updatedAt = _filterList.length > 0 ? '${DateTime.now().year}-${_filterList[_currentFilter]}':''; 
      url = url + '&updated_at=' + updatedAt;
    }
    try {
      Response res = await NetUtils.ajax('get',url);
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
      filterDescChar: widget.dataType == 1 ? '更新时间':'Top',
      footerFieldType:widget.dataType == 1 ? "evaluate":'desc',
      showFilter:widget.showFilter
    );
  }
  // 过滤操作
  filterHandle(index){
    setState(() {
      _currentFilter = index; 
    });
    if(widget.dataType == 1){
      _getData();
    }
  }






}
