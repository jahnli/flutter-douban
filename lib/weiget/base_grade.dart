import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BaseGrade extends StatelessWidget {

  final String _pubdate;
  final  _gradeCount;
  final  _grade;
  double charSize;
  BaseGrade(this._gradeCount,this._grade,this._pubdate,{this.charSize = 11});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Utils.computeIsBeOn(_pubdate) ? _gradeCount == '00' ? Container(
        alignment: Alignment.centerLeft,
        child: Text('暂无评分',style: TextStyle(fontSize: charSize)),
      ):Row(
        children: <Widget>[
          RatingBarIndicator(
            rating:_grade / 2,
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
          Text('$_grade',style: TextStyle(fontSize: 12,color: Colors.grey))
        ],
      ):Container(
        alignment: Alignment.centerLeft,
        child: Text('尚未上映',style: TextStyle(fontSize: charSize)),
      ),
    );
  }
}