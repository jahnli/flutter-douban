import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BaseGrade extends StatelessWidget {

  double value;
  double charSize;
  String nullRatingReason;
  bool showText;

  BaseGrade({
    this.nullRatingReason = '',
    this.value = 0,
    this.charSize = 11,
    this.showText = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: nullRatingReason != '' ?  Container(
        alignment: Alignment.centerLeft,
        child: Text('$nullRatingReason',style: TextStyle(fontSize: charSize)),
      ):value == 0 ? Container(
        alignment: Alignment.centerLeft,
        child: Text('暂无评分',style: TextStyle(fontSize: charSize)),
      ):Row(
        children: <Widget>[
          RatingBarIndicator(
            rating:value / 2,
            unratedColor:Colors.grey,
            itemPadding: EdgeInsets.all(0),
            itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 12,
          ),
          showText ? Container(
            margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
            child: Text('$value',style: TextStyle(fontSize: 12,color: Colors.grey)),
          ):Container()
        ],
      )
    );
  }
}