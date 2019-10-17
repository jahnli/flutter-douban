import 'package:flutter/material.dart';
import 'package:flutter_douban/model/theatricalFimeList/theatricalFimeList.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';

class FilmRowItem extends StatefulWidget {

  Map data;
  int index;
  FilmRowItem(this.data,{this.index = 0});

  @override
  _FilmRowItemState createState() => _FilmRowItemState();
}

class _FilmRowItemState extends State<FilmRowItem> {

  theatricalFimeListModelSubjects _data;

  @override
  void initState() { 
    super.initState();
    _data = theatricalFimeListModelSubjects.fromJson(widget.data);
  }

  @override
  Widget build(BuildContext context) {
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
          Application.router.navigateTo(context, '/movieDetail?id=${_data.id}');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 缩略图
            _thumb(),
            SizedBox(width: ScreenAdapter.width(30)),
            // 中间信息区域
            _info(),
            SizedBox(width: ScreenAdapter.width(30)),
            // 右侧操作区域
            _actions()
          ],
        ),
      )
    );
  }

  // 左侧缩略图
  Widget _thumb(){
    return ClipRRect(
      child: Image.network('${_data.pic.normal}', height:ScreenAdapter.height(230),width: ScreenAdapter.width(160),fit: BoxFit.cover),
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
            minHeight: ScreenAdapter.height(240)
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                child: Text('${_data.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color:Colors.black)),
              ),
              BaseGrade(nullRatingReason: _data.nullRatingReason,value: _data.rating.value),
              Container(
                margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
                child: Text('${_data.cardSubtitle}',maxLines: 2,overflow: TextOverflow.ellipsis)
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
      height: ScreenAdapter.height(240),
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
          Text('${_data.wishCount}人看过',style: TextStyle(fontSize: 10,color: Colors.grey))
        ],
      )
    );
  }

}

