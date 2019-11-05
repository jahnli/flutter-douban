import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_bottom_comment.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class FilmDetailComment extends StatefulWidget {

  String movieId = '';
  ScrollController bottomSheetController;
  FilmDetailComment({this.movieId,this.bottomSheetController});

  @override
  _FilmDetailCommentState createState() => _FilmDetailCommentState();
}

class _FilmDetailCommentState extends State<FilmDetailComment>{

  // 评论内容
  FilmDetailBottomCommentModel _data;
  // 影评分页
  int _filmCommentStart = 0;
  // 排序方式
  String _sort = 'hot';
  RefreshController _refreshController = RefreshController();

  @override
  void initState() { 
    super.initState();
    _getFilmComment();
  }


  _getFilmComment()async{
    try{
      Response res = await NetUtils.ajax('get','https://frodo.douban.com/api/v2/movie/${widget.movieId}/reviews?rtype=review&count=10&version=0&start=$_filmCommentStart&order_by=$_sort&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=5440f7d1721c7ec5444c588d26ec3c6b26996bbd&_sig=dBXQ2ywjcuzRQ7p1xbBVzpeahNk%3D&_ts=1571750670');

      if(mounted){
        if(_filmCommentStart > 0){
          setState(() {
            _data.reviews.addAll(FilmDetailBottomCommentModel.fromJson(res.data).reviews);
          });
        }else{
          setState(() {
            _data = FilmDetailBottomCommentModel.fromJson(res.data); 
          });
        }
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
        if(_filmCommentStart + 10 < _data.total){
          if(mounted){
            setState(() {
              _filmCommentStart = _filmCommentStart + 10;
            });
            await _getFilmComment();
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
          _data != null ? _data.reviews.length > 0 ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: widget.bottomSheetController,
            itemBuilder: (context,index){
              return _item(_data.reviews[index]);
            },
            itemCount:_data.reviews.length,
          ):Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
            child: Text('还没有影评',textAlign: TextAlign.center,style:TextStyle(fontSize:18,color: Colors.grey)),
          ):Container(
            margin: EdgeInsets.only(top:ScreenAdapter.height(40)),
            child: BaseLoading(),
          )
        ],
      ),
    );
  }

  // 单个
  Widget _item(FilmDetailBottomCommentModelReviews item){
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network('${item.user.avatar}',width: 25),
                  ),
                  SizedBox(width: ScreenAdapter.width(10)),
                  Text('${item.user.name}',style: TextStyle(color: Colors.grey,fontSize: 16)),
                  SizedBox(width: ScreenAdapter.width(10)),
                  item.rating != null ? Text('看过',style: TextStyle(color: Colors.grey,fontSize: 16)):Container(),
                  SizedBox(width: ScreenAdapter.width(10)),
                  item.rating != null ? BaseGrade(
                    value: double.parse(item.rating.value.toString()),
                    showText: false,
                  ):Container(),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                alignment: Alignment.centerLeft,
                child: Text('${item.title}',style: TextStyle(fontSize: 22)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${item.theAbstract}',style: TextStyle(fontSize: 16,color: Colors.black87),maxLines: 3,overflow:TextOverflow.ellipsis),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
                child: Text('${item.commentsCount}回复 · ${item.usefulCount}有用  · ${item.timelineShareCount}转发',style: TextStyle(color: Colors.grey),),
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