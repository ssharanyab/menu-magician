import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:menu_magician/models/menu_item_model.dart';
import 'package:menu_magician/widgets/meal_dropdown.dart';

import '../controllers/menu_controller.dart';
import '../utils/border_utils.dart';
import '../utils/meal_utils.dart';
import '../widgets/show_hide_menu_items.dart';

class SpinPage extends StatefulWidget {
  const SpinPage({
    Key? key,
    this.meal,
  }) : super(key: key);

  final Meals? meal;

  @override
  State<SpinPage> createState() => _SpinPageState();
}

class _SpinPageState extends State<SpinPage> {
  late Meals meal;

  late List<String> selectedMenu;
  late List<MenuItem> menuAll;

  MenuItemController menuItemController = Get.put(MenuItemController());
  Random random = Random();
  List<int> randomIndices = [];

  @override
  void initState() {
    super.initState();
    //meal = widget.meal ?? getMealFromTime();
    meal = Meals.lunch;
    menuAll = getMenuList() ?? [];
    selectedMenu = [];
    if (menuAll.length <= 10) {
      for (var item in menuAll) {
        selectedMenu.add(item.itemName);
      }
    } else {
      while (randomIndices.length < 10) {
        int index = random.nextInt(menuAll.length);
        if (!randomIndices.contains(index)) {
          randomIndices.add(index);
          selectedMenu.add(menuAll[index].itemName);
        }
      }
    }
    print(selectedMenu);
    print(menuItemController.isLoading.value);
    print(menuAll.length);
  }

  void onMealChanged(Meals value) {
    setState(() {
      meal = value;
    });
  }

  List<MenuItem>? getMenuList() {
    switch (meal) {
      case Meals.breakfast:
        return menuItemController.breakfastMenu;
      case Meals.lunch:
        return menuItemController.lunchMenu;
      case Meals.dinner:
        return menuItemController.dinnerMenu;
      default:
        return menuItemController.lunchMenu;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[100],
        elevation: 0.0,
      ),
      body: Obx(
        () => menuItemController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: menuAll.isEmpty
                    ? menuItemController.refreshMenu()
                    : Future.value(true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MealDropDown(
                            buildEnabledBorder: buildEnabledBorder(),
                            buildFocusedBorder: buildFocusedBorder(),
                            meal: meal,
                            onMealChanged: onMealChanged,
                            dropdownColor: Colors.lightGreen[100],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Text(
                                meal.mealName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowHideMenuItems(
                                          menuItems: getMenuList(),
                                        );
                                      });
                                },
                                label: Text(
                                  'Edit Items',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 300.0,
                            height: 300.0,
                            child: FortuneWheel(
                              items: [
                                for (var item in selectedMenu)
                                  FortuneItem(
                                    child: Text(
                                      item,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Text(
                            'Spin the wheel to decide what to eat!',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Spin'),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
