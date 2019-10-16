
import 'dart:io';
import 'package:dio/dio.dart';

class ApiConfig {

  static String baseUrl = 'https://api.douban.com'; 
  static String apiKey = '0b2bdeda43b5688921839c8ecb20399b'; 

  static String homeApi = 'https://frodo.douban.com/api/v2/movie/modules?loc_id=108288&udid=b176e8889c7eb022716e7c4195eceada4be0be40&rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&s=rexxar_new&channel=Douban&device_id=b176e8889c7eb022716e7c4195eceada4be0be40&os_rom=android&apple=f177f7210511568811cc414dd5ed6f50&icecream=7a77f8513a214ec8aaabf90e4ca99089&mooncake=3117c7243ba057a6c140fe27cee889a8&sugar=46000&_sig=2dcg1ysS3J5b9xNZDVRFcsKJ8zI%3D&_ts=1571195046';
  


  static ajax(type,url,params) async {
    try{
      var res ;
      switch (type) {
        case 'get':
          Options options =  Options(
            headers: {
            HttpHeaders.userAgentHeader: 'Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/6.23.0(167) Android/22 product/mi-4c vendor/xiaomi model/mi-4c  rom/android  network/wifi  platform/mobile com.douban.frodo/6.23.0(167) Rexxar/1.2.151  platform/mobile 1.2.151',
          });
          res = await Dio().get(url,queryParameters: params);
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