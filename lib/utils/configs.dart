class Configs{

  // 缩略图告诉

  static thumbHeight ({size:'default'}){
    switch (size) {
      case 'default':
        return 230.0;
        break;
      case 'large':
        return 260.0;
        break;
      case 'small':
        return 190.0;
        break;
      default:
    }
  }

}