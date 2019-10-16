import 'dart:io';

import 'package:dio/dio.dart';

class NetUtils {

  static ajax(type,url,{Map params}) async {
    try{
      var res ;
      switch (type) {
        case 'get':
          Options options =  Options(
            headers: {
              HttpHeaders.userAgentHeader: 'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/6.23.0(167) Android/22 product/mi-4c vendor/xiaomi model/mi-4c  rom/android  network/wifi  platform/mobile com.douban.frodo/6.23.0(167) Rexxar/1.2.151  platform/mobile 1.2.151',
            }
          );
          res = await Dio().get(url,queryParameters: params,options:options);
          break;
        case 'post':
          res = await Dio().post(url,data: params);
          break;
        default:
      }
      return res;
    } 
    catch(e){ 
      print(e);
    }
  }

}