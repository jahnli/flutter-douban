import 'package:flutter/material.dart';
import 'package:flutter_douban/api/api_config.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_douban/weiget/custom_scroll_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ComingSoon extends StatefulWidget {
  @override
  _ComingSoonState createState() => _ComingSoonState();
}


class _ComingSoonState extends State<ComingSoon> with AutomaticKeepAliveClientMixin{

  // 保持状态
  bool get wantKeepAlive  => true;

  // 正在热映列表
  List _comingSoonList = [];
  List _dateList = [];
  List temp = [];
  // 分页
  int _start = 0;
  // 总数量
  int _total = 0;
  String _requestStatus = '';

  RefreshController _controller = RefreshController();

    @override
  void initState() { 
    super.initState();

    _getComingSoon();

  }

  // 获取即将上映列表数据
  _getComingSoon() async {
    try {
      Map<String,dynamic> params ={
        'apikey':ApiConfig.apiKey,
        'count':10,
        'start':_start
      };
      var res = await ApiConfig.ajax('get',ApiConfig.baseUrl +  '/v2/movie/coming_soon', params);
      // 定义临时数组
      List temp = [];
      for(var i = 0 ; i < res.data['subjects'].length;i++){
        // 定义验证日期
        String validate = res.data['subjects'][i]['pubdates'][res.data['subjects'][i]['pubdates'].length - 1].substring(0,10);
        // 如果日期列表里没有该日期，则添加该日期和空list待用
        if(_dateList.indexOf("$validate") == -1){
          _dateList.add(validate);
          temp.add({
            "date":validate,
            "list":[]
          });
        }else{
          // 如果有，循环旧数据列表，填充到对应日期的list中
          _comingSoonList.forEach((item){
            if(item['date'] == validate){
              item['list'].add(res.data['subjects'][i]);
            }
          });
        }
      }
      // 循环,拼接数据
      res.data['subjects'].forEach((value){
        temp.forEach((tempItem){ 
          if(tempItem['date'] == value['pubdates'][value['pubdates'].length - 1].substring(0,10)){
            tempItem['list'].add(value);
          }
        });
      });
      
      if(mounted){
        setState(() {
        _comingSoonList.addAll(temp); 
          _total = res.data['total'];
        });
      }
    }
    catch (e) {
      print(e);
    }

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  
    @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _controller,
      enablePullUp: true,
      enablePullDown: true,
      header: CustomScrollHeader(),
      footer: CustomScrollFooter(),
      onRefresh: () async {
        _controller.resetNoData();
        setState(() {
          _comingSoonList = [];
          _dateList=[];
          _start = 0;
        });
        await _getComingSoon();
        _controller.refreshCompleted();
      },
      onLoading: () async {
        if(_start + 10 < _total){
          setState(() {
            _start = _start + 10;
          });
          await _getComingSoon();
          _controller.loadComplete();
        }else{
          _controller.loadNoData();
        }
      },
      child: _comingSoonList.length > 0 ? ListView(
        children: <Widget>[
          Container(
            height: ScreenAdapter.height(80),
            padding: EdgeInsets.only(left: ScreenAdapter.width(30)),
            child: Row(
              children: <Widget>[
                Text('影视 $_total')
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Column(
                children: <Widget>[
                  Container(
                    height: ScreenAdapter.height(70),
                    alignment: Alignment.centerLeft,
                    color: Colors.grey[200],
                    padding: EdgeInsets.only(left: ScreenAdapter.width(30)),
                    child: Text('${_comingSoonList[index]['date']}',style: TextStyle(color: Colors.grey[600])),
                  ),
                  Column(
                    children: _comingSoonList[index]['list'].map<Widget>((item){
                      return Container(
                        margin: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30),top: ScreenAdapter.height(30)),
                        padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.5,
                              color: Colors.grey[300],
                            )
                          )
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Application.router.navigateTo(context, '/movieDetail?id=${item['id']}');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // 缩略图
                              _thumb(item), 
                              // 中间信息区域
                              SizedBox(width: ScreenAdapter.width(30)),
                              _info(item),
                              SizedBox(width: ScreenAdapter.width(30)),
                              // 右侧操作区域
                              _actions(item)
                            ],
                          ),
                        )
                      );
                    }).toList(),
                  )
                ],
              );
            },
            itemCount: _comingSoonList.length,
          )
        ],
      ):BaseLoading(type: _requestStatus),
    );
  }
  // 右侧操作区域
  Widget _actions(item){
    return Container(
      height: ScreenAdapter.height(220),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){

            },
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){

                  },
                  child:Image.network('http://cdn.jahnli.cn/favorite.png',width: ScreenAdapter.width(40)),
                ),
                SizedBox(height: ScreenAdapter.height(10)),
                Text('想看',style: TextStyle(fontSize: 12,color: Colors.orange))
              ],
            ),
          ),
          SizedBox(height: ScreenAdapter.height(10)),
          Text('${item['collect_count']}人想看',style: TextStyle(fontSize: 12,color: Colors.grey))
        ],
      )
    );
  }
  // 左侧缩略图
  Widget _thumb(item){
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network('${item['images']['small']}',width: ScreenAdapter.width(200),height: ScreenAdapter.height(220),fit: BoxFit.cover,),
    );
  }

  // 中间信息区域
  Widget _info(item){
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: ScreenAdapter.height(220)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
              child: Text('${item['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('${item['year']} ${item['directors'].length > 0 ? ' / ' + item['directors'][0]['name']:''}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.grey)),
            ),
            Container(
              height: ScreenAdapter.height(40),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: item['genres'].asMap().keys.map<Widget>((index){
                  return Text('${item['genres'][index]} ${index == item['genres'].length - 1 ? '':' / '}',style: TextStyle(fontSize: 12,color: Colors.grey));
                }).toList(),
              ),
            ),
            Container(
              height: ScreenAdapter.height(30),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: item['casts'].asMap().keys.map<Widget>((index){
                  return Text('${item['casts'][index]['name']} ${index == item['casts'].length - 1 ? '':' / '}',style: TextStyle(fontSize: 12,color: Colors.grey));
                }).toList(),
              ),
            )
          ],
        ),
      ), 
    );
  }
}