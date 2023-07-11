import 'package:menu_magician/services/shared_preference.dart';

class ClearData {
  static Future<int> clearData() async {
    // Clear data
    final now = DateTime.now();
    String today = '${now.day}-${now.month}-${now.year}';
    String time = await SharedPreferenceService.getTime();
    if (time == '-1') {
      await SharedPreferenceService.addTime(today);
    }
    if (time != today) {
      print('Clearing data');
      await SharedPreferenceService.clearData();
      await SharedPreferenceService.addTime(today);
    }
    return 0;
  }
}
