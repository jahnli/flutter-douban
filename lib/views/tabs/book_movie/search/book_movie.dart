import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/search_last_result_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/weiget/search/search_row.item.dart';

class SearchBookMovie extends StatefulWidget {

  String keyWords = '';
  SearchBookMovie({@required this.keyWords});

  @override
  _SearchBookMovieState createState() => _SearchBookMovieState();
}

class _SearchBookMovieState extends State<SearchBookMovie> {
  
  Map _result;

  @override
  void initState() { 
    super.initState();
    _getResult();
  }

  _getResult()async{
    try {
      Response res = await NetUtils.ajax('get',ApiPath.home['bookMovieSearchLastResult'] + '&q=${widget.keyWords}');
      if(mounted){
        setState(() {
          _result = res.data; 
        });
      }
    } 
    catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _movie()
        ],
      ),
    );
  }

  Widget _movie(){
    return ListView.builder(
      itemBuilder: (context,index){
        return SearchRowItem(data: _result['subjects']['item'][index],);
      },
      itemCount: _result['subjects'].length,
    );
  }



}