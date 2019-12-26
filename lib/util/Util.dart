import 'package:intl/intl.dart';

abstract class BaseUtil {
  String getNowDateAndTime();
}

class Util implements BaseUtil {

  String getNowDateAndTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(now);
    return formatted;
  }

}