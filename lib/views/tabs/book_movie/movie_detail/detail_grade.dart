import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailGrade extends StatefulWidget {
  final Map _movie;
  bool _isDark;
  DetailGrade(this._movie,this._isDark);
  @override
  _DetailGradeState createState() => _DetailGradeState();
}

class _DetailGradeState extends State<DetailGrade> {
  // 总评分数
  var _total;
  Color _baseTextColor;

  // 是否正在上映
  bool _isBeOn;

  @override
  void initState() { 
    super.initState();

    if(mounted){
      double tempNum = 0;
      for(var val in widget._movie['rating']['details'].keys){
        tempNum+=widget._movie['rating']['details'][val];
      }
      _baseTextColor = widget._isDark == true ? Colors.white:Colors.black;
      
      // 获取是否正在热映
      _isBeOn = widget._movie['pubdate'].isNotEmpty ? Utils.computeIsBeOn(widget._movie['pubdate']):false;

      setState(() {
        _total = tempNum.toInt();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
              _isBeOn ?  Icon(Icons.keyboard_arrow_right,color: _baseTextColor):Container()
            ],
          ),
          SizedBox(height: ScreenAdapter.height(10)),
          Container(
            padding: EdgeInsets.only(left: ScreenAdapter.width(55),right: ScreenAdapter.width(55)),
            child: Row(
              crossAxisAlignment: _isBeOn ? CrossAxisAlignment.start: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget._movie['rating']['stars'] == '00' ? Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(15),bottom: ScreenAdapter.height(15)),
                  child: Text('暂无评分',style: TextStyle(color:widget._isDark ? Colors.grey[400] :Colors.grey[600],fontSize: 12)),
                ): Column(
                  children: <Widget>[
                    Text('${widget._movie['rating']['average']}',style: TextStyle(fontSize: 30,color: _baseTextColor)),
                    _ratingBar(widget._movie['rating']['average'] / 2)
                  ],
                ),
                SizedBox(width: ScreenAdapter.width(20)),
                widget._movie['rating']['stars'] == '00'  ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Image.network('http://cdn.jahnli.cn/fire.png',width:17),
                    SizedBox(width: ScreenAdapter.width(8)),
                    Text('${widget._movie['wish_count']}人想看',style: TextStyle(color: _baseTextColor))
                  ],
                ):Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _ratingProgress(0,percent:widget._movie['rating']['details']['5']  / _total),
                      _ratingProgress(0,percent:widget._movie['rating']['details']['4']  / _total,count:4),
                      _ratingProgress(0,percent:widget._movie['rating']['details']['3']  / _total,count:3),
                      _ratingProgress(0,percent:widget._movie['rating']['details']['2']  / _total,count:2),
                      _ratingProgress(0,percent:widget._movie['rating']['details']['1']  / _total,count:1),
                      Container(
                        child:Text('$_total人评分',style: TextStyle(color:widget._isDark ? Colors.grey[400] :Colors.grey[600] ,fontSize: 10)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          widget._movie['rating']['stars'] == '00' ? Container():Column(
            children: <Widget>[
              Divider(color: Colors.grey[600]),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: ScreenAdapter.width(30)),
                child: Text('${_compute(widget._movie['collect_count'])}看过    ${_compute(widget._movie['wish_count'])}想看',style: TextStyle(color: widget._isDark ? Colors.grey[300] :Colors.grey[600],fontSize: 11)),
              )
            ],
          )
        ],
      ),
    );
  }
  // 人数计算
  _compute(count){
    return count > 10000 ? '${(count / 10000).toStringAsFixed(1)}万人':'$count人';
  }
  // 评分柱
  Widget _ratingProgress(double rating,{percent = 0,int count = 5}){
    return Row(
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
    );
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