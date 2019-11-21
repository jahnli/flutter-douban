import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_forum_model.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FilmDetailForum extends StatefulWidget {

  final String movieId;
  final ScrollController bottomSheetController;
  final Function setForumTotal;
  FilmDetailForum({this.movieId,this.bottomSheetController,this.setForumTotal});

  @override
  _FilmDetailForumState createState() => _FilmDetailForumState();
}

class _FilmDetailForumState extends State<FilmDetailForum>  with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  // 评论内容
  FilmDetailForumModel _data;
  // 影评分页
  int _filmForumStart = 0;
  // 排序方式
  String _sort = 'time';
  RefreshController _refreshController = RefreshController();

  @override
  void initState() { 
    super.initState();
    _getFilmForum();
  }


  @override
  void dispose(){
    _refreshController.dispose();
    super.dispose();
  }

  _getFilmForum()async{
    try{
      Response res = await NetUtils.ajax('get','https://frodo.douban.com/api/v2/subject/${widget.movieId}/forum_topic/topics?start=$_filmForumStart&count=10&sort_by=$_sort&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=5440f7d1721c7ec5444c588d26ec3c6b26996bbd&_sig=HApqGiSWyuoJD%2FmeeL2pAWOQerE%3D&_ts=1571799819');

      if(mounted){
        if(_filmForumStart > 0){
          setState(() {
            _data.forumTopics.addAll(FilmDetailForumModel.fromJson(res.data).forumTopics);
          });
        }else{
          setState(() {
            _data = FilmDetailForumModel.fromJson(res.data); 
          });
        }
        widget.setForumTotal(_data.total);
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
        if(_filmForumStart + 10 < _data.total){
          if(mounted){
            setState(() {
              _filmForumStart = _filmForumStart + 10;
            });
            await _getFilmForum();
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
            child: Text('讨论列表',style: TextStyle(fontSize: 17)),
          ),
          _data != null ? _data.forumTopics.length > 0 ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: widget.bottomSheetController,
            itemBuilder: (context,index){
              return _item(_data.forumTopics[index]);
            },
            itemCount:_data.forumTopics.length,
          ):Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
            child: Text('还没有讨论',textAlign: TextAlign.center,style:TextStyle(fontSize:18,color: Colors.grey)),
          ):Container(
            margin: EdgeInsets.only(top:ScreenAdapter.height(40)),
            child: BaseLoading(),
          )
        ],
      ),
    );
  }

  Widget _item(FilmDetailForumModelForumTopics item){
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: ScreenAdapter.width(20),right: ScreenAdapter.width(40)),
            child: Column(
              children: <Widget>[
                Icon(Icons.chat_bubble,color: item.commentsCount > 0 ? Color.fromRGBO(250, 210, 136, 1):Colors.grey),
                item.commentsCount > 0 ? Text('${item.commentsCount}'):Container()
              ],
            ),
          ),
          Container(
            width: ScreenAdapter.getScreenWidth() - ScreenAdapter.width(135),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey
                )
              )
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('${item.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(20)),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network('${item.author.avatar}',width: ScreenAdapter.width(30)),
                      ),
                      SizedBox(width: ScreenAdapter.width(10)),
                      Text('${item.author.name}     ${Utils.timeLine(item.updateTime)}更新',style: TextStyle(color: Colors.grey)),
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}