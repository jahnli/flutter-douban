class Configs{

  // 缩略图告诉

  static thumbHeight ({size:'default'}){
    switch (size) {
      case 'large':
        return 240.0;
        break;
      case 'default':
        return 210.0;
        break;
      case 'small':
        return 200.0;
        break;
      default:
    }
  }

}