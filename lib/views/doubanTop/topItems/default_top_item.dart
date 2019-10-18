import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class DefaultTopItem extends StatelessWidget {

  final Map data;
  final bool showTrend;
  DefaultTopItem(this.data,{this.showTrend = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(int.parse('0xff' + data['background_color_scheme']['primary_color_dark'])),
      ),
      height: ScreenAdapter.height(170),
      child: Row(
        children: <Widget>[
           _title(
            iconFgImage:data['icon_fg_image'],
            mediumName:data['medium_name'],
            typeText:data['type_text'],
            bgColor:data['background_color_scheme']['primary_color_dark'],
          ),
          Expanded(
            child: _content(
              data:data['items'].sublist(0,3),
              bg:data['header_bg_image'],
              bgColor:data['background_color_scheme']['primary_color_dark'],
              showTrend:showTrend
            ),
          ),
        ],
      ),
    );
  }

  // 左侧头部
  Widget _title({iconFgImage,typeText,mediumName,bgColor}){
    return Container(
      width: ScreenAdapter.width(210),
      child: iconFgImage == null ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text('$typeText',style: TextStyle(color: Colors.grey[200])),
          ),
          SizedBox(height: ScreenAdapter.height(10)),
          Container(
            child: Text('$mediumName',style: TextStyle(fontSize: 20)),
          )
        ],
      ):Image.network('$iconFgImage',fit: BoxFit.cover),
    );
  }

    // 中间内容
  Widget _content({data,bg,bgColor,showTrend}){
    return Container(
      child:Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius:BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Image.network('$bg',fit: BoxFit.cover,width: ScreenAdapter.getScreenWidth()),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Opacity(
              child: Container(
                color: Color(int.parse('0xff'+bgColor))
              ),
              opacity: 0.7,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:data.asMap().keys.map<Widget>((index){
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('${index+1}.${data[index]['title']}'),
                          SizedBox(width: ScreenAdapter.width(10)),
                          Text('${data[index]['rating']['value']}',style: TextStyle(color: Color(int.parse('0xff' + 'ffac2d')))),
                        ],
                      ),
                      showTrend ? Icon(data[index]['trend_up'] == true ? Icons.arrow_upward : Icons.arrow_downward,color: Colors.grey,size: 16):Container()
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
  
}