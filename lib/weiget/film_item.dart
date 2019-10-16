import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/movieShow.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';

class FilmItem extends StatefulWidget {

  Map item;
  int currentTabIndex;

  FilmItem(this.item,{this.currentTabIndex = 1});

  @override
  _FilmItemState createState() => _FilmItemState();
}

class _FilmItemState extends State<FilmItem> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieShowModelDataSubjectCollectionBoardsItems _item = MovieShowModelDataSubjectCollectionBoardsItems.fromJson(widget.item);
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '/movieDetail?id=${_item.id}&type=${widget.currentTabIndex}');
      },
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.network('${_item.cover.url}',
              width: double.infinity,
              height:ScreenAdapter.height(260),fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(5),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
              alignment: Alignment.centerLeft,
              child: Text('${_item.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            // 如果当前是影院热映，显示 Row 部件  否则显示Align部件
            // 如果当前是影院热映 电影未上映显示未上映字样，否则显示评分
            widget.currentTabIndex == 1  ? BaseGrade(nullRatingReason:_item.nullRatingReason,value:_item.rating?.value):Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                  child: Text('${_item.wishCount}人想看',style: TextStyle(fontSize: 12,color: Colors.grey)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(6)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1,color: Colors.pink),
                    ),
                    child: Text(dateFormat(_item.year,_item.releaseDate),style: TextStyle(fontSize: 10,color: Colors.pink)),
                  ),
                )
              ],
            )
          ],
        )
      )
    );
  } 
  // 日期格式化
  dateFormat(year,date){
    if(date == null){
      return '暂无日期';
    }
    date = date.replaceFirst('.','月');
    return '$date日';
  }

}