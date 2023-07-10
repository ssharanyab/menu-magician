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

  static setMenuItem(
      String mealName, String menuItemsName, int menuItemId) async {
    await _sharedPreferences?.setString(mealName, menuItemsName);
    await _sharedPreferences?.setInt('${mealName}Id', menuItemId);
  }

  static getMenuItemName(String mealName) async {
    return _sharedPreferences?.getString(mealName) ?? '';
  }

  static getMenuItemId(String mealName) async {
    return _sharedPreferences?.getInt('${mealName}Id') ?? -1;
  }
}
