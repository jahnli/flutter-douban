import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_forum_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/base_loading.dart';

class FilmDetailGroupForum extends StatefulWidget {

  final ScrollController bottomSheetController;
  final String movieId;
  FilmDetailGroupForum({this.bottomSheetController,this.movieId});

  @override
  _FilmDetailGroupForumState createState() => _FilmDetailGroupForumState();
}

class _FilmDetailGroupForumState extends State<FilmDetailGroupForum> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  // 小组讨论内容
  Map _data;

  @override
  void initState() { 
    super.initState();
    _getFilmForum();
  }

  _getFilmForum()async{
    try{
      Response res = await NetUtils.ajax('get','${ApiPath.home['baseUrl']}/group/groups_by_subject?subject_id=${widget.movieId}&${ApiPath.home['baseParams']}');

      if(mounted){
        setState(() {
          _data = res.data['groups'][0];
        });
        // widget.setForumTotal(_data.total);
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _data != null ? Container(
      padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
      child: ListView(
        children: <Widget>[
          _group(),
          ListView.builder(
            controller: widget.bottomSheetController,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return _item(FilmDetailForumModelForumTopics.fromJson(_data['topics'][index]));
            },
            itemCount: _data['topics'].length,
          ),
          RaisedButton(
            color: Color.fromRGBO(235, 235, 235, 1),
            onPressed: (){

            },
            child: Text('更多讨论'),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
          ),
          SizedBox(height:ScreenAdapter.height(30))
        ],
      )
    ):Center(
      child: BaseLoading(),
    );
  }
  // 单个
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
          Expanded(
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
  // 小组名称
  Widget _group(){
    return Container(
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: Image.network('${_data['group']['avatar']}',width: ScreenAdapter.width(Configs.thumbHeight(size:'miniWidth')),height:ScreenAdapter.height(Configs.thumbHeight(size: 'miniWidth')),fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(5),
          ),
          SizedBox(width: ScreenAdapter.width(20)),
          Expanded(
            child: Container(
              height:ScreenAdapter.height(Configs.thumbHeight(size: 'miniWidth')),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${_data['group']['name']}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                  SizedBox(height: ScreenAdapter.height(5)),
                  Text('${_data['group']['member_count']}个成员',style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Utils.baseToast('因接口受限，暂无开发计划。');
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30), ScreenAdapter.height(8), ScreenAdapter.width(30), ScreenAdapter.height(8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: Color.fromRGBO(0, 119, 34, 1)
                )
              ),
              child: Text('加入小组',style:TextStyle(color: Color.fromRGBO(0, 119, 34, 1))),
            ),
          )
        ],
      ),
    );
  }

}