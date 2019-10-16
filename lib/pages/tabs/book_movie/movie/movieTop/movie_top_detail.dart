import 'package:flutter/material.dart';
import 'package:flutter_douban/pages/tabs/book_movie/movie/movieTop/top_250.dart';
import 'package:flutter_douban/pages/tabs/book_movie/movie/movieTop/week_hot.dart';
import 'package:flutter_douban/pages/tabs/book_movie/movie/movieTop/week_praise.dart';


class MovieTopDetail extends StatefulWidget {

  final int index;
  MovieTopDetail(this.index);
  
  @override
  _MovieTopDetailState createState() => _MovieTopDetailState();
}

class _MovieTopDetailState extends State<MovieTopDetail> {

  List<Widget> _widgetList = [
    WeekPraise(),
    Top250(),
    WeekHot(),
  ];

  @override
  Widget build(BuildContext context) {
    return _widgetList[widget.index];
  }
}
