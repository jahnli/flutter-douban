class Configs{

  // 缩略图告诉

  static thumbHeight ({size:'default'}){
    switch (size) {
      // 影片详情 - 预告片
      case 'xlarge':
        return 300.0;
        break;
      // 影院热映
      case 'large':
        return 240.0;
        break;
      case 'default':
      // 详情页
        return 210.0;
        break;
      case 'small':
      // 影院热映列表和豆瓣热门列表
        return 200.0;
        break;
      default:
    }
  }

}