import 'package:flutter/material.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieShow/theatricalFilm/coming_soon.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieShow/theatricalFilm/is_hot.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieShow/theatricalFilm/movie_guide.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class TheatricalFilm extends StatefulWidget {
  final int index;
  TheatricalFilm({this.index = 0});
  @override
  _TheatricalFilmState createState() => _TheatricalFilmState();
}

class _TheatricalFilmState extends State<TheatricalFilm> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex:widget.index,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation:0 ,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          textTheme: TextTheme(
            title:TextStyle(color: Colors.black)
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          centerTitle: true,
          title: Text('院线电影',style: TextStyle(fontSize: 20)),
          bottom: TabBar(
            labelColor:Colors.black,
            labelStyle:TextStyle(fontSize: 18),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.black45,
            tabs: <Widget>[
              Tab(text: '正在热映'),
              Tab(text: '即将上映'),
              Tab(text: '${DateTime.now().month}月观影指南'),
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30)),
                child:IsHot(),
              ),
              ComingSoon(),
              MovieGuide()
            ],
          ),
        ),
      ),
    );
  }
}