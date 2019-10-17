import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class RowTitle extends StatelessWidget {

  String title;
  int count = 0;
  String url;

  RowTitle({@required this.title,this.count,this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$title',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
          GestureDetector(
            onTap: (){
              
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('全部 ${count == 0 ? '':count}',style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w600)),
                Icon(Icons.chevron_right)
              ],
            ),
          )
        ],
      ),
    );
  }
}