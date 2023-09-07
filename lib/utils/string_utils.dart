import 'package:intl/intl.dart';

extension DateExtension on String {
  String get toDate {
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("yMMMd");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }

  int get toInt {
    return int.tryParse(this) ?? 0;
  }

  double get toDouble {
    return double.tryParse(this) ?? 0.0;
  }

  // String get toTimeAgo {
  //   DateTime date = DateTime.parse(this);
  //   return timeago.format(date).replaceAll(RegExp('about'), '');
  // }

  String get toTime {
    DateFormat.yMMMMd();
    DateTime date = DateTime.parse(this);
    var newFormat = DateFormat("jm");
    String updatedDt = newFormat.format(date);
    return updatedDt;
  }
}
