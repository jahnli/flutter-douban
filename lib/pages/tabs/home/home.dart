import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() { 
    super.initState();
_getData();
  }

  _getData()async{
    var res = await Dio().get('https://m.douban.com/rexxar/api/v2/subject_collection/movie_love/items?os=ios&for_mobile=1&callback=jsonp1&start=0&count=18&loc_id=0&_=1571041012653', options: Options(
      headers: {
        HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
      },
    ));
  }

  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('x');
  }
}