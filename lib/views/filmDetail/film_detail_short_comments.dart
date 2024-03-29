import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_short_comments_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/base_grade.dart';

class FilmDetailShortComments extends StatefulWidget {

  final String movieId;
  final String type;
  final bool isDark;

  FilmDetailShortComments({this.type,this.movieId,this.isDark});

  @override
  _FilmDetailShortCommentsState createState() => _FilmDetailShortCommentsState();
}

class _FilmDetailShortCommentsState extends State<FilmDetailShortComments> {

  FilmDetailShortCommentsModel _data;
  Color _baseTextColor;

  @override
  void initState() { 
    super.initState();
    _baseTextColor = widget.isDark == true ? Colors.white:Colors.black;
    _getShortComments();
  }

  _getShortComments()async{
    try{
      Response res = await NetUtils.ajax('get', '${ApiPath.home['baseUrl']}/${widget.type}/${widget.movieId}/hot_interests?${ApiPath.home['baseParams']}');
      if(mounted){
        setState(() {
          _data = FilmDetailShortCommentsModel.fromJson(res.data); 
        });
        _data.interests.forEach((item){
          item.showMore = 6;
        });
      }
    }
    catch(e){
      print(e);
    }
  }

  // 显示提醒
  _showHelp(){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(
            margin: EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text('短评'),
          ),
          content: Text('''短评区仅展示部分短评，由算法根据时间、热度等因素进行筛选，并随机展示。
影片上映之前的、与影片无关的或包含人身攻击等内容的短评将被折叠，且评分不计入豆瓣评分。
          ''',textAlign: TextAlign.left),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('我知道了',style: TextStyle(color: Color.fromRGBO(65, 172, 82, 1))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _data != null ? Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('短评',style: TextStyle(fontSize: 20)),
                  SizedBox(width: ScreenAdapter.width(10)),
                  GestureDetector(
                    onTap: _showHelp,
                    child: Icon(Icons.help_outline,size:18),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('全部短评 ${_data.total}',style: TextStyle(color: Colors.grey)),
                  Icon(Icons.keyboard_arrow_right,color: Colors.grey,)
                ],
              )
            ],
          ),
          ListView.builder(
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return _commentItem(_data.interests[index]);
            },
            itemCount: _data.interests.length,
          ),
          SizedBox(height: ScreenAdapter.height(20)),
          _data.interests.length > 0 ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('查看全部短评',style: TextStyle(color: _baseTextColor,fontSize: 20)),
                Icon(Icons.keyboard_arrow_right,color:_baseTextColor,size: 26)
              ],
            ),
          ):Center(
            child: Text('暂无短评'),
          )
        ],
      ),
    ):Container();
  }

  
 // 单个短评
  Widget _commentItem(FilmDetailShortCommentsModelInterests item){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color.fromRGBO(0, 0, 0, 0.1)
          )
        )
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ClipOval(
                      child: Image.network('${item.user.avatar}',width: ScreenAdapter.width(60),fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('${item.user.name}',style: TextStyle(fontSize: 14,color: _baseTextColor)),
                      ),
                      Row(
                        children: <Widget>[
                          item.rating != null ? Row(
                            children: <Widget>[
                              BaseGrade(value: double.parse(item.rating.value.toString()),showText: false),
                              SizedBox(width: ScreenAdapter.width(20)),
                            ],
                          ):Container(),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('${Utils.timeLine(item.createTime)}',style: TextStyle(color: widget.isDark ? Colors.white54:Colors.grey[600]))
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_horiz,color:widget.isDark ?Colors.white54:Colors.grey[600]),
                onPressed: (){
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context){
                      return CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: Text('分享'),
                            onPressed: () { /** */ },
                          ),
                          CupertinoActionSheetAction(
                            child: Text('举报'),
                            onPressed: () { /** */ },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDefaultAction: true,
                          child: Text('取消'),
                          onPressed: () { /** */ },
                        ),
                      );
                    }
                  );
                },
              )
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('${item.comment}',style: TextStyle(fontSize: 16,color: _baseTextColor),maxLines: item.showMore,overflow: TextOverflow.ellipsis),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20),top: ScreenAdapter.height(10)),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  item.showMore = item.showMore == 6 ? 15:6;
                });
              },
              child: Text('${item.showMore == 6 ? '展开':'收起'}',style: TextStyle(color:Colors.grey,fontSize: 14)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
            child: Row(
              children: <Widget>[
                Icon(Icons.thumb_up,color: _baseTextColor,size: 15,),
                SizedBox(width: ScreenAdapter.width(20)),
                Text('${item.voteCount ?? 0}',style: TextStyle(color: _baseTextColor))
              ],
            ),
          )
        ],
      ),
    );
  }


}