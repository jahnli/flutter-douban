import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/api/api_config.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailComment extends StatefulWidget {

  String movieId = '';
  ScrollController _bottomSheetController;
  // 更新父组件影评数据
  Function setMovieCommentCount;
  DetailComment(this.movieId,this._bottomSheetController,{this.setMovieCommentCount});

  @override
  _DetailCommentState createState() => _DetailCommentState();
}

class _DetailCommentState extends State<DetailComment> {
  RefreshController _refreshController = RefreshController();

    // 电影评论内容
  List _movieCommentList = [];
  
  // 影评分页
  int _movieCommentStart = 0;
  int _movieCommentTotal = 0;
  
  @override
  void initState() { 
    super.initState();
    _getDetailComment();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

 // 获取电影详情 - 评论
  _getDetailComment() async{
    try{
      Map<String,dynamic> params = {
        "apikey":ApiConfig.apiKey,
        "start":_movieCommentStart,
        "count":10
      };
      Response res = await ApiConfig.ajax('get', ApiConfig.baseUrl + '/v2/movie/subject/${widget.movieId}/reviews', params);
      if(mounted){
        setState(() {
          _movieCommentList.addAll(res.data['reviews']);  
          _movieCommentTotal = res.data['total'];  
          widget.setMovieCommentCount(res.data['total']);
        });
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown:false,
      footer: CustomScrollFooter(),
      onLoading: ()async{
        if(_movieCommentStart + 10 < _movieCommentTotal){
          if(mounted){
            setState(() {
             _movieCommentStart = _movieCommentStart + 10;
            });
            await _getDetailComment();
          }
          _refreshController.loadComplete();
        }else{
          _refreshController.loadNoData();
        }
      },
      child: ListView(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(246, 246, 246, 1),
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Text('影评列表',style: TextStyle(fontSize: 17)),
          ),
          _movieCommentList.length > 0 ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: widget._bottomSheetController,
            itemBuilder: (context,index){
              return _item(_movieCommentList[index]);
            },
            itemCount:_movieCommentList.length,
          ):Center(
            child: Text('还没有影评',style:TextStyle(fontSize:18,color: Colors.grey)),
          )
        ],
      ),
    );
  }
  // 单个
  Widget _item(_item){
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network('${_item['author']['avatar']}',width: 25),
                  ),
                  SizedBox(width: ScreenAdapter.width(10)),
                  Text('${_item['author']['name']}',style: TextStyle(color: Colors.grey,fontSize: 16)),
                  SizedBox(width: ScreenAdapter.width(10)),
                  _item['rating']['value'] != 0 ? Text('看过',style: TextStyle(color: Colors.grey,fontSize: 16)):Container(),
                  SizedBox(width: ScreenAdapter.width(10)),
                  _item['rating']['value'] != 0 ? RatingBarIndicator(
                    rating: _item['rating']['value'],
                    unratedColor:Colors.grey,
                    itemPadding: EdgeInsets.all(0),
                    itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 12,
                  ):Container(),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                alignment: Alignment.centerLeft,
                child: Text('${_item['title']}',style: TextStyle(fontSize: 22)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${_item['content']}',style: TextStyle(fontSize: 16,color: Colors.black87),maxLines: 3,overflow:TextOverflow.ellipsis),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
                child: Text('${_item['comments_count']}回复 · ${_item['useful_count']}有用',style: TextStyle(color: Colors.grey),),
              ),
            ],
          ),
        ),
        Container(
          height: ScreenAdapter.height(15),
          color: Color.fromRGBO(244, 244, 244, 1),
        )
      ],
    );
  }

}
