import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class HonorInfos extends StatelessWidget {

  final int rankText;
  final String title;

  HonorInfos({this.rankText,this.title});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
      child:Row(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(35),
            padding: EdgeInsets.only(left: ScreenAdapter.width(8),right: ScreenAdapter.width(8)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft:Radius.circular(2),
                bottomLeft:Radius.circular(2),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(255, 243, 230, 1),
                  Color.fromRGBO(254, 240, 179, 1),
                ]
              )
            ),
            child:Text('No.$rankText',style: TextStyle(fontSize: ScreenAdapter.fontSize(23),color: Color.fromRGBO(157, 95, 0, 1))),
          ),
          Container(
            height: ScreenAdapter.height(35),
            padding: EdgeInsets.only(left: ScreenAdapter.width(8),right: ScreenAdapter.width(8)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight:Radius.circular(2),
                bottomRight:Radius.circular(2),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(255, 197, 116, 1),
                  Color.fromRGBO(255, 197, 7, 1),
                ]
              )
            ),
            child:Text('$title',style: TextStyle(fontSize: ScreenAdapter.fontSize(23),color: Color.fromRGBO(157, 95, 0, 1))),
          )
        ],
      ),
    );
  }


}