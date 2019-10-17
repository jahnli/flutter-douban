import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/film_item.dart';

class GridViewItems extends StatelessWidget {

  int crossAxisCount;
  double crossAxisSpacing;
  List data;
  double height;
  int itemCount;
  int currentType;
  GridViewItems({this.currentType = 1,this.itemCount,this.height = 480,this.crossAxisCount = 3,this.crossAxisSpacing:10,this.data});

  @override
  Widget build(BuildContext context) {
    print(data.length);
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics:NeverScrollableScrollPhysics() ,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: crossAxisCount,
          //纵轴间距
          //横轴间距
          crossAxisSpacing: crossAxisSpacing,
          //子组件宽高长度比例
          childAspectRatio: ScreenAdapter.getScreenWidth() / crossAxisCount /  ScreenAdapter.height(height)
        ),
        itemBuilder: (context,index){
           return FilmItem(data[index],currentType: currentType,);
        },
        itemCount: itemCount
      ),
    );
  }
}