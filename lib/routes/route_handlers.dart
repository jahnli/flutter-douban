import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/views/doubanTop/douban_top_detail.dart';
import 'package:flutter_douban/views/doubanTop/douban_top_tabs.dart';
import 'package:flutter_douban/views/doubanTop/douban_year_top.dart';
import 'package:flutter_douban/views/filmDetail/film_detail.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieHotDetail/movie_hot_detail.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieShow/theatricalFilm/theatrical_film.dart';
import 'package:flutter_douban/views/tabs/tabs.dart';

// 配置清单路由
// tabs
Handler tabHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Tabs();
});


// 院线电影页
Handler theatricalFilmHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    int index = int.parse( params['index']?.first);
  return TheatricalFilm(index:index);
});

// 豆瓣热门详情页
Handler movieHotDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MovieHotDetail();
});

// 豆瓣榜单详情页
Handler doubanTopDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List> params) {
  String id = params['id']?.first;
  int dataType = params['dataType'] != null ? int.parse(params['dataType']?.first) : 1;
  // 默认为true， 显示筛选
  bool showFilter = params['showFilter'] != null ? false:true;
  return DoubanTopDetail(id,dataType: dataType,showFilter: showFilter);
});

// 豆瓣榜单全部页
Handler doubanTopHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DoubanTopTabs();
});


// 影片详情页
Handler filmDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String movieId = params['id']?.first;
  return FilmDetail(movieId: movieId);
});

// 豆瓣榜单 - 年度榜单
Handler doubanYearTopHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DoubanYearTop();
});
