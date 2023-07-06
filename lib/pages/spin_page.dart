import 'dart:async';
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

  // For the menu
  late List<MenuItem> menuItems;
  List<String> menuItemsNames = [];

  String selectedMenuItem = '';
  int selectedMenuItemIndex = 0;
  bool selectionMade = false;

  MenuItemController menuItemController = Get.put(MenuItemController());
  StreamController<int> selected = StreamController.broadcast();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    meal = widget.meal ?? getMealFromTime();
    getMenuItems();
    selected.stream.listen((value) {});
  }

  void getMenuItems() {
    menuItems = getMenuList() ?? [];
    if (menuItems.length <= 10) {
      for (var e in menuItems) {
        menuItemsNames.add(e.itemName);
      }
    } else {
      for (int i = 0; i < 10; i++) {
        int randomIndex = random.nextInt(menuItems.length);
        String randomElement = menuItems[randomIndex].itemName;
        menuItemsNames.add(randomElement);
      }
    }
  }

  void onMealChanged(Meals value) {
    setState(() {
      meal = value;
      menuItemsNames = [];
      getMenuItems();
    });
  }

  void updateMenuItems(List<String> selectedItems) {
    menuItemsNames = selectedItems;
    setState(() {});
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
      body: Container(
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
                              meal: meal,
                              menuItems: menuItems,
                              selectedItems: menuItemsNames,
                              updateSelectedItems: updateMenuItems,
                            );
                          });
                    },
                    label: const Text(
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
                child: menuItemsNames.length < 2
                    ? const Center(
                        child: Text(
                          'Please add and select at least 2 items to spin and decide!',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => spinWheel(),
                        onVerticalDragStart: (details) => spinWheel(),
                        onHorizontalDragStart: (details) => spinWheel(),
                        child: FortuneWheel(
                          animateFirst: false,
                          selected: selected.stream,
                          duration: const Duration(seconds: 5),
                          physics: CircularPanPhysics(
                            duration: Duration(seconds: 5),
                            curve: Curves.decelerate,
                          ),
                          onFling: () {
                            setState(() {
                              menuItemsNames.shuffle();
                            });
                          },
                          onAnimationStart: () {
                            setState(() {
                              selectionMade = false;
                            });
                          },
                          onAnimationEnd: () {
                            setState(() {
                              selectionMade = true;
                            });
                          },
                          items: [
                            for (var item in menuItemsNames)
                              FortuneItem(
                                child: Text(
                                  item,
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
              const Text(
                'Spin the wheel to decide what to eat!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectionMade
                  ? Text(
                      selectedMenuItem,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  print(selectedMenuItem);
                },
                child: const Text('Spin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void spinWheel() {
    selectedMenuItemIndex = Fortune.randomInt(0, menuItemsNames.length);
    setState(() {
      selected.add(selectedMenuItemIndex);
      selectedMenuItem = menuItemsNames[selectedMenuItemIndex];
    });
  }
}
