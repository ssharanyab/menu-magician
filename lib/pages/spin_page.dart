import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:menu_magician/models/menu_item_model.dart';
import 'package:menu_magician/widgets/meal_dropdown.dart';

import '../controllers/menu_controller.dart';
import '../services/shared_preference.dart';
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

  // For the menu selection
  String selectedMenuItem = '';
  int selectedMenuItemIndex = 0;
  bool selectionMade = false;

  // For the wheel
  bool initialSpin = true;
  bool spinning = false;

  // Controllers
  MenuItemController menuItemController = Get.put(MenuItemController());
  StreamController<int> selected = StreamController.broadcast();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    meal = widget.meal ?? getMealFromTime();
    getMenuItems();
    showMenu().then((value) {
      if (value != null) {
        selectedMenuItem = value;
        selectionMade = true;
      }
    });
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
      showMenu().then((value) {
        print(value != null);
        print(value);
        if (value != null) {
          selectedMenuItem = value;
          selectionMade = true;
          initialSpin = true;
          spinning = false;
        } else {
          initialSpin = true;
          spinning = false;
          selectionMade = false;
        }
      });
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

  Future<String?> showMenu() async {
    String? menu;
    menu = await SharedPreferenceService.getMenuItem(meal.mealName);
    return menu;
  }

  void saveMenu() async {
    await SharedPreferenceService.setMenuItem(
      meal.mealName,
      selectedMenuItem,
    );
    String menu = await SharedPreferenceService.getMenuItem(meal.mealName);
    print(menu);
  }

  void spinWheel() {
    selectedMenuItemIndex = Fortune.randomInt(0, menuItemsNames.length);
    setState(() {
      selected.add(selectedMenuItemIndex);
      selectedMenuItem = menuItemsNames[selectedMenuItemIndex];
    });
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
                  const Spacer(),
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
              const SizedBox(height: 30.0),
              SizedBox(
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
                              initialSpin = false;
                              spinning = true;
                            });
                          },
                          onAnimationEnd: () {
                            setState(() {
                              selectionMade = true;
                              spinning = false;
                            });
                            saveMenu();
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
              const SizedBox(height: 50.0),
              menuItemsNames.length > 2
                  ? SizedBox(
                      width: 350.0,
                      child: selectionMade
                          ? RichText(
                              text: TextSpan(
                                  text: 'You are eating ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: selectedMenuItem,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightGreen[900],
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'for your',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    TextSpan(
                                      text: ' ${meal.mealName}!',
                                      style: TextStyle(
                                        color: Colors.lightGreen[900],
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    const TextSpan(
                                      text:
                                          '\n\nSpin again if you don\'t like it!',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            )
                          : initialSpin
                              ? const Text(
                                  'Spin the wheel to decide what to eat!',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : const Text(
                                  'Spinning...',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ))
                  : const SizedBox.shrink(),
              const SizedBox(height: 20.0),
              !spinning && menuItemsNames.length > 2
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () => spinWheel(),
                      child: initialSpin
                          ? const Text('Spin Now')
                          : const Text('Spin Again'),
                    )
                  : const SizedBox.shrink(),
              ElevatedButton(
                onPressed: () {
                  showMenu();
                },
                child: const Text('Show Menu'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
