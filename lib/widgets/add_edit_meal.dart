import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_magician/models/menu_item_model.dart';

import '../services/database_helper.dart';
import '../utils/border_utils.dart';
import '../utils/meal_utils.dart';
import 'meal_dropdown.dart';

class AddEditMeal extends StatefulWidget {
  const AddEditMeal({
    required this.meal,
    required this.onRefresh,
    super.key,
    this.menuItem,
  });

  final Meals meal;

  final MenuItem? menuItem;

  final VoidCallback onRefresh;

  @override
  State<AddEditMeal> createState() => _AddEditMealState();
}

class _AddEditMealState extends State<AddEditMeal>
    with SingleTickerProviderStateMixin {
  // For the animation
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  // For the form
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _mealNameController = TextEditingController();
  final _mealDescriptionController = TextEditingController();

  late Meals _meal;

  @override
  void initState() {
    super.initState();

    // For the animation
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(
        parent: _controller, curve: Curves.easeInOutCubicEmphasized);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();

    // Initial value of the meal
    _meal = widget.meal;

    // If we are editing, set the initial values
    if (widget.menuItem != null) {
      _isEditing = true;
      _meal = Meals.values
          .where((element) => element.mealName == widget.menuItem!.meal)
          .first;
      _mealNameController.text = widget.menuItem!.itemName;
      _mealDescriptionController.text = widget.menuItem!.itemDescription;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMealChanged(Meals value) {
    setState(() {
      _meal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: Row(
                children: [
                  Text(
                    _isEditing ? 'Edit the item' : 'Add To Your Menu',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(CupertinoIcons.xmark_circle_fill,
                        color: Colors.red),
                    onPressed: Navigator.of(context).pop,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
          ],
        ),
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.33,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MealDropDown(
                    meal: _meal,
                    buildEnabledBorder: buildEnabledBorder(),
                    buildFocusedBorder: buildFocusedBorder(),
                    menuItem: widget.menuItem,
                    onMealChanged: onMealChanged,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _mealNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the item name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter the item name',
                      labelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: buildEnabledBorder(),
                      focusedBorder: buildFocusedBorder(),
                      errorBorder: buildErrorBorder(),
                      focusedErrorBorder: buildErrorBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _mealDescriptionController,
                    maxLines: 3,
                    minLines: 3,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the item description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Enter the item Description',
                      labelStyle: const TextStyle(
                        fontSize: 18.0,
                      ),
                      enabledBorder: buildEnabledBorder(),
                      focusedBorder: buildFocusedBorder(),
                      errorBorder: buildErrorBorder(),
                      focusedErrorBorder: buildErrorBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              final itemName = _mealNameController.text;
              final itemDescription = _mealDescriptionController.text;
              if (itemName.isEmpty || itemDescription.isEmpty) {
                _formKey.currentState!.validate();
                return;
              }
              final menuItem = MenuItem(
                itemName: itemName,
                itemDescription: itemDescription,
                meal: _meal.mealName,
                id: widget.menuItem?.id,
              );

              if (_isEditing) {
                // Update the item
                await DatabaseHelper.updateMenuItem(menuItem);
              } else {
                // Add the item
                await DatabaseHelper.insertMenuItem(menuItem);
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                widget.onRefresh();
              });
            },
            label: Text(
              _isEditing ? 'Save' : 'Add',
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                side: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            icon: const Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
            ),
          ),
        ],
        actionsPadding:
            const EdgeInsets.only(right: 25.0, bottom: 20.0, top: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          side: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
