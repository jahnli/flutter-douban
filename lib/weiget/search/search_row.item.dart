import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class SearchRowItem extends StatelessWidget {

  final  data;
  SearchRowItem({
    @required this.data
  });

  @override
  Widget build(BuildContext context) {
    String imgUrl;
    String title;
    String desc;
    switch (data.layout) {
      case 'subject':
        imgUrl = data.target.coverUrl;
        title = data.target.title;
        desc = data.target.cardSubtitle;
        break;
      case 'group':
        imgUrl = data.target.avatar;
        title = data.target.name;
        desc = data.target.desc;
        break;  
      default:
    }
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '/filmDetail?id=${data.target.id}&type=${data.target.type}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
        padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.3,
              color: Colors.grey[300]
            )
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(imgUrl,width: ScreenAdapter.width(Configs.thumbHeight(size: 'miniWidth')),height: ScreenAdapter.height(ScreenAdapter.height(Configs.thumbHeight(size:'smaller'))),fit: BoxFit.cover),
            ),
            SizedBox(width: ScreenAdapter.width(20)),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('${data.typeName}',style: TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text('$title ${data.target.year != null ? '(${data.target.year})':''}',style: TextStyle(fontSize: ScreenAdapter.fontSize(36))),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child:Text('$desc',style: TextStyle(fontSize: ScreenAdapter.fontSize(26),color: Colors.grey)),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}