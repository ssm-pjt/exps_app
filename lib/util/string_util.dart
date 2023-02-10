
class StringUtil {
  static String getStringAmount(num? amount) {
    if (amount == null) {
      return "0";
    }

    String amt = amount.toString().split('').reversed.join();
    String result = "";
    int len = amt.length;

    for (int i = 0; i < amt.length; i++) {
      String a = amt.substring(i, i+1);
      if (i % 3 == 0 && i != 0) {
        result += ",";
      }

      result += a;

    }

    return result.split('').reversed.join();

  }

  static String getStringDate(String date) {
    return '${date.substring(0, 4)}년 ${date.substring(4, 6)}월 ${date.substring(6, 8)}일';
  }

  static String getStringTime(String time) {
    return '${time.substring(0, 2)}:${time.substring(2, 4)}:${time.substring(4, 6)}';
  }
}