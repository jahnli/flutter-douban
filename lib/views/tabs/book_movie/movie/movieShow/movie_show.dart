import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/grid_view.dart';

class MovieShow extends StatefulWidget {

  Map movieShowData;
  Map movieSoonData;

  MovieShow(this.movieShowData,this.movieSoonData);

  @override
  _MovieShowState createState() => _MovieShowState();
}

class _MovieShowState extends State<MovieShow> {

  
  // 当前热映列表
  // 热映列表：1，即将上映2
  int _currentType = 1;
  Map _movieShowData;
  Map _movieSoonData;

  @override
  void initState() { 
    super.initState();
    _movieShowData = widget.movieShowData['data']['subject_collection_boards'][0];
    _movieSoonData = widget.movieSoonData['data']['subject_collection_boards'][0];
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap:true,   
      physics: NeverScrollableScrollPhysics(),  
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                _titleToggle('影院热映',1),
                SizedBox(width: ScreenAdapter.width(20)),
                _titleToggle('即将上映',2)
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Application.router.navigateTo(context,'/theatricalFilm?index=${_currentType - 1}');
                  },
                  child: Text('全部 ${_currentType == 1 ? _movieShowData['subject_collection']['subject_count']:_movieSoonData['subject_collection']['subject_count']}',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.w600)),
                ),
                Icon(Icons.chevron_right)
              ],
            )
          ],
        ),
        SizedBox(height: ScreenAdapter.height(30)),
        _currentType == 1 ? _movieShow(_movieShowData['items']) : _movieShow(_movieSoonData['items'])
      ],
    ); 
  }
  // 热映
  Widget _movieShow(data){
    return GridViewItems(
      data:data ,
      height: _currentType == 1 ? 380:420,
      itemCount:6,
      currentType:_currentType,
      thumbHeight: 'large',
    );
  }

  // 标题切换
  Widget _titleToggle(title,index){
    return Container(
      padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
        decoration: BoxDecoration(
        border: _currentType == index ? Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1
          )
        ):null
      ),
      child: GestureDetector(
        onTap: (){
          setState(() {
            _currentType = index;
          });
        },
        child: AnimatedDefaultTextStyle(
          duration: Duration(seconds: 1),
          style: TextStyle(color: _currentType == index ? Colors.black:Colors.grey),
          child: Text('$title',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}