import 'package:flutter/material.dart';
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
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: Image.network(imgUrl,height:ScreenAdapter.height(Configs.thumbHeight(size: 'smaller')),width: ScreenAdapter.width(170),fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(5),
          ),
          SizedBox(width: ScreenAdapter.width(20)),
          Expanded(
            child: Container(
              height:ScreenAdapter.height(Configs.thumbHeight(size: 'smaller')),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('${data.typeName}',style: TextStyle(color: Colors.grey)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text('$title ${data.target.year != null ? '(${data.target.year})':''}',style: TextStyle(fontSize: 18)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text('$desc',style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}