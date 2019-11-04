import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_grade_model.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class FilmDetailGrade extends StatefulWidget {

  String movieId;
  bool isDark;
  String nullRatingReason;
  int rating;
  int rateCount;

  FilmDetailGrade({this.isDark,this.movieId,this.nullRatingReason,this.rating,this.rateCount});

  @override
  _FilmDetailGradeState createState() => _FilmDetailGradeState();
}

class _FilmDetailGradeState extends State<FilmDetailGrade> {

  FilmDetailGradeModel _data;
  Color _baseTextColor;

  @override
  void initState() { 
    super.initState();
    _getGrade();
    _baseTextColor = widget.isDark == true ? Colors.white:Colors.black;
  }
  // 获取评分
  _getGrade()async{
    Response res = await NetUtils.ajax('get', 'https://frodo.douban.com/api/v2/movie/${widget.movieId}/rating?os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=baidu_applink&udid=9598a52e9e94ae464e8164e2db153c4bc83045b4&_sig=4or07CQCsyShiIXJglxSiyVQuq0%3D&_ts=1571639358');
    if(mounted){
      setState(() {
        _data = FilmDetailGradeModel.fromJson(res.data); 
        _baseTextColor = widget.isDark ? Colors.white:Colors.black;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _data != null ? Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Color.fromRGBO(0, 0, 0, 0.1)
      ),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('豆瓣评分',style: TextStyle(color: _baseTextColor)),
              widget.nullRatingReason.isEmpty ?  Icon(Icons.keyboard_arrow_right,color: _baseTextColor):Container()
            ],
          ),
          SizedBox(height: ScreenAdapter.height(10)),
          Container(
            padding: EdgeInsets.only(left: ScreenAdapter.width(55),right: ScreenAdapter.width(55)),
            child: Row(
              crossAxisAlignment: widget.nullRatingReason.isNotEmpty ? CrossAxisAlignment.start: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.nullRatingReason.isEmpty ? Column(
                  children: <Widget>[
                    Text('${double.parse(widget.rating.toString())}',style: TextStyle(fontSize: 30,color: _baseTextColor)),
                    _ratingBar(widget.rating / 2),
                  ],
                ):Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(15),bottom: ScreenAdapter.height(15)),
                  child: Text('${widget.nullRatingReason}',style: TextStyle(color:widget.isDark ? Colors.grey[400] :Colors.grey[600],fontSize: 12)),
                ),
                SizedBox(width: ScreenAdapter.width(20)),
                widget.nullRatingReason.isNotEmpty  ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image.network('http://cdn.jahnli.cn/fire.png',width:17),
                    SizedBox(width: ScreenAdapter.width(8)),
                    Text('${_data.wishCount}人想看',style: TextStyle(color: _baseTextColor))
                  ],
                ):Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _ratingProgress(0,percent:_data.stats[4]),
                      _ratingProgress(0,percent:_data.stats[3],count:4),
                      _ratingProgress(0,percent:_data.stats[2],count:3),
                      _ratingProgress(0,percent:_data.stats[1],count:2),
                      _ratingProgress(0,percent:_data.stats[0],count:1),
                      Container(
                        margin: EdgeInsets.only(top: ScreenAdapter.height(5)),
                        child:Text('${_compute(widget.rateCount)}评分',style: TextStyle(color:widget.isDark ? Colors.grey[400] :Colors.grey[600] ,fontSize: 10)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          widget.nullRatingReason.isEmpty ? Column(
            children: <Widget>[
              Divider(color: Colors.grey[600]),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: ScreenAdapter.width(30)),
                child: Text('${_compute(_data.doneCount)}看过   ${_compute(_data.wishCount)}想看',style: TextStyle(color: widget.isDark ? Colors.grey[300] :Colors.grey[600],fontSize: 11)),
              )
            ],
          ):Container()
        ],
      ),
    ):Container();
  }


  // 评分柱
  Widget _ratingProgress(double rating,{percent = 0,int count = 5}){
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(5)),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: ScreenAdapter.width(15)),
            width: ScreenAdapter.width(100),
            child: _ratingBar(rating,count,9)
          ),
          Stack(
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(280),
                height: ScreenAdapter.height(12),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(73, 97, 116, 0.5),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              Container(
                width: ScreenAdapter.width(280  * (percent > 0.02 ? percent:0.02)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber,
                ),
                height: ScreenAdapter.height(12),
              )
            ],
          ),
        ],
      ),
    );
  }
  // 人数计算
  _compute(count){
    return count > 10000 ? '${(count / 10000).toStringAsFixed(1)}万人':'$count人';
  }
  // 评分栏
  Widget _ratingBar(double rating,[int count = 5,double size = 11]){
    return RatingBarIndicator(
      rating:rating,
      unratedColor:Colors.grey,
      itemPadding: EdgeInsets.all(0),
      itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
      ),
      itemCount: count,
      itemSize: size,
    );
  }

}