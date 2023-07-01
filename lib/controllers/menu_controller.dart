import 'package:get/get.dart';
import 'package:menu_magician/models/menu_item_model.dart';
import 'package:menu_magician/services/database_helper.dart';

class MenuItemController extends GetxController {
  final isLoading = false.obs;
  List<MenuItem>? menuItem;
  List<MenuItem>? breakfastMenu;
  List<MenuItem>? lunchMenu;
  List<MenuItem>? dinnerMenu;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchBreakfastMenu();
    fetchLunchMenu();
    fetchDinnerMenu();
  }

  fetchBreakfastMenu() async {
    try {
      isLoading(true);
      breakfastMenu = await DatabaseHelper.getBreakfastMenu();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  fetchLunchMenu() async {
    try {
      isLoading(true);
      lunchMenu = await DatabaseHelper.getLunchMenu();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  fetchDinnerMenu() async {
    try {
      isLoading(true);
      dinnerMenu = await DatabaseHelper.getDinnerMenu();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
