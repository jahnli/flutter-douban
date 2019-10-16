import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/movieShow.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/film_item.dart';

class MovieShow extends StatefulWidget {
  var movieShowData;
  var movieSoonData;

  MovieShow({@required this.movieShowData,@required movieSoonData});

  @override
  _MovieShowState createState() => _MovieShowState();
}

class _MovieShowState extends State<MovieShow> {

  
  // 当前热映列表
  // 热映列表：1，即将上映2
  int _currentTabIndex = 1;
    var res ;

  @override
  void initState() { 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _movieShow(widget.movieShowData['data']['subject_collection_boards'][0]['items']) ;
  }

    // 热映
  Widget _movieShow(data){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
        crossAxisCount: 3,
        //纵轴间距
        //横轴间距
        crossAxisSpacing: 10.0,
        //子组件宽高长度比例
        childAspectRatio: ScreenAdapter.getScreenWidth() / 3 /  ScreenAdapter.height(420)
      ),
      itemBuilder: (BuildContext context, int index) {
        return FilmItem(item: data[index],currentTabIndex: _currentTabIndex);
      }
    );
  }
}