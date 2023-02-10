
class DateUtil {
  static String getWeekday(int day) {
    switch(day) {
      case 7: return '일';break;
      case 1: return '월';break;
      case 2: return '화';break;
      case 3: return '수';break;
      case 4: return '목';break;
      case 5: return '금';break;
      case 6: return '토';break;
      default: return '';
    }
  }
}