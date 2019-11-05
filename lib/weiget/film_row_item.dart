import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/movieShow.dart';
import 'package:flutter_douban/model/theatricalFimeList/theatricalFimeList.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';

class FilmRowItem extends StatefulWidget {

  Map data;
  int index;
  int dataType;
  String thumbHeight;
  FilmRowItem(this.data,{this.index = 0,this.dataType = 1,this.thumbHeight = 'default'});

  @override
  _FilmRowItemState createState() => _FilmRowItemState();
}

class _FilmRowItemState extends State<FilmRowItem> {

  var _data;

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _data = widget.dataType == 1 ? _data = TheatricalFimeListModelSubjects.fromJson(widget.data) :MovieShowModelDataSubjectCollectionBoardsItems.fromJson(widget.data);
    return Container(
      margin: EdgeInsets.only(top:widget.index == 0 ? ScreenAdapter.height(40):ScreenAdapter.height(20)),
      padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey[300],
          )
        )
      ),
      child: GestureDetector(
        onTap: (){
          Application.router.navigateTo(context, '/filmDetail?id=${_data.id}');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 缩略图
            _thumb(),
            SizedBox(width: ScreenAdapter.width(30)),
            // 中间信息区域
            _info(),
             _data.type != 'ark_column' ? SizedBox(width: ScreenAdapter.width(30)):Container(),
            // 右侧操作区域
            _data.type != 'ark_column' ? _actions():Container()
          ],
        ),
      )
    );
  }

  // 左侧缩略图
  Widget _thumb(){
    return ClipRRect(
      child: Image.network('${ widget.dataType == 1 ? _data.pic.normal:_data.cover.url}',height:ScreenAdapter.height(Configs.thumbHeight(size: widget.thumbHeight)),width: ScreenAdapter.width(170),fit: BoxFit.fill),
      borderRadius: BorderRadius.circular(5),
    );
  }

  // 中间信息区域
  Widget _info(){
    return Expanded(
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 13,color: Colors.grey),
        child: Container(
          constraints: BoxConstraints(
            minHeight: ScreenAdapter.height(Configs.thumbHeight(size: widget.thumbHeight))
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                child: Text('${_data.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color:Colors.black)),
              ),
              // 如果不是小说类目
              _data.type != 'ark_column' ? Column(
                children: <Widget>[
                  BaseGrade(nullRatingReason: _data.nullRatingReason ?? '',value: _data.rating.value),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text('${_data.cardSubtitle }',maxLines: 2,overflow: TextOverflow.ellipsis)
                  )
                ],
              ):Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                    alignment: Alignment.centerLeft,
                    child: Text('作者：${_data.author.first}',style: TextStyle(fontSize: 18,color: Colors.black),maxLines: 2,overflow: TextOverflow.ellipsis)
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                    child: Text('${_data.abstracts}',style: TextStyle(fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${_data.readCount} 阅读'),
                      Container(
                        padding: EdgeInsets.fromLTRB(ScreenAdapter.width(8),ScreenAdapter.width(3),ScreenAdapter.width(8),ScreenAdapter.width(3)),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text('${_data.tag.first}'),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  // 右侧操作区域
  Widget _actions(){
    return Container(
      height: ScreenAdapter.height(Configs.thumbHeight(size: widget.thumbHeight)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30),top: ScreenAdapter.width(8),bottom: ScreenAdapter.width(8)),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,color: Colors.pink
                ),
                borderRadius: BorderRadius.circular(3)
              ),
              child: Text('购票',style: TextStyle(fontSize: 13,color: Colors.pink)),
            ),
          ),
          SizedBox(height: ScreenAdapter.height(10)),
          widget.dataType == 1 ? Text('${_data.wishCount}人看过',style: TextStyle(fontSize: 10,color: Colors.grey)):Container()
        ],
      )
    );
  }

}

