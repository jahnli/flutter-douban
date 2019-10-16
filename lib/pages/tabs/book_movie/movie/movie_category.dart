import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class MovieCategory extends StatelessWidget {

  final List _categoryList = [
    {'icon':'https://img3.doubanio.com/img/files/file-1531217330.png','title':'找电影','color':Color.fromRGBO(111, 152, 243, 1)},
    {'icon':'https://img1.doubanio.com/img/files/file-1531217298.png','title':'豆瓣榜单','color':Color.fromRGBO(242, 175, 54, 1)},
    {'icon':'https://img1.doubanio.com/img/files/file-1531217479.png','title':'豆瓣猜','color':Color.fromRGBO(93, 191, 85, 1)},
    {'icon':'https://img3.doubanio.com/img/files/file-1531217353.png','title':'豆瓣片单','color':Color.fromRGBO(137, 111, 217, 1)},
  ];

  @override
  Widget build(BuildContext context) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:_categoryList.map((item){
        return GestureDetector(
          onTap: (){
            print('${item['title']}');
            Application.router.navigateTo(context, '/doubanTop');
          },
          child: Column(
            children: <Widget>[
              Image.network(item['icon'],width: ScreenAdapter.width(90)),
              SizedBox(height: ScreenAdapter.height(20)),
              Text(item['title'])
            ],
          ),
        );
      }).toList(),
    );
  }
}