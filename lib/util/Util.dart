import 'package:intl/intl.dart';

abstract class BaseUtil {
  String nowDatetimeString();
}

class Util implements BaseUtil {

  String nowDatetimeString() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(now);
    return formatted;
  }

  static bool isDebug() {
    return const bool.fromEnvironment('dart.vm.product');
  }

}