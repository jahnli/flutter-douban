import 'package:flutter/material.dart';

class Utils {
  // 计算是否上映
  static computeIsBeOn(pubdate){
    return  pubdate.isEmpty ? true : DateTime.now().isAfter(DateTime(DateTime.parse(pubdate).year, DateTime.parse(pubdate).month, DateTime.parse(pubdate).day));
  }

  // 转化颜色
  static colorTransform(color){
    return Color(int.parse('0xff' + color));
  }

  // 数字星期转化为文字
  static formatWeek(int weekNum){
    List<String> weekList = ['一','二','三','四','五','六','日'];
    return weekList[weekNum - 1];
  }
  // 时间线格式化
  static timeLine(time){
    int _second = 1 * 1000;
    int _minute = _second * 60;
    int _hour = _minute * 60;
    int _day = 24 * _hour;
    int _week = 7 * _day;
    int _month = 4 * _week;

    int _diff = DateTime.now().millisecondsSinceEpoch - DateTime.parse(time).millisecondsSinceEpoch;

    if(_diff > _month){
      return '${(_diff / _month).round()}月前';
    }else if(_diff > _day){
      return '${(_diff / _day).round()}天前';
    }else if(_diff > _hour){
      return '${(_diff / _hour).round()}小时前';
    }else if(_diff > _minute){
      return '${(_diff / _minute).round()}分钟前';
    }else if(_diff > _second){
      return '${(_diff / _second).round()}秒前';
    }

  }

}


