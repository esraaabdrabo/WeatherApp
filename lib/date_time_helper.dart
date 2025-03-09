import 'package:intl/intl.dart';

abstract class DateTimeHelper {
  static const formattingSchema = 'yyyy-MM-dd hh:mm';
  static DateTime parse(String dateTime) {
    return DateFormat(formattingSchema).parse(dateTime);
  }
}
