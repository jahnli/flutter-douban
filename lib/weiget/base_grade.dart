import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BaseGrade extends StatelessWidget {

  double value;
  double charSize;
  String nullRatingReason;

  BaseGrade({
    this.nullRatingReason = '',
    this.value = 0,
    this.charSize = 11
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: nullRatingReason != '' ?  Container(
        alignment: Alignment.centerLeft,
        child: Text('$nullRatingReason',style: TextStyle(fontSize: charSize)),
      ):Row(
        children: <Widget>[
          RatingBarIndicator(
            rating:value / 2,
            alpha:0,
            unratedColor:Colors.grey,
            itemPadding: EdgeInsets.all(0),
            itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 12,
          ),
          SizedBox(width: ScreenAdapter.width(20)),
          Text('$value',style: TextStyle(fontSize: 12,color: Colors.grey))
        ],
      )
    );
  }
}