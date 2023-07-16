import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_magician/controllers/menu_controller.dart';
import 'package:menu_magician/pages/home_page.dart';
import 'package:menu_magician/services/clear_data.dart';
import 'package:menu_magician/services/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService().init();
  await ClearData.clearData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Menu Magician',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const HomePage(),
      initialBinding: InitialBinding(),
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuItemController());
  }
}
