import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class RowTitle extends StatelessWidget {

  String title;
  int count;
  String url;
  bool showRightAction;

  RowTitle({@required this.title,this.showRightAction = true,this.count = 0,this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$title',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
          showRightAction ? GestureDetector(
            onTap: (){
              Application.router.navigateTo(context, url);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('全部 ${count == 0 ? '':count}',style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w600)),
                Icon(Icons.chevron_right)
              ],
            ),
          ):Container()
        ]
      ),
    );
  }
}