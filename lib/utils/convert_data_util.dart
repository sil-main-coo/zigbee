import 'package:monitor_sensor/models/nodes.dart';

class ConvertDataUtils {
  // t: 33.60^C#h: 64%
  static Node1? convertDataToNode1(String data) {
    try {
      final arr1 = data.split('#');
      if (arr1.length == 2) {
        final arr2 = arr1[0].split(":");
        final arr3 = arr1[1].split(":");

        if (arr2.length == 2 && arr3.length == 2) {
          final tempString = arr2[1].trim().replaceAll('^C', '');
          final humString = arr3[1].trim().replaceAll('%', '');

          return Node1(
              temp: double.tryParse(tempString), hum: int.parse(humString));
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Node2? convertDataToNode2(String data) {
    try {
      final arr1 = data.split('#');

      if (arr1.length == 2) {
        final arr2 = arr1[0].split(":");
        final arr3 = arr1[1].split(":");
        if (arr2.length == 2 && arr3.length == 2) {
          final co2String = arr2[1].trim().replaceAll('%', '');
          final luxString = arr3[1].trim().replaceAll('%', '');

          return Node2(co2: int.parse(co2String), lux: int.parse(luxString));
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
