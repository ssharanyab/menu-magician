import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static SharedPreferences? _sharedPreferences;

  factory SharedPreferenceService() {
    _instance ??= SharedPreferenceService._();
    return _instance!;
  }

  SharedPreferenceService._();

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static setMenuItem(String mealName, String menuItemsName) async {
    await _sharedPreferences?.setString(mealName, menuItemsName);
  }

  static getMenuItem(String mealName) async {
    return _sharedPreferences?.getString(mealName) ?? '';
  }
}
