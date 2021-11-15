import 'package:intl/intl.dart';

class ParseTime{
  static String dayWeek(int day){
    switch(day){
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        throw Exception('Invalid param day: $day');
    }
  }

  static String defaultDate(DateTime dateTime){
    final f = DateFormat('hh:mm');
    return f.format(dateTime);
  }
}