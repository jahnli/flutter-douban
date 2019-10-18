import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class YearTopItem extends StatelessWidget {

  final Map data;
  final String honor;
  final String desc;
  YearTopItem(this.data,this.honor,this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(180),
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(int.parse('0xff' + data['subject']['color_scheme']['primary_color_dark'])),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: ClipPath(
              clipper: CustomCliper(),
              child: Image.network('${data['payload']['mobile_background_img']}',fit: BoxFit.cover,width: ScreenAdapter.width(300)),
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(
                top: ScreenAdapter.height(30),
                left: ScreenAdapter.height(30)
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text('${DateTime.now().year - 1}',style: TextStyle(color: Color(int.parse('0xff' + data['subject']['color_scheme']['primary_color_light'])),fontWeight: FontWeight.bold,fontSize: 28)),
                        ),
                      Positioned(
                        top: ScreenAdapter.height(10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('$desc',style: TextStyle(color: Colors.grey[300])),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: ScreenAdapter.height(10)),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('$honor',style: TextStyle(fontSize: 24)),
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }
   

}

class CustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width+ScreenAdapter.width(35),0)
      ..lineTo(size.height, size.width)
      ..lineTo(0, size.height)
      ..lineTo(size.width - ScreenAdapter.width(200), 0)
      ..close();
    return path;
  }
 //是否重新裁剪
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}