import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class DoubanTopList extends StatelessWidget {

  // 数据
  List dataList = [];
  DoubanTopList({this.dataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(380),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: dataList.asMap().keys.map((index){
          return GestureDetector(
            onTap: (){
              Application.router.navigateTo(context, '/movieTopDetail?index=$index');
            },
            child: Container(
              margin: EdgeInsets.only(right: index == 2 ? 0: ScreenAdapter.width(30)),
              child:_item(dataList[index],index),
            ),
          );
        }).toList()
      ),
    );
  }

  // 单独块
  Widget _item(data,cateIndex){
    return Container(
      width: ScreenAdapter.width(450),
      decoration: BoxDecoration(
        color: Color(int.parse('0xff'+'${data['background_color_scheme']['primary_color_dark']}')),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: <Widget>[
          Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.6,
                  child: ClipRRect(
                      child: Image.network('${data['header_bg_image']}',width:  ScreenAdapter.width(450),height: ScreenAdapter.height(Configs.thumbHeight(size: 'small')),fit: BoxFit.cover),borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight:Radius.circular(8))
                  ),
                ),
                Positioned(
                  bottom: ScreenAdapter.height(30),
                  left: ScreenAdapter.width(30),
                  child: Text('${data['name']}',style: TextStyle(fontSize: 24,color: Colors.white)),
                ),
                Positioned(
                  top: ScreenAdapter.height(40),
                  right: ScreenAdapter.width(30),
                  child: Text('${data['description']}',style: TextStyle(fontSize: 13,color: Colors.white)),
                )
              ],
            ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: data['items'].asMap().keys.map<Widget>((index){
                return Container(
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(5)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(350),
                        child:Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('${index+1}. ${data['items'][index]['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,height:1.5)),
                            ),
                            Container(
                              width: ScreenAdapter.width(50),
                              child:  Text('${data['items'][index]['rating']['value']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.orange,height:1.5)),
                            )
                          ],
                        ) ,
                      ),
                      cateIndex != 1 ? Icon(data['items'][index]['trend_up'] == true ? Icons.arrow_upward : Icons.arrow_downward,color: Colors.grey,size: 16) : Text('')
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}