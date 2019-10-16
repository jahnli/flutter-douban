import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/movieShow.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';

class FilmItem extends StatelessWidget {

  Map item;
  int currentTabIndex;
  
  FilmItem({@required item,this.currentTabIndex = 1});

  @override
  Widget build(BuildContext context) {
    MovieShowModelDataSubjectCollectionBoardsItems _item= MovieShowModelDataSubjectCollectionBoardsItems.fromJson(item);
    print(_item);
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '/movieDetail?id=${_item.id}&type=$currentTabIndex');
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
            currentTabIndex == 1 ? Text('尚未上映') :Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(ScreenAdapter.width(6)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 1,color: Colors.pink),
                ),
                child: Text('${_item.releaseDate}',style: TextStyle(fontSize: 10,color: Colors.pink)),
              ),
            )
          ],
        ),
      ),
    );
  }
}